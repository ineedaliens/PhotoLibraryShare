//
//  FourthViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 01.10.2020.
//

import UIKit
import WebKit

class FourthViewController: UIViewController, WKNavigationDelegate {
    
    
    
    var url: URL!
    var progressView: UIProgressView!
    var webView: WKWebView!
    
    
   
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress)) 
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView() 
        webView.navigationDelegate = self 
        view = webView 
        
        
        
        let request = URLRequest(url: url) 
        webView.load(request) 
        
        webView.allowsLinkPreview = true 
        webView.allowsBackForwardNavigationGestures = true 
        
        
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView) 
        let flexibleSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) 
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload)) 
        
        toolbarItems = [progressButton, flexibleSpacer, refreshButton] 
        navigationController?.isToolbarHidden = false
        
        
       
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) 
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" { 
            progressView.progress = Float(webView.estimatedProgress) 
        }
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
