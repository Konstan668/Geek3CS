//
//  LikeControl.swift
//  VKAPP
//
//  Created by Konstantin on 12.09.2021.
//

import UIKit

class LikeControl: UIControl {
    
    var isFavorite: Bool = false {
        didSet {
            sendActions(for: .valueChanged)
            updateControl()
        }
    }
    
    var likeLabel: UILabel = {
        let likelabel = UILabel()
        likelabel.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        likelabel.text = ""
        return likelabel
    }()
    
    var likeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 30, y: 0, width: 30, height: 30)
        imageView.image = UIImage(named: "Heart")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        likeImage.isUserInteractionEnabled = true
        likeImage.addGestureRecognizer(gestureRecognizer)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        
    }
    func updateControl() {
        if isFavorite {
            likeImage.image = UIImage(named: "HeartFill")
            
            
        } else {
            likeImage.image = UIImage(named: "Heart")
        }
    }
    
    private func setupViews() {
        addSubview(likeImage)
        addSubview(likeLabel)
        
    }
    
    
    @objc  func tapped(){
        isFavorite.toggle()
        
        if isFavorite == false {
            likeLabel.fadeTransition(1)
            likeLabel.text = ""
            
        } else {
            likeLabel.fadeTransition(1)
            likeLabel.text = "1"
        }
    }
}

extension UIView {
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
