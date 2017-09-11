//
//  ViewController.swift
//  WebViewAdSample_Swift
//
//  Created by nend.net on 2017/09/20.
//  Copyright (c) 2017年 F@N Communications, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UIWebViewDelegate
{
    var nendWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 広告用 WebView を配置する
        self.nendWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        self.nendWebView.delegate = self
        self.nendWebView.center = self.view.center
        
        // 背景色を透明にする
        self.nendWebView.isOpaque = false
        self.nendWebView.backgroundColor = UIColor.clear;
        
        // ローカルの html を読み込む
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "nendAd", ofType: "html")!)
        let req = URLRequest(url: url)
        self.nendWebView.loadRequest(req)

        self.view.addSubview(self.nendWebView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == .linkClicked {
            // UIWebViewNavigationTypeLinkClicked
            if UIApplication.shared.canOpenURL(request.url!) {
                // Browser open.
                UIApplication.shared.openURL(request.url!)
                return false
            }
        }
        return true
    }
}

