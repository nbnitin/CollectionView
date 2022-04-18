//
//  Example2ViewController.swift
//  CollectionViewCompositionalLayout
//
//  Created by Nitin Bhatia on 08/04/22.
//

import UIKit

class Example2ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var collView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collView.collectionViewLayout = generateLayout()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute:  {
            print("changing layout ")
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                self.collView.collectionViewLayout = self.generateLayout2()
                self.collView.reloadData()
            }, completion: nil)
        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UICollectionViewCell
        
        cell.backgroundColor = UIColor(red: getRandomNumber() / 255, green: getRandomNumber() / 255, blue: getRandomNumber() / 255, alpha: getRandomNumber() / 255)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderCollectionReusableView
        header.lblHeaderTitle.text = "Section \(indexPath.section)"
        return header
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(10),
                                                  heightDimension: .estimated(10))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
           // item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: NSCollectionLayoutSpacing.fixed(0), top:  NSCollectionLayoutSpacing.fixed(0), trailing:  NSCollectionLayoutSpacing.fixed(0), bottom:  NSCollectionLayoutSpacing.fixed(0))
            // Show one item plus peek on narrow screens, two items plus peek on wider screens
            let groupFractionalWidth = 0.475
            let groupFractionalHeight: Float = 1/3
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(self.collView.frame.width - 20),
                heightDimension: .estimated(10))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: -10)
            section.boundarySupplementaryItems = [sectionHeader]
//            section.orthogonalScrollingBehavior = .continuous
//
            
            return section
        }
        return layout
    }
    
    func generateLayout2() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(10),
                                                  heightDimension: .estimated(10))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
            // Show one item plus peek on narrow screens, two items plus peek on wider screens
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(self.collView.frame.width),
                heightDimension: .estimated(10))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            section.boundarySupplementaryItems = [sectionHeader]
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
        }
        return layout
    }
    
    func getRandomNumber()->CGFloat {
        return(CGFloat((0...255).randomElement()!))
    }
    
}

