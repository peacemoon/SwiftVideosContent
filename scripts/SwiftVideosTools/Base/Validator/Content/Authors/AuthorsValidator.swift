//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation
import Files
import ColorizeSwift

public class AuthorsValidator {

    // MARK: Properties

    // Private

    private var basePath: String

    var listPath: String {
        return basePath.combinePath("authors.json")
    }

    private lazy var rootAuthorsFolder: Folder = {
        do {
            return try Folder(path: basePath)
        } catch {
            fatalError("\(error)".red())
        }
    }()

    private let listValidator = JSONValidator<AuthorsList>()

    // MARK: Initialization

    public init(rootContentPath: String) {
        self.basePath = rootContentPath.combinePath("authors")
    }

    // MARK: APIs

    func validateList() -> Bool {
        do {
            print("listPath = \(listPath)".lightBlue())
            let file = try File(path: listPath)
            let content = try file.read()
            return try listValidator.validate(data: content)
        } catch {
            print("\(error)".red())
            return false
        }
    }
}
