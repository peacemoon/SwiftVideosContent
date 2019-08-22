//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CommandRegistry
import SPMUtility
import ColorizeSwift
import Foundation

class VideosCommand: Command {

    // MARK: Properties

    // Static

    let command = "videos"
    let overview = "Manage/Validate videos list"

    // Private

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    // MARK: Initialization

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
    }

    // MARK: APIs

    func run(with arguments: ArgumentParser.Result) throws {
        print("[Error] videos: validate or generate".red())
    }
}
