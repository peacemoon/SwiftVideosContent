//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CommandRegistry
import SPMUtility
import ColorizeSwift
import Foundation

class VideosCreateCommand: Command {

    // MARK: Properties

    // Static

    let command = "create"
    let overview = "Create a new videos list for a conference edition"

    // Private

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    private var _path: PositionalArgument<String>
    private var _conferenceName: PositionalArgument<String>
    private var _conference: PositionalArgument<String>
    private var _conferenceEdition: PositionalArgument<String>

    // MARK: Initialization

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
        _path = subparser.add(positional: "path", kind: String.self, usage: "The path of the content folder")
        _conferenceName = subparser.add(positional: "conferenceName", kind: String.self, usage: "The name of the conference")
        _conference = subparser.add(positional: "conference", kind: String.self, usage: "The identifier of the conference")
        _conferenceEdition = subparser.add(positional: "conferenceEdition", kind: String.self, usage: "The edition of the conference")
    }

    // MARK: APIs

    func run(with arguments: ArgumentParser.Result) throws {
        guard let path = arguments.get(_path) else {
            print("[Error] The path of the content folder is missing".red())
            return
        }

        guard let conferenceName = arguments.get(_conferenceName) else {
            print("[Error] The identifier of the conference is missing".red())
            return
        }

        guard let conference = arguments.get(_conference) else {
            print("[Error] The identifier of the conference is missing".red())
            return
        }

        guard let conferenceEditionString = arguments.get(_conferenceEdition), let conferenceEdition = Int(conferenceEditionString) else {
            print("[Error] The edition of the conference is missing".red())
            return
        }

        while true {
            print("Name: ".yellow())
            guard let rawName = readLine() else {
                throw VideosCreateCommandError.invalidName
            }

            let name = rawName.condensedWhitespace
            let id = "\(conference)_\(conferenceEdition)_\(name.idfied)"
            print("id = \(id)")

            print("Authors (comma separated): ".yellow())
            guard let rawAuthors = readLine() else {
                throw VideosCreateCommandError.invalidAuthors
            }

            var authors = AuthorsList()
            for authorName in rawAuthors.split(separator: ",") {
                let authorID = String(authorName).trimmed.idfied
                print(authorID)
                authors.append(AuthorMetaData(id: authorID, name: String(authorName).trimmed))
            }

            print("Video Source (1: youtube, 2: vimeo): ".yellow())
            guard let sourceType = readLine() else {
                throw VideosCreateCommandError.invalidType
            }

            print("Video ID: ".yellow())
            guard let resourceID = readLine() else {
                throw VideosCreateCommandError.invalidID
            }

            var videoSource: VideoSource!
            switch sourceType {
                case "1":
                    videoSource = VideoSource(type: "youtube", resourceID: resourceID)
                case "2":
                    videoSource = VideoSource(type: "vimeo", resourceID: resourceID)
                default:
                    exit(1)
            }

            let conferenceFolderPath = path.combinePath("conferences").combinePath(conference).combinePath(conferenceEditionString)
            let videoConferenceInfo = VideoConferenceInfo(metaData: ConferenceMetaData(id: conference, name: conferenceName), edition: ConferenceEdition(year: conferenceEdition))
            let videosCreator = VideosCreator(conferenceFolderPath: conferenceFolderPath, name: name, id: id, conference: videoConferenceInfo, authors: authors, source: videoSource)
            videosCreator.create()
        }
    }
}


enum VideosCreateCommandError: Error {
    case invalidName
    case invalidAuthors
    case invalidType
    case invalidID
}
