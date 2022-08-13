//
//  CryptoMarketModel.swift
//  Crypto Market
//
//  Created by Vishal22 Sharma on 13/08/22.
//

import Foundation

// MARK: - CryptoMarketModel
struct CryptoMarketModel: Codable {
    let data: [Crypto]?
}

// MARK: - Crypto
struct Crypto: Codable {
    let id, rank, symbol, name: String?
    let supply, maxSupply, marketCapUsd, volumeUsd24Hr: String?
    let priceUsd, changePercent24Hr, vwap24Hr: String?
    let explorer: String?
}
