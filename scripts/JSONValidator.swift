import Foundation
import Files

//protocol Validator {
//    associatedtype DataType: Decodable
//    func validate(data: Data, type: DataType.Type) -> Bool
//}
//
//class JSONValidator<T: Decodable>: Validator {
//
//    func validate(data: Data) -> Bool {
//        return validate(data: data, type: T.self)
//    }
//
//    func validate(data: Data, type: T.Type) -> Bool {
//        let decoder = JSONDecoder()
//        do {
//            try decoder.decode(type, from: data)
//            return true
//        } catch {
//            return false
//        }
//    }
//}
//
//class AuthorValidator {
//    var basePath: String
//    let listValidator = JSONValidator<AuthorMetaData>()
//
//    init(basePath: String) {
//        self.basePath = basePath
//    }
//}

print(CommandLine.arguments)

for file in try Folder(path: "authors").files {
    print(file.name)
}