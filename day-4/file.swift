import Foundation

public struct File {
    func read(_ path: String) -> String? {
        let url = URL(fileURLWithPath: path)
        do {
            let contents = try String(contentsOf: url)
            return contents
        } catch {
            print(error)
            return nil
        }
    }
}