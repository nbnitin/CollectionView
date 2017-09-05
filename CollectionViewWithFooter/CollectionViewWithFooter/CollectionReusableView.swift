//
//  CollectionReusableView.swift
//  CollectionViewWithFooter
//
//  Created by Umesh Chauhan on 05/09/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var v: UIView!

    var nav : UINavigationController!
    @IBOutlet weak var btn: UIButton!
    
    @IBAction func test(_ sender: Any) {
        print("i m fotter")
        let ss = UIStoryboard.init(name: "Main", bundle: nil)
        let x = ss.instantiateViewController(withIdentifier: "secondVC") as! ViewController1
        nav.pushViewController(x, animated: true)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("override frame")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        print("overide")
        btn.backgroundColor = UIColor.black
        btn.layer.cornerRadius = 10
    }
    
}
