//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

extension String {

    public func combinePath(_ component: String) -> String {
        return NSString(string: self).appendingPathComponent(component)
    }

    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
