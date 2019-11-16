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
    private var videoMetaData: VideoMetaData
    private var videoDetail: VideoDetail

    //private var video: VideoMetaData

    // MARK: Initialization

    init(conferenceFolderPath: String, name: String, description: String?, id: VideoID, conference: VideoConferenceInfo, authors: AuthorsList, source: VideoSource) {
        self.videosFolderPath = conferenceFolderPath
        videoMetaData = VideoMetaData(id: id, authors: authors, conference: conference, name: name, source: source, createdAt: Date().timeIntervalSince1970)
        videoDetail = VideoDetail(metaData: videoMetaData, description: description, resources: nil)
    }

    // MARK: APIs

    func create() {
        do {
            var videosList = try readVideosList()
            videosList.append(videoMetaData)
            try export(videosList)
            try exportVideoDetail()
        } catch {
            print("[Error] \(error)".red())
        }
    }

    // MARK: Private helpers

    private func readVideosList() throws -> VideosList {
        print("[Debug] videosPath = \(videosFolderPath)".lightBlue())

        let videosFolder = try prepareFolder(at: videosFolderPath)

        guard let videosFile = try? videosFolder.file(named: "videos.json") else {
            return VideosList()
        }

        let contentData = try videosFile.read()
        let decoder = JSONDecoder()
        let videosList = try decoder.decode(VideosList.self, from: contentData)
        return videosList
    }

    private func export(_ videosList: VideosList) throws {
        guard let videosString = videosList.jsonPrettyPrintedString else {
            return
        }

        let videosFolder = try Folder(path: videosFolderPath)

        let outputFile = try videosFolder.createFile(named: "videos.json")
        try outputFile.write(string: videosString)

        print("Videos are added successfully".lightCyan())
    }

    private func exportVideoDetail() throws {
        guard let videoString = videoDetail.jsonPrettyPrintedString else {
            return
        }

        let videosFolder = try Folder(path: videosFolderPath)

        let outputFile = try videosFolder.createFile(named: "\(videoDetail.metaData.id).json")
        try outputFile.write(string: videoString)

        print("Video \(videoDetail.metaData.id) are exported successfully".lightCyan())

    }

    private func prepareFolder(at path : String) throws -> Folder {
        return try Folder.createFolderIfNeeded(at: path)
    }
}

extension Folder {

    static func createFolderIfNeeded(at folderPath: String) throws -> Folder {
        let fileManager = FileManager.default

        try fileManager.createDirectory(
            atPath: folderPath,
            withIntermediateDirectories: true
        )

        return try Folder(path: folderPath)
    }
}