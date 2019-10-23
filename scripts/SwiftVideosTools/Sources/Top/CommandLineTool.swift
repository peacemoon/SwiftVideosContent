//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CommandRegistry

public final class CommlandLineTool {

    // MARK: Properties

    // Private

    private var commandRegistry: CommandRegistry
    private let arguments: [String]


    // MARK: Initialization

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
        commandRegistry = CommandRegistry(usage: "<subcommand> <options>", overview: "Tools to manage database for SwiftVideos app")
        registerCommands()
    }

    // MARK: APIs

    public func run() {
        commandRegistry.run()
    }

    // MARK: Private helpers

    private func registerCommands() {

        // Conferences
        let conferencesCommand = commandRegistry.register(command: ConferencesCommand.self)
        commandRegistry.register(subcommand: AuthorsValidationCommand.self, parent: conferencesCommand)

        // Authors
        let authorsCommand = commandRegistry.register(command: AuthorsCommand.self)
        commandRegistry.register(subcommand: AuthorsValidationCommand.self, parent: authorsCommand)
        commandRegistry.register(subcommand: AuthorsGenerationCommand.self, parent: authorsCommand)

        // Videos
        let videosCommand = commandRegistry.register(command: VideosCommand.self)
        commandRegistry.register(subcommand: VideosValidationCommand.self, parent: videosCommand)
        commandRegistry.register(subcommand: VideosCreateCommand.self, parent: videosCommand)
        commandRegistry.register(subcommand: VideosGenerationCommand.self, parent: videosCommand)
        commandRegistry.register(subcommand: VideosYoutubePreviewGenerationCommand.self, parent: videosCommand)
        commandRegistry.register(subcommand: VideosVimeoPreviewGenerationCommand.self, parent: videosCommand)
    }
}
