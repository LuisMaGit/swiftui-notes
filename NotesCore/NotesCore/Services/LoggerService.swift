
import Foundation
import OSLog

public class LoggerService {
    let logFrom: String
    private let logger: Logger

    public init(logFrom: String) {
        self.logFrom = logFrom
        logger = Logger()
    }

    private func buildLog(_ value: String) -> String {
        return "\(logFrom) - \(value)"
    }

    private func buildAndLog(
        value: String,
        logger: (_ fullLog: String) -> Void
    ) {
        logger(buildLog(value))
    }

    public func verbose(_ value: String) {
        #if DEBUG
            buildAndLog(
                value: value,
                logger: { fullLog in
                    logger.log("\(fullLog)")
                }
            )
        #endif
    }

    public func error(_ value: String) {
        buildAndLog(
            value: value,
            logger: { fullLog in
                logger.error("\(fullLog)")
            }
        )
    }
}
