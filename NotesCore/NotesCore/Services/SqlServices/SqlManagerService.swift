
import Foundation
import SQLite3

public enum SqlManagerColumnTypeMapper {
    case integer
    case text
}

public class SqlManagerService {
    let loggerService: LoggerService
    let fileManagerService: FileManagerService

    public init(
        loggerService: LoggerService = LoggerService(
            logFrom: "SqlManagerService"
        ),
        fileManagerService: FileManagerService
    ) {
        self.loggerService = loggerService
        self.fileManagerService = fileManagerService
    }

    deinit {
        closeDb()
    }

    private var db: OpaquePointer?

    private func closeDb() {
        if sqlite3_close(db) == SQLITE_OK {
            loggerService.verbose("db connection closed")
            return
        }

        // error
        loggerService.error(
            "db close operation failed: \(sqliteErrorMessage())"
        )
    }

    private var dbPath: String {
        fileManagerService.documentsPath().path() + NOTE_DB_NAME
    }

    private func createDBSchema() -> Result<Never> {
        if sqlite3_prepare_v2(
            db,
            CREATE_NOTES_TABLE,
            -1,
            &db,
            nil
        ) == SQLITE_OK, sqlite3_step(db) == SQLITE_DONE {
            loggerService.verbose("db schema created")
            return Result.success()
        }

        // error
        let errorMessage = "error creating db schema: \(sqliteErrorMessage())"
        return Result.error(
            message: errorMessage
        )
    }

    private func sqliteErrorMessage() -> String {
        return String(cString: sqlite3_errmsg(db))
    }

    public func openDB() -> Result<Never> {
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
                createDBSchema()
        }

        // 3- error
        let errorMessage = "db connection failed: \(sqliteErrorMessage())"
        return Result.error(
            message: errorMessage
        )
    }

    public func multipleRowsQuery(
        query: String,
        resultColumnMapper: [SqlManagerColumnTypeMapper]
    ) -> Result<[Int: [Any]]> {
        // validation
        if resultColumnMapper.isEmpty {
            return Result.error(message: "empty result mapper")
        }

        // setup output
        var output: [Int: [Any]] = [:]
        for (index, _) in resultColumnMapper.enumerated() {
            output[index] = []
        }

        // run query
        var selectStatement: OpaquePointer?
        if sqlite3_prepare(
            db,
            query,
            -1,
            &selectStatement,
            nil
        ) == SQLITE_OK {
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
            return Result.success(data: output)
        }

        // error
        let errorMessage = "query: \(query) - not executed: \(sqliteErrorMessage())"
        return Result.error(
            message: errorMessage
        )
    }
}
