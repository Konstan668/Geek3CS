//
//  ViewController.swift
//  VKAPP
//
//  Created by Konstantin on 16.08.2021.
//

import UIKit

final class LoginViewController: UIViewController {
    
    
    
    
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let loginText = loginTextField.text
        let passwordText = passwordTextField.text
        
        if loginText == "1" && passwordText == "1" {
            print("Success!")
            return true
        } else {
            print("Error login or password!")
            showAlert(title: "Ошибка", message: "Не верный логин и пароль")
            return false
        }
    }
    
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            guard let self = self else {return}
            self.loginTextField.text = ""
            self.passwordTextField.text = ""
        }
        alertController.addAction(closeAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(tapGesture)
        
        addLoadingView()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboasrWillBeHidden), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbsize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbsize.height, right: 0.0)
        
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboasrWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    func addLoadingView(){
        
        let loadView1: UIView = {
            let viewL = UIView()
            viewL.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            viewL.backgroundColor = .blue
            viewL.layer.cornerRadius = 10
            
            
            return viewL
        } ()
        
        let loadView2: UIView = {
            let viewL = UIView()
            viewL.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            viewL.backgroundColor = .blue
            viewL.layer.cornerRadius = 10
            
            
            return viewL
        } ()
        
        let loadView3: UIView = {
            let viewL = UIView()
            viewL.frame = CGRect(x: 60, y: 0, width: 20, height: 20)
            viewL.backgroundColor = .blue
            viewL.layer.cornerRadius = 10
            
            
            return viewL
        } ()
        
        self.loadingView.addSubview(loadView1)
        self.loadingView.addSubview(loadView2)
        self.loadingView.addSubview(loadView3)
        
        loadView1.translatesAutoresizingMaskIntoConstraints = false
        let loadView1XConstraint = NSLayoutConstraint(item: loadView1, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loadingView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let loadView1YConstraint = NSLayoutConstraint(item: loadView1, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loadingView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let loadView1WidthConstraint = NSLayoutConstraint(item: loadView1, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 20)
        let loadView1HeightConstraint = NSLayoutConstraint(item: loadView1, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 20)
        
        
        let loadView2YConstraint = NSLayoutConstraint(item: loadView2, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loadingView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let loadView2WidthConstraint = NSLayoutConstraint(item: loadView2, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 20)
        let loadView2HeightConstraint = NSLayoutConstraint(item: loadView2, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 20)
        let loadView2LeadingConstraint = NSLayoutConstraint(item: loadView2, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loadingView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        
        let loadView3YConstraint = NSLayoutConstraint(item: loadView3, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loadingView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let loadView3WidthConstraint = NSLayoutConstraint(item: loadView3, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 20)
        let loadView3HeightConstraint = NSLayoutConstraint(item: loadView3, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 20)
        let loadView3TrailingConstraint = NSLayoutConstraint(item: loadView3, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loadingView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        let loadView3LeadingConstraint = NSLayoutConstraint(item: loadView3, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loadingView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        
        
        
        
        NSLayoutConstraint.activate([loadView1XConstraint, loadView1YConstraint, loadView1WidthConstraint, loadView1HeightConstraint, loadView2YConstraint, loadView2WidthConstraint, loadView2HeightConstraint, loadView2LeadingConstraint, loadView3YConstraint, loadView3WidthConstraint, loadView3HeightConstraint, loadView3TrailingConstraint, loadView3LeadingConstraint ])
        
        UIView.animate(withDuration: 3 , delay: 1, options: .repeat,   animations: {
            loadView2.alpha = 0.0
        })
        UIView.animate(withDuration: 3  , delay: 2, options: .repeat,   animations: {
            loadView1.alpha = 0.0
        })
        UIView.animate(withDuration: 3 , delay: 3, options: .repeat,   animations: {
            loadView3.alpha = 0.0
        })
        
        
    }
    
    
    
}

