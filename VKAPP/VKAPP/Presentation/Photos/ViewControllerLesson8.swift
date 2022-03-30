//
//  ViewControllerLesson8.swift
//  VKAPP
//
//  Created by Konstantin on 29.09.2021.
//

import UIKit
import SnapKit

class ViewControllerLesson8: UIViewController {
    var interactiveAnamator: UIViewPropertyAnimator!
    var users = User(userName: "", userImageName: "", userPhotossName: [""])
    var photos = [String]()
    var currentImage = 0
    let photoImage: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return image
    }()
    
    func firstPhoto() {
        photoImage.image = UIImage(named: users.userPhothosName[0])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        photos = users.userPhothosName
        
        view.addSubview(photoImage)
        photoImage.contentMode = .scaleAspectFit
        
        firstPhoto()
        
        photoImage.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            
            
        }
        
        photoImage.isUserInteractionEnabled = true
        
        let swipeRIght = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeRIght.direction = UISwipeGestureRecognizer.Direction.right
        photoImage.addGestureRecognizer(swipeRIght)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        photoImage.addGestureRecognizer(swipeLeft)
        
    }
    
    
    
    func swipeAnimationL() {
        
        UIView.animate(withDuration: 0.5) {
            self.photoImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }
        
        var _:Timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(leftSwipe), userInfo: nil, repeats: false)
        
        var _:Timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(fromLeftToRight), userInfo: nil, repeats: false)
        
    }
    
    func swipeAnimationLLastImage() {
        
        UIView.animate(withDuration: 0.5) {
            self.photoImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }
        
        var _:Timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(lastImageR), userInfo: nil, repeats: false)
        
        var _:Timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(fromLeftToRight), userInfo: nil, repeats: false)
        
    }
    
    func swipeAnimationR() {
        var _:Timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(fromRightToLeft), userInfo: nil, repeats: false)
        var _:Timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(rightSwipe), userInfo: nil, repeats: false)
        var _:Timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(transformImage), userInfo: nil, repeats: false)
    }
    
    
    func swipeAnimationRFirstImage() {
        var _:Timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(fromRightToLeft), userInfo: nil, repeats: false)
        var _:Timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(firstImage), userInfo: nil, repeats: false)
        var _:Timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(transformImage), userInfo: nil, repeats: false)
        
    }
    
    @objc func fromRightToLeft() {
        
        let animation1 = CABasicAnimation(keyPath: "position.x")
        animation1.fromValue = photoImage.layer.position.x
        animation1.toValue = photoImage.layer.position.x + 400
        animation1.duration = 0.5
        photoImage.layer.add(animation1, forKey: nil) 
    }
    
    func changeImage() {
        self.photoImage.image = UIImage(named: self.users.userPhothosName[self.currentImage])
    }
    
    @objc func fromLeftToRight() {
        
        let animation2 = CABasicAnimation(keyPath: "position.x")
        animation2.fromValue = photoImage.layer.position.x + 400
        animation2.toValue = photoImage.layer.position.x
        animation2.duration = 0.5
        photoImage.layer.add(animation2, forKey: nil)
    }
    
    
    @objc func transformImage() {
        UIView.animate(withDuration: 0.5) {
            self.photoImage.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    
    @objc func lastImageR() {
        currentImage = 0
        self.photoImage.transform = CGAffineTransform(scaleX: 1, y: 1)
        changeImage()
    }
    
    @objc func leftSwipe() {
        currentImage += 1
        self.photoImage.transform = CGAffineTransform(scaleX: 1, y: 1)
        changeImage()
    }
    
    @objc func rightSwipe() {
        currentImage -= 1
        changeImage()
        self.photoImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    @objc func firstImage() {
        currentImage = photos.count - 1
        changeImage()
        self.photoImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    
    @objc func swipe(gesture : UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            
            case UISwipeGestureRecognizer.Direction.left:
                if currentImage == photos.count - 1 {
                    
                    swipeAnimationLLastImage()
                } else {
                    swipeAnimationL()
                }
                
            case UISwipeGestureRecognizer.Direction.right:
                if currentImage == 0 {
                    swipeAnimationRFirstImage()
                    
                } else {
                    swipeAnimationR()
                }
                
            default:
                break
            }
        }
    }
}
