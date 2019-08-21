//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

protocol Validator {
    associatedtype DataType: Decodable
    func validate(data: Data, type: DataType.Type) throws -> Bool
}
