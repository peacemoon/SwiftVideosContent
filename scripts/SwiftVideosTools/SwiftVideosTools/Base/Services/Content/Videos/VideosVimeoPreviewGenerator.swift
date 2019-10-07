//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation
import Files
import ColorizeSwift

/// Generate list of Vimeo preview images for a list of videos.
public class VideosVimeoPreviewGenerator {

    // MARK: Properties

    // Private

    private var baseConferenceEditionPath: String
    private var urlBuilder: VimeoURLBuilderProtocol

    // MARK: Initialization

    public init(baseConferenceEditionPath: String, urlBuilder: VimeoURLBuilderProtocol = VimeoURLBuilder()) {
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
                case .vimeo(let resource):
                    let url = try decodeVimeoVideo(for: resource)
                    let filename = video.id + ".jpg"
                    let data = try Data(contentsOf: url)
                    try conferenceEditionFolder.createFileIfNeeded(withName: filename, contents: data)

                default:
                    break
                }
            }
            print("Vimeo preview images are downloaded successfully".lightCyan())
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

    private func decodeVimeoVideo(for resource: VimeoResourceData) throws -> URL {
        let url = urlBuilder.vimeoURL(for: resource.video)
        let jsonDecoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        let vimeoVideo = try jsonDecoder.decode(VimeoVideo.self, from: data)
        return URL(string: vimeoVideo.thumbnail_url_with_play_button)!
    }
}

public struct VimeoVideo: Decodable {
    var thumbnail_url_with_play_button: String
}

public struct VimeoURLBuilder: VimeoURLBuilderProtocol {

    public init() {}

    public func vimeoURL(for id: String) -> URL {
        return URL(string: "https://vimeo.com/api/oembed.json?url=https://vimeo.com/\(id)")!
    }
}

public protocol VimeoURLBuilderProtocol {
    func vimeoURL(for id: String) -> URL
}

enum VideosVimeoPreviewGeneratorError: Error {
    case notAVimeoVideo
}