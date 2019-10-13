//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation
import Files
import ColorizeSwift

/// CRUD actions for conferences.
public class ConferencesManager {

    // MARK: Properties

    // Private

    private var baseConferencesPath: String

    // MARK: Initialization

    public init(rootContentPath: String) {
        self.baseConferencesPath = rootContentPath.combinePath("conferences")
    }

    // MARK: APIs

    public func create() {}

    public func update() {}

    public func delete() {}

}
