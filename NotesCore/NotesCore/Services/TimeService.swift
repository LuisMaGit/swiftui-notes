import Foundation

public class TimeService {
    public init() {}
    public func convertStringToDate(source: String?) -> Date? {
        if let source {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.date(from: source)
        }

        return nil
    }
}
