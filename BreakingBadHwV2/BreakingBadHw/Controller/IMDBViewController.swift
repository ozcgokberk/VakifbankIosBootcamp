//
//  IMDBViewController.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 24.11.2022.
//

import UIKit
import WebKit

final class IMDBViewController: BaseViewController, WKNavigationDelegate {
    //Mark: Outlet
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        let urlString = "https://www.imdb.com/title/tt0903747/?ref_=ttep_ep_tt"
        
        if let url = URL(string: urlString) {
            webView.navigationDelegate = self
            webView.load(URLRequest(url: url))
        }
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
