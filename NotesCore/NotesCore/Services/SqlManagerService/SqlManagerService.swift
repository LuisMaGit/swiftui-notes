
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

    private func createDBSchema() -> Result<Never> {
        var createStatement: OpaquePointer?
        if sqlite3_prepare_v2(
            db,
            CREATE_NOTES_TABLE,
            -1,
            &createStatement,
            nil
        ) == SQLITE_OK,
            sqlite3_step(createStatement) == SQLITE_DONE
        {
            loggerService.verbose("db schema created")
            sqlite3_finalize(createStatement)
            return Result.success()
        }

        // error
        let errorMessage = "error creating db schema: \(sqliteErrorMessage())"
        return Result.error(
            message: errorMessage
        )
    }

    private func createDBSchemaAndInsertDefData() -> Result<Never> {
        // create db schema
        let resultCreateSchema = createDBSchema()
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

    private func sqliteErrorMessage() -> String {
        return String(cString: sqlite3_errmsg(db))
    }

    func openDB() -> Result<Never> {
        // 1- check for file
        let dbFileExists = fileManagerService.existsFileInDocumments(
            file: NOTE_DB_NAME
        )

        // 2- file exists-> open connection.
        // file no exists -> open connection an create schema
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            loggerService.verbose("db connection opened at: \(dbPath)")
            return dbFileExists ?
                Result.success() :
//                createDBSchema()
                createDBSchemaAndInsertDefData()
        }

        // 3- error
        let errorMessage = "db connection failed: \(sqliteErrorMessage())"
        return Result.error(
            message: errorMessage
        )
    }

    func closeDb() {
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
    ) -> AnyResult<[Int: [Any]]> {
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
        if case let .error(message: message) = openDB() {
            return AnyResult.error(message: message)
        }

        // run query
        var result: AnyResult<[Int: [Any]]>
        var selectStatement: OpaquePointer?
        if sqlite3_prepare(
            db,
            query,
            -1,
            &selectStatement,
            nil
        ) == SQLITE_OK { // success
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                for (index, map) in resultColumnMapper.enumerated() {
                    switch map {
                    case .integer:
                        let result = sqlite3_column_int(
                            selectStatement, Int32(index)
                        )
                        output[index]?.append(Int(result))
                    case .text:
                        if let result = sqlite3_column_text(
                            selectStatement, Int32(index)
                        ) {
                            output[index]?.append(String(cString: result))
                        } else {
                            output[index]?.append("")
                        }
                    }
                }
            }
            sqlite3_finalize(selectStatement)
            loggerService.verbose(
                """
                  query: \(query)\n
                  result: \(String(describing: output))
                """
            )
            result = AnyResult.success(data: output)
        } else { // error
            let errorMessage = "query: \(query) - not executed: \(sqliteErrorMessage())"
            result = AnyResult.error(
                message: errorMessage
            )
        }

        closeDb()
        return result
    }
}
