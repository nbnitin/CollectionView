//
//  Example3CollectionViewCell.swift
//  CollectionViewCompositionalLayout
//
//  Created by Nitin Bhatia on 08/04/22.
//

import UIKit

class Example3CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblListNumber: UILabel!
    @IBOutlet weak var lblListDetails: UILabel!
    @IBOutlet weak var lblListTitle: UILabel!
    
    var isListView : Bool!
    
    override func layoutSubviews() {
        if isListView {
            layer.cornerRadius = min(frame.size.height, frame.size.width) / 2.0
        } else {
            layer.cornerRadius = 2
        }
    }
    
}
