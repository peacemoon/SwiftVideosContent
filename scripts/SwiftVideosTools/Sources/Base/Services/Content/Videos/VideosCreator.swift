//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation
import Files
import ColorizeSwift

/// Add a video into the videos list of a conference edition.
class VideosCreator {

    // MARK: Properties

    // Private

    private var videosFolderPath: String
    private var video: VideoMetaData

    //private var video: VideoMetaData

    // MARK: Initialization

    init(conferenceFolderPath: String, name: String, id: VideoID, conference: VideoConferenceInfo, authors: AuthorsList, source: VideoSource) {
        self.videosFolderPath = conferenceFolderPath
        video = VideoMetaData(id: id, authors: authors, conference: conference, name: name, source: source)
    }

    // MARK: APIs

    func create() {
        do {
            var videosList = try readVideosList()
            videosList.append(video)
            try export(videosList)
        } catch {
            print("[Error] \(error)".red())
        }
    }

    // public func generate() {
    //     do {
    //         let jsonDecoder = JSONDecoder()
    //         // Iterate through list of conferences
    //         try Folder(path: baseConferencesPath).makeSubfolderSequence().forEach { conferenceFolder in
    //             if conferenceFolder.isConferenceFolder {
    //                 // Iterate through list of editions in this conference
    //                 conferenceFolder.makeSubfolderSequence().forEach { editionFolder in
    //                     if editionFolder.isConferenceEditionFolder {
    //                         do {
    //                             let file = try editionFolder.file(named: "videos.json")
    //                             let content = try file.read()
    //                             let editionVideos = try jsonDecoder.decode(VideosList.self, from: content)

    //                             videos += editionVideos
    //                         } catch {
    //                             print("\(error)".red())
    //                         }
    //                     }
    //                 }
    //             }
    //         }

    //         try export()
    //     } catch {
    //         print("[Error] \(error)".red())
    //     }
    // }

    // MARK: Private helpers

    private func readVideosList() throws -> VideosList {
        print("[Debug] videosPath = \(videosFolderPath)".lightBlue())

        let videosFolder = try Folder(path: videosFolderPath)

        guard let videosFile = try? videosFolder.file(named: "videos.json") else {
            return VideosList()
        }

        let contentData = try videosFile.read()
        let decoder = JSONDecoder()
        let videosList = try decoder.decode(VideosList.self, from: contentData)
        return videosList
    }

    private func export(_ videosList: VideosList) throws {
        guard let videosString = videosList.prettyPrintedString else {
            return
        }

        let videosFolder = try Folder(path: videosFolderPath)

        let outputFile = try videosFolder.createFile(named: "videos.json")
        try outputFile.write(string: videosString)

        print("Videos are added successfully".lightCyan())
    }
}
