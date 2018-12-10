//
//  MyWebViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/11.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit
import WebKit

class MyWebViewController: BaseViewController {
    var linkUrl: String?
    
    convenience init(linkUrl: String?) {
        self.init()
        self.linkUrl = linkUrl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard linkUrl?.count != 0 else { return }
        let configuration: WKWebViewConfiguration = WKWebViewConfiguration()
        let webView: WKWebView = WKWebView(frame: view.bounds, configuration:configuration)
        webView.backgroundColor = MyConfigation.ThemeColor
        webView.navigationDelegate = self
        guard let url = URL(string: linkUrl ?? "") else { return }
        webView.load(URLRequest(url: url))
        view.addSubview(webView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MyWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function)
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print(#function)
    }
}
