//
//  APIEnvironment.swift
//  Crypto Market
//
//  Created by Vishal22 Sharma on 13/08/22.
//

import Foundation

enum APIEnvironment {
    case development
    case staging
    case production

    func baseURL () -> String {
        return "https://\(subdomain()).\(domain())"
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return "coincap.io"
        case .staging:
            return "coincap.io"
        case .production:
            return "coincap.io"
        }
    }
    
    func subdomain() -> String {
        switch self {
        case .development, .production, .staging:
            return "api"
        }
    }
}
