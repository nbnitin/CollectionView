//
//  ViewController.swift
//  BubbleViewCollectionView
//
//  Created by Nitin Bhatia on 20/04/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //outlet
    @IBOutlet weak var collView: UICollectionView!
    
    //variables
    let numberOfRows : Int = 13
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collView.collectionViewLayout = generateLayout()
    }
    
    func generateLayout() -> UICollectionViewLayout {
        
        
        
        let layout = UICollectionViewCompositionalLayout {(sectionIndex : Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let layoutSize = NSCollectionLayoutSize(widthDimension: .absolute(layoutEnvironment.container.contentSize.width / 3 - 12), heightDimension: .absolute(50))
            let item = NSCollectionLayoutItem(layoutSize: layoutSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(layoutEnvironment.container.contentSize.width), heightDimension: .absolute(50))
            
            let leadingGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
            leadingGroup.interItemSpacing = .fixed(10)
            leadingGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing:10)
            
            let leadingGroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
            leadingGroup2.interItemSpacing = .fixed(10)
            leadingGroup2.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 60, bottom: 10, trailing:60)
            
            let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
            let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: containerGroupSize, subitems: [leadingGroup,leadingGroup2])
            containerGroup.interItemSpacing = .fixed(10)
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            return section
            
            
        }
        
        return layout
        
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.lblTitle.text = "hfdkjhjkfhdjkhfdjkhfdjkhkdjhfdjkhfdjkhfdjkhjkhjdkhfj \(indexPath.row)"
        
        cell.config(isEligible: indexPath.row % 2 == 0, isSelected: true)
        
        //        if indexPath.row % 2 == 0 {
        //            cell.backgroundColor = .red
        //        } else {
        //            cell.backgroundColor = .blue
        //        }
        
        return cell
    }
    
}

