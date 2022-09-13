//
//  DetailViewController.swift
//  Project07
//
//  Created by Karen Oliveira on 30/08/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view  = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport", content="width=device-width, initial-scale=1">
        <style> body { font-size: 125%; padding-left: 4%; padding-right: 2% } h3 { text-align: center } </style>
        </head>
        <body>
        <h3>
        \(detailItem.title)
        </h3>
        <div>
        \(detailItem.body)
        </div>
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }

}
