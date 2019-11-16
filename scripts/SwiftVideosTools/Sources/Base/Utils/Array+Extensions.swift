//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

    public mutating func merge<C : Collection>(with newElements: C) where C.Iterator.Element == Element {
        let filteredList = newElements.filter({!self.contains($0)})
        self += filteredList
    }
}
