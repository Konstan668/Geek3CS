//
//  PhotosCollectionViewLayout.swift
//  VKAPP
//
//  Created by Konstantin on 21.09.2021.
//

import UIKit
class PhotosCollectionViewLayout: UICollectionViewFlowLayout {
    
    var layOutDelegate: CustomLayOutDelegate?
    var leftY = CGFloat(0)
    var rightY = CGFloat(0)
    var cacheAttributes = [UICollectionViewLayoutAttributes] ()
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let verticalSpacing = CGFloat(10)
        let horizontalSpacing = CGFloat(10)
        let margin = CGFloat(10)
        leftY = margin
        rightY = margin
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            var frame = CGRect.zero
            let cellHight = self.layOutDelegate!.hightAndWidthFor(index: item).heightForCell
            let cellWidth = self.layOutDelegate!.hightAndWidthFor(index: item).widthForCell
            frame.size.height = cellHight
            frame.size.width = cellWidth + horizontalSpacing * 2//(collectionView.frame.size.width - 2 * margin) - horizontalSpacing / 2
            frame.origin.x = margin
            frame.origin.y = leftY
            leftY += cellHight + verticalSpacing
            
            
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cacheAttributes.append(attributes)
        }
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attrutes in cacheAttributes {
            if attrutes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attrutes)
            }
        }
        return visibleLayoutAttributes
    }
    
    
    override var collectionViewContentSize: CGSize {
        return CGSize.init(width: collectionView!.frame.size.width, height: leftY)
    }
}
