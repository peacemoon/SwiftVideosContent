//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CommandRegistry
import SPMUtility
import ColorizeSwift
import Foundation

class VideosValidationCommand: Command {

    // MARK: Properties

    // Static

    let command = "validate"
    let overview = "Validate the list of videos"

    // Private

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    private var path: PositionalArgument<String>

    // MARK: Initialization

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
        path = subparser.add(positional: "path", kind: String.self, usage: "Path to root content folder")
    }

    // MARK: APIs

    func run(with arguments: ArgumentParser.Result) throws {
        guard let rootContentPath = arguments.get(path) else {
            print("[Error] Content path is missing".red())
            return
        }
        let videosValidator = VideosValidator(rootContentPath: rootContentPath)

        do {
            try videosValidator.validateList()
            print("[Success] Videos list is valid".lightCyan())
        } catch {
            print("[Error] \(error)".red())
        }
    }
}
