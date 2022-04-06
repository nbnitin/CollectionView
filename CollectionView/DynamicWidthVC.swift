//
//  DynamicHeightWithContentViewController.swift
//  CollectionView
//
//  Created by Nitin Bhatia on 20/02/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import UIKit
import Foundation

class DynamicWidthVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collView: UICollectionView!
    
    let data = ["helolo  end","helolo helolo  end","helolo helolo helolo hi bye end","helolo helolo helolo hdfhkj  end","helolo helolo helolo helolo hello hello hello  end"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DynamicWidthCell
        cell.lblTitle.text = data[indexPath.row]
        cell.contentView.backgroundColor = UIColor.red
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let testString =  NSString(string: (data[indexPath.row]))
        
        let size = CGSize(width:.greatestFiniteMagnitude,height:40.0)
        
        let attribute = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:17)]
        let estimatedFrame = testString.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attribute, context: nil)
        // +20 is trailing space + leading space i.e.., 8 + 8 + extra 4 for space around it = 20
        return CGSize(width: estimatedFrame.width + 20 , height: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
}

