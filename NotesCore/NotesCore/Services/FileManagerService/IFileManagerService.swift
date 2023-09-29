import Foundation

//sourcery: AutoMockable
public protocol IFileManagerService {
    func documentsPath() -> URL
    func existsFileInDocumments(file: String) -> Bool
}
