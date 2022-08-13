//
//  ViewController.swift
//  Crypto Market
//
//  Created by Vishal22 Sharma on 13/08/22.
//

import UIKit

class CryptoMarketVC: UIViewController {
    public var cryptoMarketViewModel = CryptoMarketViewModel()
    @IBOutlet weak var cryptoTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var dataSource: [Crypto]?
    private var searchedDataSource: [Crypto]?
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.searchTextField.backgroundColor = UIColor(red: 50/255.0, green: 50/255.0, blue: 55/255.0, alpha: 1.0)
        self.searchBar.searchTextField.textColor = .white
        self.searchBar.showsCancelButton = true
        self.getCryptoMarketData()
        Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.getCryptoMarketData), userInfo: nil, repeats: true)
    }
    
    // MARK: - Get Crypto Market Data
    @objc func getCryptoMarketData() {
        
        if Reachability.isConnectedToNetwork() == false {
            let alert = UIAlertController(title: Constants.Validations.kOfflineTitle, message: Constants.Validations.kOfflineMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.Validations.kOkay, style: .default, handler: { (action: UIAlertAction!) in
            }))
            present(alert, animated: true, completion: nil)
        }
        cryptoMarketViewModel.getAPIData(completion: { (cryptoMarketModel, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: Constants.Validations.kError, message: error?.message, preferredStyle: UIAlertController.Style.alert)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                if let cryptoMarketModel = cryptoMarketModel {
                    self.dataSource = cryptoMarketModel.data
                    DispatchQueue.main.async {
                        self.cryptoTableView?.reloadData()
                    }
                }
            }
        })
    }
}

// MARK: - UITableview Extention for its delegates and DataSource Implementation
extension CryptoMarketVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return searchedDataSource?.count ?? 0
        } else {
            return dataSource?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoMarketCell", for: indexPath) as? CryptoMarketCell else {
            return UITableViewCell()
        }
        if searching {
            if let cryptoData = searchedDataSource?[indexPath.row] {
                cell.configureCryptoMarketCell(cryptoData: cryptoData)
            }
        } else {
            if let cryptoData = dataSource?[indexPath.row] {
                cell.configureCryptoMarketCell(cryptoData: cryptoData)
            }
        }
        
        
        return cell
    }
}

// MARK: - UISearchBar Deleget methods
extension CryptoMarketVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedDataSource = dataSource!.filter { $0.name!.lowercased() == searchText.lowercased() }
        
        guard let dataSource = dataSource else { return }
        searchedDataSource = dataSource.filter { obj -> Bool in
            guard let name = obj.name else { return false }
            return name.lowercased().contains(searchText.lowercased())
        }
        searching = true
        self.cryptoTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        self.cryptoTableView.reloadData()
    }
}
