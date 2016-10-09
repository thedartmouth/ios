//
//  ArticleViewController.swift
//  The Dartmouth
//
//  Created by Henry Wilson on 10/9/16.
//  Copyright © 2016 The Dartmouth. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var webView: UIWebView!
    
    var articleLink: String = String("http://google.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: URL = URL(string: articleLink)!
        let request: URLRequest = URLRequest(url: url)
        webView.loadRequest(request)
        webView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
