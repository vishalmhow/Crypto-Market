//
//  CryptoMarketViewModel.swift
//  Crypto Market
//
//  Created by Vishal22 Sharma on 13/08/22.
//

import Foundation

struct CryptoMarketViewModel {
    // MARK: - API Call to get Crypto Market Data
    func getAPIData(completion: @escaping (CryptoMarketModel?, ServiceError?) -> ()) {
        let request = CryptoMarketAPI()
        
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: ["":""]) { (model, error) in
            if let _ = error {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
}
