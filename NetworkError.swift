//
//  File.swift
//  SPNetwork
//
//  Created by Amit Sharma on 18/11/21.
//

import Foundation
public enum NetworkError: Error{
    case missingURL
    case dataNotFound
}
extension NetworkError: LocalizedError{
    public var errorDescription: String?{
        switch self {
        case .missingURL:
            return "NetworkError: URL not found."
        case .dataNotFound:
            return "NetworkError: Data not found."
        }
    }
}
