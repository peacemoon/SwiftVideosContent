//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation
import Files
import ColorizeSwift

/// Generate list of authors based on the list of videos.
public class AuthorsGenerator {

    // MARK: Properties

    // Private

    private var baseAuthorsPath: String
    private var baseVideosPath: String

    private var authors = AuthorsList()

    // MARK: Initialization

    public init(rootContentPath: String) {
        self.baseAuthorsPath = rootContentPath.combinePath("authors")
        self.baseVideosPath = rootContentPath.combinePath("videos")
    }

    // MARK: APIs

    public func generate() {
        // Iterate through list of conferences
        do {
            let videosFolder = try Folder(path: baseVideosPath)
            let videosFile = try videosFolder.file(named: "videos.json")
            let videosContent = try videosFile.read()
            let jsonDecoder = JSONDecoder()
            let videos = try jsonDecoder.decode(VideosList.self, from: videosContent)
            authors = videos.reduce(into: AuthorsList(), { result, videoMetaData in
                result.merge(with: videoMetaData.authors)
            })
            try export()
        } catch {
            print("\(error)".red())
        }
    }

    public func export() throws {
        guard let authorsString = authors.prettyPrintedString else {
            return
        }
        let authorsFolder = try Folder(path: baseAuthorsPath)
        let outputFile = try authorsFolder.createFile(named: "authors.json")
        try outputFile.write(string: authorsString)

        print("Authors are exported successfully".lightCyan())
    }
}

extension Array where Element: Equatable {

    public mutating func merge<C : Collection>(with newElements: C) where C.Iterator.Element == Element {
        let filteredList = newElements.filter({!self.contains($0)})
        self += filteredList
    }
}
