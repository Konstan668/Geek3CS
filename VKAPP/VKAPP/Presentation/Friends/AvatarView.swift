//
//  AvatarView.swift
//  VKAPP
//
//  Created by Konstantin on 10.09.2021.
//

import UIKit

class AvatarView: UIView {
    
    let avatarView = UIView(frame: CGRect(x: 0, y: 5, width: 100, height: 100))
   public let avatarImage = UIImageView(frame: CGRect(x: 0, y: 5, width: 100, height: 100))

    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(avatarView)
        addSubview(avatarImage)
        avatarImage.layer.cornerRadius = 50
        avatarImage.layer.masksToBounds = true
        avatarImage.image = UIImage(named: "MDKLogo")
        avatarView.backgroundColor = UIColor.darkGray
        avatarView.layer.cornerRadius = 50
        avatarView.layer.shadowOffset = CGSize(width: 5, height: 5)
        avatarView.layer.shadowColor = UIColor.orange.cgColor
        avatarView.layer.shadowRadius = 5
        avatarView.layer.shadowOpacity = 1.0
    }
    
}
