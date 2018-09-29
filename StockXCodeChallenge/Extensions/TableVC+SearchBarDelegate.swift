//
//  TableVC+SearchBarDelegate.swift
//  StockXCodeChallenge
//
//  Created by may on 2018-07-11.
//  Copyright © 2018 sohaeb. All rights reserved.
//

import Foundation
import UIKit

extension TableViewController: UISearchBarDelegate {
    
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    /*
     * This method takes the input from searchBar and
     * pass it as an arg to getSearchResults(_:)
     */
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            print("no text")
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let stringURL = Constants.REDDIT_URL + "/r/\(searchText)/.json"
        
        downloadService.getSearchResults(url: stringURL) { (results, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let results = results {
                self.arrayOfChildren = results
                self.tableView.reloadData()
            }
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
    }
}
