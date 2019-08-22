//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CommandRegistry
import SPMUtility
import ColorizeSwift
import Foundation

class AuthorsGenerationCommand: Command {

    // MARK: Properties

    // Static

    let command = "generate"
    let overview = "Regenerate the list of authors"

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
        let videosGenerator = VideosGenerator(rootContentPath: rootContentPath)
        videosGenerator.generate()
    }
}
