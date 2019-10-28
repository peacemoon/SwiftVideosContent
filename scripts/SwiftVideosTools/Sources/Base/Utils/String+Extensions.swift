//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

extension String {

    func combinePath(_ component: String) -> String {
        return NSString(string: self).appendingPathComponent(component)
    }

    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }

    var idfied: String {
        let spaceSet = CharacterSet.whitespaces
        let alphaSet = CharacterSet.alphanumerics
        let set = spaceSet.union(alphaSet)
        var result = self.trimmed.removingCharacters(in: set.inverted).condensedWhitespace
        result = result.lowercased().replacingOccurrences(of: " ", with: "-")
        return result
    }

    var condensedWhitespace: String {
        return self.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
    }

    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    func removingCharacters(in set: CharacterSet) -> String {
        let filtered = unicodeScalars.lazy.filter { !set.contains($0) }
        return String(String.UnicodeScalarView(filtered))
    }
}
