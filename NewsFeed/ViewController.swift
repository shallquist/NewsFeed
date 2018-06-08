//
//  ViewController.swift
//  NewsFeed
//
//  Created by steig hallquist on 6/8/18.
//  Copyright © 2018 steig hallquist. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    var url:String?
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        }
    }
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.layer.cornerRadius = 7.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let urlStr = url, let url = URL(string: urlStr) else { return }
        
        webView.load(URLRequest(url: url))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let webView = object as? WKWebView {
            let progress = webView.estimatedProgress
            
            if progress > 0.5 { self.activityIndicator.isHidden = true }
            
            self.progressView.setProgress(Float(progress), animated: true)
        }
    }
}


extension ViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.progressView.setProgress(0.0, animated: true)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.isHidden = true
        self.progressView.setProgress(1.0, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.activityIndicator.isHidden = true
        print(error)
    }
}
