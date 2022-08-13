//
//  CryptoMarketCell.swift
//  Crypto Market
//
//  Created by Vishal22 Sharma on 13/08/22.
//

import UIKit

class CryptoMarketCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var changePercentLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // MARK: - Configure Crypto Market Cell
    func configureCryptoMarketCell(cryptoData: Crypto) {
        self.nameLabel.text = cryptoData.name
        let percentDetail = getValueAndColor(value: cryptoData.changePercent24Hr ?? "")
        let priceDetail = getValueAndColor(value: cryptoData.priceUsd ?? "")
        
        self.changePercentLabel.text = "\(percentDetail.value)%"
        self.changePercentLabel.textColor = percentDetail.color
        self.priceLabel.text = "$\(priceDetail.value)"
        self.priceLabel.textColor = percentDetail.color
    }
    // MARK: - Formate String & Color for Value
    func getValueAndColor(value: String) -> (value: String, color: UIColor) {
        let color = Double(value) ?? 0 < 0 ? UIColor.red  : UIColor.green
        return (String(format: "%.2f", Double(value) ?? ""), color)
    }
}
