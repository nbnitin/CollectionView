//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by Nitin Bhatia on 29/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblDislike: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var btnDisLike: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    var data : Data1! = nil
}
