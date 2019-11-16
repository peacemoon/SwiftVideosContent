//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

extension Encodable {

    var jsonPrettyPrintedString: String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted

        do {
            let data = try jsonEncoder.encode(self)
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
