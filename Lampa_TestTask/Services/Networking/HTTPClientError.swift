//
//  HTTPClientError.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 06.12.2020.
//

import Foundation


enum HTTPClientError: Error {
    case emptyURL(message: String)
    case responseStatusError(message: String)
}

extension HTTPClientError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .responseStatusError(message):
            return "\(message)"
        case let .emptyURL(message):
            return "\(message)"
        }
    }
}
