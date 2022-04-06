//
//  ExtraCollectionViewController.swift
//  CollectionView
//
//  Created by Nitin Bhatia on 30/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class ExtraCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var data : [Data1] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        data = Data1.setupData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.img.image = UIImage(named: data[indexPath.row].img)
        cell.lblLike.text = "\(data[indexPath.row].like)"
        cell.lblDislike.text = "\(data[indexPath.row].dislike)"
        
        cell.btnLike.tag = indexPath.row
        cell.btnDisLike.tag = indexPath.row
        
        cell.btnDisLike.addTarget(self, action: #selector(disLike(_:)), for: .touchUpInside)
        cell.btnLike.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
       
        cell.data = Data1(img: data[indexPath.row].img, like: data[indexPath.row].like, dislike: data[indexPath.row].dislike)
        
        
        // Configure the cell
    
        return cell
    }
    
    //Mark:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 10, height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 12, right: 0)
    }


    @objc func like(_ sender:UIButton){
        let indexPath = NSIndexPath(row:sender.tag,section:0) as IndexPath
        let cell = collectionView?.cellForItem(at: indexPath) as! CollectionViewCell
        data[indexPath.row].like += 1
        cell.lblLike.text =  "\(data[indexPath.row].like)"
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        cell.lblLike.layer.add(transition, forKey: "changeTextTransition")
        cell.data.like = data[indexPath.row].like

    }
    
    @objc func disLike(_ sender:UIButton){
        let indexPath = NSIndexPath(row:sender.tag,section:0) as IndexPath
        let cell = collectionView?.cellForItem(at: indexPath) as! CollectionViewCell
        data[indexPath.row].dislike += 1
        cell.lblDislike.text =  "\(data[indexPath.row].dislike)"
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        cell.lblDislike.layer.add(transition, forKey: "changeTextTransition")
        cell.data.dislike = data[indexPath.row].dislike

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let v = sender as! CollectionViewCell
        let vc = segue.destination as! ViewController
        
        
        vc.data =  v.data
    }
   

}
