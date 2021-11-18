//
//  Extension+URLComponents.swift
//  SPNetwork
//
//  Created by Amit Sharma on 18/11/21.
//

import Foundation
extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
