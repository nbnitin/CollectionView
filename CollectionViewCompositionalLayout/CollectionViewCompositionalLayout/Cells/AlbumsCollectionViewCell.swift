//
//  AlbumsCollectionViewCell.swift
//  CollectionViewCompositionalLayout
//
//  Created by Nitin Bhatia on 06/04/22.
//

import UIKit

class AlbumsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifer = "Albums"

    
    @IBOutlet weak var imgTile: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
}
