//
//  CollectionView.swift
//  CollectionView
//
//  Created by Nitin Bhatia on 29/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionView: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.lblTitle.text = "text \(indexPath.row)"
    
        // Configure the cell
    
        return cell
    }

   

}
