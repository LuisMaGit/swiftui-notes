import Foundation

//sourcery: AutoMockable
public protocol IFileManagerService {
    func documentsPath() -> URL
    func existsFileInDocuments(file: String) -> Bool
}
