//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CommandRegistry
import SPMUtility
import ColorizeSwift
import Foundation

class VideosVimeoPreviewGenerationCommand: Command {

    // MARK: Properties

    // Static

    let command = "vimeo_preview"
    let overview = "Download the list Vimeo preview images for a list of videos"

    // Private

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    private var path: PositionalArgument<String>

    // MARK: Initialization

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
        path = subparser.add(positional: "path", kind: String.self, usage: "Path to the folder containing videos.json")
    }

    // MARK: APIs

    func run(with arguments: ArgumentParser.Result) throws {
        guard let baseConferenceEditionPath = arguments.get(path) else {
            print("[Error] Path to the conference's edition is missing".red())
            return
        }
        let videosVimeoPreviewGenerator = VideosVimeoPreviewGenerator(baseConferenceEditionPath: baseConferenceEditionPath)
        videosVimeoPreviewGenerator.generate()
    }
}
