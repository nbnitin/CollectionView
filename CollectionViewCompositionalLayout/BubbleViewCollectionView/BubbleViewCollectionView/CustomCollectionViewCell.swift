//
//  CustomCollectionViewCell.swift
//  BubbleViewCollectionView
//
//  Created by Nitin Bhatia on 20/04/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    let deSelectedColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
    let IneligibleColor = UIColor(red: 0.733, green: 0.733, blue: 0.733, alpha: 1)
    
    var isEligible : Bool? {
        didSet {
            if !(isEligible ?? false) {
                layer.borderColor = IneligibleColor.cgColor
                backgroundColor = .gray
                lblTitle.textColor = IneligibleColor
            } else {
                layer.borderColor = UIColor.red.cgColor
                backgroundColor = .black
                lblTitle.textColor = IneligibleColor
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if (self.isEligible ?? false) && isSelected {
                layer.borderColor = isSelected ? UIColor.red.cgColor : deSelectedColor.cgColor
                backgroundColor = isSelected ? UIColor.red : deSelectedColor
            }
            
        }
    }
    
   
    
    func config(isEligible: Bool, isSelected: Bool) {
        self.isEligible = isEligible
        self.isSelected = isSelected
    }
    
}


