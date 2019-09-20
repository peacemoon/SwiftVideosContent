//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation
import Files
import ColorizeSwift

public class VideosValidator {

    // MARK: Properties

    // Private

    private var basePath: String

    var listPath: String {
        return basePath.combinePath("videos-1.json")
    }

    private lazy var rootAuthorsFolder: Folder = {
        do {
            return try Folder(path: basePath)
        } catch {
            fatalError("[Error] \(error)".red())
        }
    }()

    private let listValidator = JSONValidator<VideosList>()

    // MARK: Initialization

    public init(rootContentPath: String) {
        self.basePath = rootContentPath.combinePath("videos")
    }

    // MARK: APIs

    func validateList() throws {
        print("[Debug] listPath = \(listPath)".lightBlue())
        let file = try File(path: listPath)
        let content = try file.read()
        _ = try listValidator.validate(data: content)
    }
}
