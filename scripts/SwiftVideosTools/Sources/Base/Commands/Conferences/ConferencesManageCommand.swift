//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CommandRegistry
import SPMUtility
import ColorizeSwift
import Foundation

class ConferencesManagerCommand: Command {

    // MARK: Properties

    // Static

    let command = "manage"
    let overview = "Regenerate the list of videos"

    // Private

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    private var subcommand: PositionalArgument<String>
    private var path: PositionalArgument<String>

    // MARK: Initialization

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
        subcommand = subparser.add(positional: "subcommand", kind: String.self, usage: "Subcommand")
        path = subparser.add(positional: "path", kind: String.self, usage: "Path to root content folder")
    }

    // MARK: APIs

    func run(with arguments: ArgumentParser.Result) throws {
        guard let subcommand = arguments.get(subcommand) else {
            print("[Error] Subcommand is missing".red())
            return
        }

        guard let rootContentPath = arguments.get(path) else {
            print("[Error] Content path is missing".red())
            return
        }
        let conferencesManager = ConferencesManager(rootContentPath: rootContentPath)
        switch subcommand {
        case "create":
            conferencesManager.create()
        case "update":
            conferencesManager.update()
        case "delete":
            conferencesManager.delete()
        default:
            print("[Error] invalid subcommand".red())
        }
    }
}
