//
//  APIPath.swift
//  Crypto Market
//
//  Created by Vishal22 Sharma on 13/08/22.
//

import Foundation

#if DEBUG
let environment = APIEnvironment.development
#else
let environment = APIEnvironment.production
#endif

let baseURL = environment.baseURL()

struct APIPath {
    var gallary: String { return "\(baseURL)/v2/assets?limit=20&offset=0"}
}
