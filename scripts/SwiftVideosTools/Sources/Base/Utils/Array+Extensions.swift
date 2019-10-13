//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

extension Array where Element: Encodable {

    public var prettyPrintedString: String? {
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

extension Array where Element: Equatable {

    public mutating func merge<C : Collection>(with newElements: C) where C.Iterator.Element == Element {
        let filteredList = newElements.filter({!self.contains($0)})
        self += filteredList
    }
}
