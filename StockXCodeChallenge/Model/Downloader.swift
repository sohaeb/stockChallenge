//
//  Downloader.swift
//  StockXCodeChallenge
//
//  Created by may on 2018-07-11.
//  Copyright © 2018 sohaeb. All rights reserved.
//

import Foundation

/*
 * This class fetches data and decode the JSOn
 */
class Downloader {
    
    // 🔴 🔴 🔴 🔴 Singleton patter
    
    // MARK:- Alias
    typealias DownloadResults = ([Children]?, Error?) -> ()
    
    var errorMessage = "" // 🔴 🔴 🔴 🔴 why have it ?
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var arrayOfChildren = [Children]()
    
    // MARK:- Methods
    
    //
    // This func downloads data asynchronosly from a given url
    // Then it calls update(_:) method to decode the data
    // and then pass them around as a completionHandler to be used by other classes
    //
    func getSearchResults(url: String, completion: @escaping DownloadResults) {
        
        dataTask?.cancel()
        
        guard let url = URL(string: url ) else { return }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                print("Error is \(error)")
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                print("Data is \(data)")
                // decode the json data
                self.update(data: data)
                
                DispatchQueue.main.async {
                    completion(self.arrayOfChildren, error)
                }
            } else {
                print("Subreddit is either private or Banned") // 🔴 🔴 🔴 🔴 check reason then print error
            }
        }
        dataTask?.resume()
    }
    
    //
    // This func decodes instances of a data type from JSON objects.
    //
    func update(data: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            let todo = try decoder.decode(Reddit.self, from: data)
            // self.arrayOfChildren will be used in "completion(self.arrayOfChildren, error)"
            self.arrayOfChildren = todo.data.children
        } catch {
            print("error trying to convert data to JSON in URLsession taks func") // 🔴 🔴 🔴 add error
        }
    }
}
