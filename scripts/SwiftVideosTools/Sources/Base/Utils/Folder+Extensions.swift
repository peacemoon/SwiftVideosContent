//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Files
import Foundation

extension Folder {
    var isConferenceFolder: Bool {
        return self.containsFile(named: "conference.json")
    }

    var isConferenceEditionFolder: Bool {
        return self.name.isNumber && self.containsFile(named: "videos.json")
    }
}
