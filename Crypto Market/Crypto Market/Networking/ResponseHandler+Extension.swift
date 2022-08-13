//
//  ResponseHandler+Extension.swift
//  Crypto Market
//
//  Created by Vishal22 Sharma on 13/08/22.
//

import Foundation

// MARK: Response Handler - parse default

struct ServiceError: Error,Codable {
    let httpStatus: Int
    let message: String
}

extension ResponseHandler {
    // MARK: - Generic Function for Parsing
    func defaultParseResponse<T: Codable>(data: Data,responseType: T.Type , response: HTTPURLResponse) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let body = try jsonDecoder.decode(responseType.self, from: data)
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: "Unknown Error")
            }
        } catch  {
            throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription)
        }
        
    }
}
