//
//  WKWebViewController.swift
//  VKAPP
//
//  Created by Konstantin on 01.04.2022.
//
import WebKit
import UIKit

class WKWebViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/autorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "8123745"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "26250"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5,68")
        ]
        return components
        
    }()

    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self

        
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
 
    
    
    
}
