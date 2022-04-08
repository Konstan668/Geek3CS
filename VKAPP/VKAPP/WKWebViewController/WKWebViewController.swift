import WebKit
import UIKit

class WKWebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "8123745"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        return components
        
    }()
    
    override func loadView(){
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
        
    }
    
    func requestInfo() {
        
        let fetchFriendsUrl: URLComponents = {
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.vk.com"
            components.path = "/method/friends.get"
            components.queryItems = [
                URLQueryItem(name: "access_token", value: MySession.instance.token),
                URLQueryItem(name: "v", value: "5.131")
            ]
            return components
        }()
        
        let fetchPhotoUrl: URLComponents = {
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.vk.com"
            components.path = "/method/photos.getAll"
            components.queryItems = [
                URLQueryItem(name: "access_token", value: MySession.instance.token),
                URLQueryItem(name: "v", value: "5.131")
            ]
            return components
        }()
        
        let fetchGroups: URLComponents = {
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.vk.com"
            components.path = "/method/groups.get"
            components.queryItems = [
                URLQueryItem(name: "access_token", value: MySession.instance.token),
                URLQueryItem(name: "v", value: "5.131")
            ]
            return components
        }()
        
        var fetchFindGroup: URLComponents = {
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.vk.com"
            components.path = "/method/search.getHints"
            components.queryItems = [
                URLQueryItem(name: "q", value: "MDK"),
                URLQueryItem(name: "limit", value: "5"),
                URLQueryItem(name: "folters", value: "groups"),
                URLQueryItem(name: "access_token", value: MySession.instance.token),
                URLQueryItem(name: "v", value: "5.131")
            ]
            return components
        }()
        
        
        let requetsArray = [fetchFriendsUrl, fetchPhotoUrl, fetchGroups, fetchFindGroup]
        let session = URLSession.shared
        for item in requetsArray {
            let request = URLRequest(url: item.url!)
            
            let task = session.dataTask(with: request) {(data, respons, error) in
                let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                print("----------------- REQUEST =", request,"----------------json", json)
                
            }
            task.resume()
        }
    }
}



extension WKWebViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String:String]()) {result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        let token = params["access_token"]
        guard  let userID = params["user_id"]        else { return }
        MySession.instance.userId = Int(userID)!
        MySession.instance.token = token!
        requestInfo()

        
        decisionHandler(.cancel)
        
        
    }
}
