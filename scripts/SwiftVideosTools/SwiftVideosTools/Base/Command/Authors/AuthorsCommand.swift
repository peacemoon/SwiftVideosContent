//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CommandRegistry
import SPMUtility
import ColorizeSwift
import Foundation

class AuthorsCommand: Command {

    // MARK: Properties

    // Static

    let command = "authors"
    let overview = "Manage/Validate authors list"

    // Private

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    // MARK: Initialization

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
    }

    // MARK: APIs

    func run(with arguments: ArgumentParser.Result) throws {
        print("[Error] authors: validate or generate".red())
    }
}
