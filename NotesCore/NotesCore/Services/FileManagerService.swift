
import Foundation

public class FileManagerService {
    private let fileManager = FileManager.default
    func documentsPath() -> URL {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    func existsFileInDocumments(file: String) -> Bool {
        return fileManager.fileExists(
            atPath: "\(documentsPath().path())\(file)"
        )
    }
}
