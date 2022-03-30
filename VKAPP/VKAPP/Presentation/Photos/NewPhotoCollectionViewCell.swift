//
//  NewPhotoCollectionViewCell.swift
//  VKAPP
//
//  Created by Konstantin on 27.09.2021.
//

import UIKit
import SnapKit


class NewPhotoCollectionViewCell: UICollectionViewCell {
    var  photoImageView = UIImageView()
    var likeControlItem = LikeControl()
    static let identifier = "photoCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(likeControlItem)
        likeControlItem.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.bottom.equalTo(photoImageView)
            make.trailing.equalTo(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
