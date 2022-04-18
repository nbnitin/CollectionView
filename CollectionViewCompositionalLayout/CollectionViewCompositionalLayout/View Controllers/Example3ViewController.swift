//
//  Example3ViewController.swift
//  CollectionViewCompositionalLayout
//
//  Created by Nitin Bhatia on 08/04/22.
//

import UIKit
let SELECTED_IMAGE_GRID = "circle.grid.3x3.circle.fill"
let UNSELECTED_IMAGE_GRID = "circle.grid.3x3.circle"
let SELECTED_IMAGE_LIST = "list.bullet.circle.fill"
let UNSELECTED_IMAGE_LIST = "list.bullet.circle"
let CELL_LEADING : CGFloat = 10
let LIST_SIZE : CGFloat = 60
class Example3ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var btnListView: UIBarButtonItem!
    @IBOutlet weak var btnGridView: UIBarButtonItem!
    @IBOutlet weak var collView: UICollectionView!
    
    var isListView : Bool = true
    var titles = ["What is Lorem Ipsum?","Why do we use it?","Where does it come from?","Where can I get some?"]
    var details = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).","Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.\n The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.","There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collView.collectionViewLayout = isListView ? generateListLayout() : generateListLayout()
        
        if isListView {
            btnListView.image = UIImage(systemName: SELECTED_IMAGE_LIST)
            btnGridView.image = UIImage(systemName: UNSELECTED_IMAGE_GRID)
        } else {
            btnListView.image = UIImage(systemName: UNSELECTED_IMAGE_LIST)
            btnGridView.image = UIImage(systemName: SELECTED_IMAGE_GRID)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Example3CollectionViewCell
        
        cell.lblListNumber.text = "\(indexPath.row + 1)."
        cell.lblNumber.text = "\(indexPath.row + 1)"
        cell.lblListTitle.text = titles[indexPath.row]
        cell.lblListDetails.text = details[indexPath.row]
        
        if isListView {
            cell.lblListNumber.isHidden = true
            cell.lblListTitle.isHidden = true
            cell.lblListDetails.isHidden = true
            cell.lblNumber.isHidden = false
        } else {
            cell.lblListNumber.isHidden = false
            cell.lblListTitle.isHidden = false
            cell.lblListDetails.isHidden = false
            cell.lblNumber.isHidden = true
        }
        cell.isListView = isListView
        return cell
    }
    
    @IBAction func btnListAction(_ sender: Any) {
        btnListView.image = UIImage(systemName: SELECTED_IMAGE_LIST)
        btnGridView.image = UIImage(systemName: UNSELECTED_IMAGE_GRID)
        isListView = true
        
        DispatchQueue.main.async {
            self.collView.reloadData()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: .curveEaseIn, animations: {
                self.collView.collectionViewLayout.invalidateLayout()
                self.collView.collectionViewLayout = self.generateListLayout()
                self.collView.layoutIfNeeded()
            }, completion: {_ in
                
            })
            
        })
    }
    
    @IBAction func btnGridAction(_ sender: Any) {
        btnListView.image = UIImage(systemName: UNSELECTED_IMAGE_LIST)
        btnGridView.image = UIImage(systemName: SELECTED_IMAGE_GRID)
        isListView = false
        
        DispatchQueue.main.async {
            self.collView.reloadData()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.3, options: .curveLinear, animations: {
                self.collView.collectionViewLayout.invalidateLayout()
                self.collView.collectionViewLayout = self.generateGridLayout()
            }, completion: {_ in
            })
        })
        
    }
    
    @IBAction func btnAddAction(_ sender: Any) {
        titles.append("1914 translation by H. Rackham")
        details.append("On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.")
        
        collView.reloadData()
        collView.scrollToItem(at: IndexPath(row: titles.count - 1, section: 0), at: .bottom, animated: true)
        
    }
    
    private func generateListLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //making addition here because what ever width you will give it will get deducted from leading  of item content insets in actual frame of cell, and deduction beucase of bottom content size
            let edgeInsets = NSDirectionalEdgeInsets(top: 0, leading: CELL_LEADING, bottom: CELL_LEADING, trailing: 0)
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(LIST_SIZE - edgeInsets.top + edgeInsets.leading - edgeInsets.bottom + edgeInsets.trailing),
                                                  heightDimension: .absolute(LIST_SIZE))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = edgeInsets
            // Show one item plus peek on narrow screens, two items plus peek on wider screens
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(self.collView.frame.width),
                heightDimension: .estimated(10))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [sectionHeader]
            //            section.orthogonalScrollingBehavior = .continuous
            //
            
            return section
        }
        return layout
    }
    
    private func generateGridLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.collView.frame.width - 20),
                                                  heightDimension: .estimated(10))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            // Show one item plus peek on narrow screens, two items plus peek on wider screens
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(self.collView.frame.width - 20),
                heightDimension: .estimated(10))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [sectionHeader]
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            //            section.orthogonalScrollingBehavior = .continuous
            //
            
            return section
        }
        return layout
    }
    
}
