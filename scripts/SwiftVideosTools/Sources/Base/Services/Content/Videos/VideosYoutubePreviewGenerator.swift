//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation
import Files
import ColorizeSwift

/// Generate list of youtube preview images for a list of videos.
public class VideosYoutubePreviewGenerator {

    // MARK: Properties

    // Private

    private var baseConferenceEditionPath: String
    private var urlBuilder: YoutubeURLBuilderProtocol

    // MARK: Initialization

    public init(baseConferenceEditionPath: String, urlBuilder: YoutubeURLBuilderProtocol = YoutubeURLBuilder()) {
        self.baseConferenceEditionPath = baseConferenceEditionPath
        self.urlBuilder = urlBuilder
    }

    // MARK: APIs

    public func generate() {
        do {
            let conferenceEditionFolder = try Folder(path: baseConferenceEditionPath)
            let videos = try readVideoList()
            for video in videos {
                switch video.source {
                case .youtube(let id):
                    let url = urlBuilder.youtubeURL(for: id)
                    let filename = video.id + ".jpg"
                    let data = try Data(contentsOf: url)
                    try conferenceEditionFolder.createFileIfNeeded(withName: filename, contents: data)

                default:
                    break
                }
            }
            print("Youtube preview images are downloaded successfully".lightCyan())
        } catch {
            print("[Error] \(error)".red())
        }
    }

    // MARK: Private helpers

    private func readVideoList() throws -> VideosList {
        let jsonDecoder = JSONDecoder()
        let conferenceEditionFolder = try Folder(path: baseConferenceEditionPath)
        let file = try conferenceEditionFolder.file(named: "videos.json")
        let content = try file.read()
        return try jsonDecoder.decode(VideosList.self, from: content)
    }
}

public struct YoutubeURLBuilder: YoutubeURLBuilderProtocol {

    public init() {}

    public func youtubeURL(for id: String) -> URL {
        return URL(string: "https://i1.ytimg.com/vi/\(id)/hqdefault.jpg")!
    }
}

public protocol YoutubeURLBuilderProtocol {
    func youtubeURL(for id: String) -> URL
}

enum VideosYoutubePreviewGeneratorError: Error {
    case notAYoutubeVideo
}