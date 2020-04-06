//
//  NetworkingError.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case noBearer
    case serverError(Error)
    case badDecode
    case unauthorized
    case noData
    case unexpectedStatusCode(Int)
    case badEncoding
    case noRepresentation
    case formattedJSONIncorrectly
    case missingRequiredElement
}
