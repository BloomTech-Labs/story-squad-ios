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
    case unexpectedStatusCode
    case badDecode
    case unauthorized
    case noData
    case unableToPost
}
