//
//  APILoader.swift
//  Crypto Market
//
//  Created by Vishal22 Sharma on 13/08/22.
//

import Foundation

struct APILoader<T: APIHandler> {
    var apiHandler: T
    var urlSession: URLSession
    
    init(apiHandler: T, urlSession: URLSession = .shared) {
        self.apiHandler = apiHandler
        self.urlSession = urlSession
    }
    
    func loadAPIRequest(requestData: T.RequestDataType, completionHandler: @escaping (T.ResponseDataType?, ServiceError?) -> ()) {
        if let urlRequest = apiHandler.makeRequest(from: requestData) {
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    guard error == nil else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }
                    
                    guard let responseData = data else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }
                    
                    do {
                        let parsedResponse = try self.apiHandler.parseResponse(data: responseData, response: httpResponse)
                         completionHandler(parsedResponse, nil)
                    } catch {
                         completionHandler(nil, ServiceError(httpStatus:  httpResponse.statusCode, message: "ServiceError : \(error.localizedDescription)"))
                    }
                }
            }.resume()
        }
    }
}
