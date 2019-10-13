//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

class JSONValidator<T: Decodable>: Validator {

    func validate(data: Data) throws -> Bool {
        return try validate(data: data, type: T.self)
    }

    func validate(data: Data, type: T.Type) throws -> Bool {
        let decoder = JSONDecoder()
        _ = try decoder.decode(type, from: data)
        return true
    }
}
