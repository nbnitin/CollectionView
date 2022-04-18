//
//  FeaturedCollectionViewCell.swift
//  CollectionViewCompositionalLayout
//
//  Created by Nitin Bhatia on 06/04/22.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifer = "FeaturedCell"
    
    @IBOutlet weak var imgTile: UIImageView!
    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
}
