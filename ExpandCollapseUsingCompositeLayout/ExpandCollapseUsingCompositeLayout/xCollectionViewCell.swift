//
//  xCollectionViewCell.swift
//  ExpandCollapseUsingCompositeLayout
//
//  Created by Nitin Bhatia on 21/10/22.
//

import UIKit

class xCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stackVi: UIStackView!
    @IBOutlet var vv : UIView!
   
    
    
    func addMember(items: Int) {
    
        stackVi.arrangedSubviews.map({
            stackVi.removeArrangedSubview($0)
        })
        
        for i in 0 ..< items - 1 {
            let vv = UIView()
            
            if i % 2 == 0 {
                vv.backgroundColor = .blue
            } else {
                vv.backgroundColor = .red
            }
    
            stackVi.addArrangedSubview(vv)
        }

        
       
    }
}
