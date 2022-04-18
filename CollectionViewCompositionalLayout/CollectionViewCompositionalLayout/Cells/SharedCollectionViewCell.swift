//
//  SharedCollectionViewCell.swift
//  CollectionViewCompositionalLayout
//
//  Created by Nitin Bhatia on 06/04/22.
//

import UIKit

class SharedCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifer = "SharedCell"

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgTile: UIImageView!
}
