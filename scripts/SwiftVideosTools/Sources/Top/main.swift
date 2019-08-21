import Foundation
import ColorizeSwift

// swift run --package-path scripts/SwiftVideosTools/ .

let rootContentPath = "/Users/atran/Desktop/Projects/iOS/SwiftVideosContent/content"

let videosGenerator = VideosGenerator(rootContentPath: rootContentPath)
videosGenerator.generate()

let authorsGenerator = AuthorsGenerator(rootContentPath: rootContentPath)
authorsGenerator.generate()
