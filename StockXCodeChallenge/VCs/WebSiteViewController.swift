//
//  WebSiteViewController.swift
//  StockXCodeChallenge
//
//  Created by may on 2018-07-11.
//  Copyright © 2016 sohaeb. All rights reserved.
//

import UIKit

class WebSiteViewController: UIViewController, UIWebViewDelegate {
    
     var link: String?
    
    // MARK:- Outlets
    
    @IBOutlet weak var justAnIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    
    // MARK:- VC Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        webView.delegate = self
        
        if let link = link {
            webView.loadRequest(URLRequest(url: URL(string: "https://www.reddit.com\(link)")!))
        }
    }
}

extension WebSiteViewController {
    
    // MARL:- webView Delegate Methods
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        justAnIndicator.startAnimating()
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        justAnIndicator.stopAnimating()
    }
}
