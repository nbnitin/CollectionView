//
//  AddNewCollectionViewController.swift
//  CollectionView
//
//  Created by Nitin Bhatia on 29/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class AddNewCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var itemBtnDel: UIBarButtonItem!
    @IBOutlet weak var btnItemEdit: UIBarButtonItem!
    var lastIncremented = 10
    var items : [Int] = []
    var checkTrack : [Bool] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //shows back button when left item adds in navigation bar
        self.navigationItem.leftItemsSupplementBackButton = true
        
       

        for i in 0...10{
            items.append(i)
            checkTrack.append(false)
        }
        
        btnItemEdit.target = self
        btnItemEdit.action = #selector(enableEdit(_:))
        itemBtnDel.isEnabled = false
        btnItemEdit.title = "Edit"

    }
    
    override func viewDidAppear(_ animated: Bool) {
        //hides toolbar
        navigationController?.toolbar.isHidden = false
    }
    
    @objc func enableEdit(_ sender : Any){
        
        collectionView?.reloadData()
        
        if(btnItemEdit.title == "Edit"){
        super.setEditing(true, animated: true)
        collectionView?.allowsMultipleSelection = true
        itemBtnDel.isEnabled = true
        btnItemEdit.title = "Cancel"
            
        } else {
            super.setEditing(false, animated: true)
            collectionView?.allowsMultipleSelection = false
            itemBtnDel.isEnabled = false

            
            btnItemEdit.title = "Edit"
        }
        
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
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.lblTitle.text = "Text \(items[indexPath.row])"
        cell.btnCheck.tag = indexPath.row
        
        
        //set user interaction to true if you want to do the same check uncheck using button
        cell.btnCheck.isUserInteractionEnabled = false
        
        cell.btnCheck.addTarget(self, action: #selector(updateCheck(_:)), for: .touchUpInside)
        
        if(btnItemEdit.title == "Edit"){
            cell.btnCheck.isHidden = true
        } else {
            cell.btnCheck.isHidden = false
        }
        
        if(checkTrack[indexPath.row]){
            cell.btnCheck.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
            cell.btnCheck.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)

        }
        
        print(cell.lblTitle.text)
    
        // Configure the cell
    
        return cell
    }
    
    
    @objc func updateCheck(_ sender: UIButton){
        
        let tag = sender.tag
        let indexPath = NSIndexPath(row: tag, section: 0) as IndexPath
        
        let cell = collectionView?.cellForItem(at: indexPath) as! CollectionViewCell
        if(!checkTrack[tag]){
            cell.btnCheck.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            checkTrack[tag] = true
        } else {
            cell.btnCheck.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            checkTrack[tag] = false
        }
        
        
    }
    
    
    
    @IBAction func btnAdd(_ sender: Any) {
        
        checkTrack.append(false)
        lastIncremented += 1
        
        items.append(lastIncremented)
        
        let indexPath = NSIndexPath(row: items.count - 1, section: 0) as IndexPath
        collectionView?.insertItems(at: [indexPath])
        //collectionView?.reloadItems(at: [indexPath])
    }
    
    //Mark:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2 - 16, height: 115.0)
    }
    
   override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        let index = cell.btnCheck.tag
        cell.btnCheck.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        checkTrack[indexPath.row] = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        let index = cell.btnCheck.tag
        cell.btnCheck.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        checkTrack[index] = true

    }
    
    @IBAction func Delete(_ sender: Any) {
        
        let indexPath = collectionView?.indexPathsForSelectedItems
       // collectionView?.deleteItems(at: indexPath!)
        
        var itemsToDelete : [Int] = []
        
        for i in (indexPath?.sorted())!{
            itemsToDelete.append(i.row)
        }
        
        var tempArray = items
        var tempCheck = checkTrack
        
        print("pre items \(items)")
        print("delete \(itemsToDelete)")

        items = []
        checkTrack = []
        
        for i in 0...tempArray.count-1{
            let indexofItem = itemsToDelete.index(of: i)
            
            
            
            if(indexofItem == nil){
                items.append(tempArray[i])
                checkTrack.append(false)
            }
        }
        
        print("next items \(items)")

        
       
        collectionView?.deleteItems(at: indexPath!)
        //collectionView?.reloadData()
    
        
    }

    
}
