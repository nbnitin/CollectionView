//
//  DynamicHeightOtherWayCollectionViewCell.swift
//  CollectionView
//
//  Created by Nitin Bhatia on 06/04/22.
//  Copyright © 2022 Nitin Bhatia. All rights reserved.
//

import UIKit

class DynamicHeightOtherWayCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var frame = layoutAttributes.frame
            frame.size.height = ceil(size.height)
            layoutAttributes.frame = frame
            return layoutAttributes
        }
}
