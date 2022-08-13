//
//  CryptoMarketAPI.swift
//  Crypto Market
//
//  Created by Vishal22 Sharma on 13/08/22.
//

import Foundation

struct CryptoMarketAPI: APIHandler {
    
    // MARK: - Interactor for API call
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        let urlString =  APIPath().gallary
        if var url = URL(string: urlString) {
            if param.count > 0 {
                url = setQueryParams(parameters: param, url: url)
            }
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> CryptoMarketModel {
        return try defaultParseResponse(data: data,responseType: CryptoMarketModel.self ,response: response)
    }
}
