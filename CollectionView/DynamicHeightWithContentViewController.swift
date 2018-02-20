//
//  DynamicHeightWithContentViewController.swift
//  CollectionView
//
//  Created by Nitin Bhatia on 20/02/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import UIKit
import Foundation

class DynamicHeightWithContentViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collView: UICollectionView!
    
    let data = ["helolo  end","helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo end","helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo end","helolo helolo helolo hdfhkjdfhjkdfhj dsjfhdkjhfj kjdshfkjdhf  end","helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo helolo end"]

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DynamicHeightAccordingToContent
        cell.txtTitle.text = data[indexPath.row]
        cell.txtTitle.backgroundColor = UIColor.clear
        cell.txtTitle.backgroundColor = UIColor.red
        print(cell.frame.height)
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let testString =  NSString(string: (data[indexPath.row]))
        
        let size = CGSize(width:self.view.frame.width,height:1000)
        
    
        
       let attribute = [NSFontAttributeName:UIFont.systemFont(ofSize:16)] //Font here must be equal to control font size in your storyboard
        
        let estimatedFrame = testString.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attribute, context: nil)
        print(estimatedFrame.height)
        return CGSize(width: size.width - 16, height: estimatedFrame.height + 20)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 8, 8, 8)
    }

}
