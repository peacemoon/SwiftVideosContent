//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation
import Files
import ColorizeSwift

/// Generate list of videos based on the list of videos in conferences.
public class VideosGenerator {

    // MARK: Properties

    // Private

    private var baseConferencesPath: String
    private var baseVideosPath: String

    private var videos = VideosList()

    // MARK: Initialization

    public init(rootContentPath: String) {
        self.baseConferencesPath = rootContentPath.combinePath("conferences")
        self.baseVideosPath = rootContentPath.combinePath("videos")
    }

    // MARK: APIs

    public func generate() {
        do {
            let jsonDecoder = JSONDecoder()
            // Iterate through list of conferences
            try Folder(path: baseConferencesPath).makeSubfolderSequence().forEach { conferenceFolder in
                if conferenceFolder.isConferenceFolder {
                    // Iterate through list of editions in this conference
                    conferenceFolder.makeSubfolderSequence().forEach { editionFolder in
                        if editionFolder.isConferenceEditionFolder {
                            do {
                                let file = try editionFolder.file(named: "videos.json")
                                let content = try file.read()
                                let editionVideos = try jsonDecoder.decode(VideosList.self, from: content)

                                videos += editionVideos
                            } catch {
                                print("\(error)".red())
                            }
                        }
                    }
                }
            }

            try export()
        } catch {
            print("[Error] \(error)".red())
        }
    }

    public func export() throws {
        guard let videosString = videos.prettyPrintedString else {
            return
        }

        let videosFolder = try Folder(path: baseVideosPath)

        let outputFile = try videosFolder.createFile(named: "videos-1.json")
        try outputFile.write(string: videosString)

        print("Videos are exported successfully".lightCyan())
    }
}

extension Folder {
    var isConferenceFolder: Bool {
        return self.containsFile(named: "conference.json")
    }

    var isConferenceEditionFolder: Bool {
        return self.name.isNumber && self.containsFile(named: "videos.json")
    }
}

extension String {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

extension Array where Element: Encodable {
    var prettyPrintedString: String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let data = try jsonEncoder.encode(self)
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
