//
//  ViewController.swift
//  ExpandCollapseUsingCompositeLayout
//
//  Created by Nitin Bhatia on 11/10/22.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var height: NSLayoutConstraint!
    var numberOfItems : Int = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collView.collectionViewLayout = createBasicListLayout()
        
    }
    
    func createBB() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(50),
                                              heightDimension: .absolute(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
    
      
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(500),heightDimension: .estimated(50)),subitems:[item])
        
       
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
      
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 10
        section.contentInsets.leading = 40
        section.contentInsets.trailing = 30
        section.contentInsets.bottom = 20
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    //MARK: layout for subject Wise
      func generateSubjectListLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(0.232 * collView.frame.width),heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(0.090 * collView.frame.width)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        var sectionHeaderFooter : [NSCollectionLayoutBoundarySupplementaryItem] = []
          if (numberOfItems >= 6) {
          let fotterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20 + 32))
          let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: fotterSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
          sectionHeaderFooter = [sectionHeader,sectionFooter]
        } else {
          sectionHeaderFooter = [sectionHeader]
        }
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = sectionHeaderFooter
        //section.decorationItems = [NSCollectionLayoutDecorationItem.background(elementKind: TopicWiseBackgroundGradient.reuseIdentifier)]
        section.contentInsets = .init(top: 0, leading: 20, bottom: 40, trailing: 20)
        section.interGroupSpacing = 28
          
        return section
      }
    
    func generateVideoLayout()-> NSCollectionLayoutSection {
        let itemsize = NSCollectionLayoutSize(widthDimension: .absolute(288), heightDimension: .absolute(162))
        let item = NSCollectionLayoutItem(layoutSize: itemsize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemsize, subitems: [item])
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 200, leading: 20, bottom: 40, trailing: 20)
        return section
      }
    
    func bhLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(CGFloat(numberOfItems * 40)))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
    
      
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,repeatingSubitem: item ,count: 1)
        
        let fotterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: fotterSize,
            elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
      
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 10
        section.contentInsets.leading = 40
        section.contentInsets.trailing = 30
        section.contentInsets.bottom = 20
        section.boundarySupplementaryItems = [sectionFooter]
        return section
    }
    
    func createBasicListLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {po,arg  in
            
            if po == 0 {
                return self.bhLayout()
            }
            return self.generateVideoLayout()
            
        })
        
        
        return layout
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 10
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! xCollectionViewCell
        
        cell.addMember(items: numberOfItems)
        
//        if indexPath.row % 2 == 0 {
//            cell.backgroundColor = .red
//        } else {
//            cell.backgroundColor = .blue
//        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            
            if indexPath.section == 0{
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "foo", for: indexPath) as! footerRR
                
                if numberOfItems > 6 {
                    footer.btnViewAll.setTitle("View Less", for: .normal)
                } else {
                    footer.btnViewAll.setTitle("View All", for: .normal)
                }
                
                footer.btnViewAll.addTarget(self, action: #selector(viewAllTapped), for: .touchUpInside)
                return footer
            }
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "foo", for: indexPath) as! footerRR
            return footer
        }
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "fooH", for: indexPath) as! footerRR
            footer.backgroundColor = .red
            return footer
        
        
       
    }
    
    @objc func viewAllTapped(_ sender : UIButton) {
        
        if sender.titleLabel?.text == "View All" {
            numberOfItems += 6
        } else {
            numberOfItems -= 6
        }
        
       
        
        collView.reloadSections(IndexSet(integer: 0))
        collView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredVertically, animated: true)
        

//        UIView.animate(withDuration: 2, delay: 10,options: .curveEaseInOut, animations: {
//            self.view.layoutIfNeeded()
//            self.collView.performBatchUpdates({
//                let indexSet = IndexSet(integer: 0)
//                self.collView.reloadSections(indexSet)
//            }, completion: nil)
//        })
        
        
        
        
    }
}

