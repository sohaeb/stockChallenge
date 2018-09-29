//
//  TableViewController.swift
//  StockXCodeChallenge
//
//  Created by may on 2018-07-11.
//  Copyright © 2018 sohaeb. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let downloadService = Downloader()
    var arrayOfChildren = [Children]()
    
    // MARK:- Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK:- Computed vars
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    
    lazy var downloadClosure : (Downloader) -> () = { (query) in
        
        query.getSearchResults(url: Constants.ALL) { (results, error) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let error = error {
                print("Error is \(error.localizedDescription)")
            } else if let results = results {
                self.arrayOfChildren = results
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK:- View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        downloadClosure(downloadService)
    }
}

extension TableViewController {
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfChildren.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FIRST_CELL_IDENTIFIER, for: indexPath) as UITableViewCell
        
        let oneItem = arrayOfChildren[indexPath.row]
        
        // 🔴 🔴 🔴 🔴 Use IF STATEMNET HERE IN CASE ARRAY OF CHILDREN IS EMPTY
        // Configure the cell...
        cell.textLabel?.text = oneItem.data.title
        cell.detailTextLabel?.text = oneItem.data.subreddit_name_prefixed
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier, identifier == Constants.SEGUE_IDENTIFIER {
            if let dvc = segue.destination as? WebSiteViewController {
                if let indexPathCell = tableView.indexPathForSelectedRow {
                    dvc.link = arrayOfChildren[indexPathCell.row].data.permalink
                }
            }
        }
    }
}


