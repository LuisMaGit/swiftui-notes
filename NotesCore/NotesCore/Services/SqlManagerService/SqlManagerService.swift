
import Foundation
import SQLite3

class SqlManagerService: ISqlManagerService {
    let loggerService: LoggerService
    let fileManagerService: IFileManagerService
    
    public init(
        loggerService: LoggerService = LoggerService(
            logFrom: "SqlManagerService"
        ),
        fileManagerService: IFileManagerService
    ) {
        self.loggerService = loggerService
        self.fileManagerService = fileManagerService
    }
    
    private var db: OpaquePointer?
    
    private var dbPath: String {
        fileManagerService.documentsPath().path() + NOTE_DB_NAME
    }
    
    private func sqliteErrorMessage() -> String {
        return String(cString: sqlite3_errmsg(db))
    }
    
    private func createNotesTable() async -> Result<Never> {
        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(
            db,
            CREATE_NOTES_TABLE,
            -1,
            &createTableStatement,
            nil
        ) == SQLITE_OK,
            sqlite3_step(createTableStatement) == SQLITE_DONE
        {
            loggerService.verbose("db schema created")
            sqlite3_finalize(createTableStatement)
            return Result.success()
        }
        
        // error
        let errorMessage = "error creating db schema: \(sqliteErrorMessage())"
        return Result.error(
            message: errorMessage
        )
    }
    
    private func createNotesTrigger() async -> Result<Never>{
        var createTriggerStatement: OpaquePointer?
        if sqlite3_prepare_v2(
            db,
            CREATE_UPDATE_LAST_EDIT_DATE_TRIGGER,
            -1,
            &createTriggerStatement,
            nil
        ) == SQLITE_OK,
            sqlite3_step(createTriggerStatement) == SQLITE_DONE
        {
            loggerService.verbose("update_last_edit notes trigger created")
            sqlite3_finalize(createTriggerStatement)
            return Result.success()
        }

        // error
        let errorMessage = "error creating update_last_edit notes trigger: \(sqliteErrorMessage())"
        return Result.error(
            message: errorMessage
        )
    }
    
    private func createDBSchema() async -> Result<Never> {
        // create notes table
        let resultCreateNotesTable = await createNotesTable()
        if resultCreateNotesTable != Result.success() {
            return resultCreateNotesTable
        }
        
        // create notes trigger
        return await createNotesTrigger()
    }
    
    private func createDBSchemaAndInsertDefData() async -> Result<Never> {
        // create db schema
        let resultCreateSchema = await createDBSchema()
        if resultCreateSchema != Result.success() {
            return resultCreateSchema
        }
        
        // insert dumb data
        var insertStatment: OpaquePointer?
        if sqlite3_prepare_v2(
            db,
            INSERT_DUMB_DATA_NOTES_TABLE,
            -1,
            &insertStatment,
            nil
        ) == SQLITE_OK,
            sqlite3_step(insertStatment) == SQLITE_DONE
        {
            loggerService.verbose("inserted default values")
            sqlite3_finalize(insertStatment)
            return Result.success()
        }
        let errorMessage =
            """
                query: \(INSERT_DUMB_DATA_NOTES_TABLE) -
                not executed: \(sqliteErrorMessage())
            """
        loggerService.error(errorMessage)
        return Result.error(message: errorMessage)
    }
    
    func openDB() async -> Result<Never> {
        // 1- check for file
        let dbFileExists = fileManagerService.existsFileInDocuments(
            file: NOTE_DB_NAME
        )
        
        // 2- file exists-> open connection.
        // file no exists -> open connection an create schema
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            loggerService.verbose("db connection opened at: \(dbPath)")
            return dbFileExists ?
                Result.success() :
                //                createDBSchema()
                await createDBSchemaAndInsertDefData()
        }
        
        // 3- error
        let errorMessage = "db connection failed: \(sqliteErrorMessage())"
        return Result.error(
            message: errorMessage
        )
    }
    
    func closeDb() async {
        if sqlite3_close(db) == SQLITE_OK {
            loggerService.verbose("db connection closed")
            return
        }
        
        // error
        loggerService.error(
            "db close operation failed: \(sqliteErrorMessage())"
        )
    }
    
    func multipleRowsQuery(
        query: String,
        resultColumnMapper: [SqlManagerColumnTypeMapper]
    ) async -> AnyResult<[Int: [Any]]> {
        // validation
        if resultColumnMapper.isEmpty {
            return AnyResult.error(message: "empty result mapper")
        }
        
        // setup output
        var output: [Int: [Any]] = [:]
        for (index, _) in resultColumnMapper.enumerated() {
            output[index] = []
        }
        
        // open db
        if case let .error(message: message) = await openDB() {
            return AnyResult.error(message: message)
        }
        
        // run query
        var result: AnyResult<[Int: [Any]]>
        var multipleRowStatement: OpaquePointer?
        if sqlite3_prepare(
            db,
            query,
            -1,
            &multipleRowStatement,
            nil
        ) == SQLITE_OK { // success
            while sqlite3_step(multipleRowStatement) == SQLITE_ROW {
                for (index, map) in resultColumnMapper.enumerated() {
                    switch map {
                    case .integer:
                        let result = sqlite3_column_int(
                            multipleRowStatement, Int32(index)
                        )
                        output[index]?.append(Int(result))
                    case .text:
                        if let result = sqlite3_column_text(
                            multipleRowStatement, Int32(index)
                        ) {
                            output[index]?.append(String(cString: result))
                        } else {
                            output[index]?.append("")
                        }
                    }
                }
            }
            sqlite3_finalize(multipleRowStatement)
            loggerService.verbose(
                """
                  query: \(query)\n
                  result: \(String(describing: output))
                """
            )
            result = AnyResult.success(data: output)
        } else { // error
            let errorMessage = "query: \(query) - not executed: \(sqliteErrorMessage())"
            loggerService.error(errorMessage)
            result = AnyResult.error(
                message: errorMessage
            )
        }
        
        await closeDb()
        return result
    }
    
    func noResultQuery(
        query: String
    ) async -> Result<Never> {
        // open db
        if case let .error(message: message) = await openDB() {
            return Result.error(message: message)
        }
        
        var sqlStatement: OpaquePointer?
        if sqlite3_prepare_v2(
            db,
            query,
            -1,
            &sqlStatement,
            nil
        ) == SQLITE_OK &&
            sqlite3_step(sqlStatement) == SQLITE_DONE
        {
            let result = sqlite3_column_int(
                sqlStatement, 0
            )
            loggerService.verbose(
                """
                  query: \(query)\n
                  result: \(String(describing: result))
                """
            )
            sqlite3_finalize(sqlStatement)
            await closeDb()
            return Result.success()
        }
        
        let errorMessage = "query: \(query) - not executed: \(sqliteErrorMessage())"
        loggerService.error(errorMessage)
        return Result.error(
            message: errorMessage
        )
    }
    
    func singleRowQuery(
        query: String,
        resultColumnMapper: [SqlManagerColumnTypeMapper]
    ) async -> AnyResult<[Int: Any]> {
        // validation
        if resultColumnMapper.isEmpty {
            return AnyResult.error(message: "empty result mapper")
        }
        
        // setup output
        var output: [Int: Any] = [:]

        // open db
        if case let .error(message: message) = await openDB() {
            return AnyResult.error(message: message)
        }
        
        // run query
        var result: AnyResult<[Int: Any]>
        var singleRowStatement: OpaquePointer?
        
        if sqlite3_prepare(
            db,
            query,
            -1,
            &singleRowStatement,
            nil
        ) == SQLITE_OK &&
            sqlite3_step(singleRowStatement) == SQLITE_ROW
        {
            for (index, map) in resultColumnMapper.enumerated() {
                switch map {
                case .integer:
                    let result = sqlite3_column_int(
                        singleRowStatement, Int32(index)
                    )
                    output[index]? = Int(result)
                case .text:
                    if let result = sqlite3_column_text(
                        singleRowStatement, Int32(index)
                    ) {
                        output[index] = String(cString: result)
                    } else {
                        output[index] = ""
                    }
                }
            }
            sqlite3_finalize(singleRowStatement)
            loggerService.verbose(
                """
                  query: \(query)\n
                  result: \(String(describing: output))
                """
            )
            result = AnyResult.success(data: output)
        } else {
            let errorMessage = "query: \(query) - not executed: \(sqliteErrorMessage())"
            loggerService.error(errorMessage)
            result = AnyResult.error(
                message: errorMessage
            )
        }
        
        await closeDb()
        return result
    }
}
