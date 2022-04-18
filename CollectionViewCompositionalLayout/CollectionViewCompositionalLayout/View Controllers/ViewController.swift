//
//  ViewController.swift
//  CollectionViewCompositionalLayout
//
//  Created by Nitin Bhatia on 06/04/22.
//

import UIKit

enum Section: String, CaseIterable {
    case featuredAlbums = "Featured Albums"
    case sharedAlbums = "Shared Albums"
    case myAlbums = "My Albums"
}

class ViewController: UIViewController {
    
    //variables
    var dataSource: UICollectionViewDiffableDataSource<Section, AlbumItem>! = nil
    
    
    //outlets
    @IBOutlet weak var collView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        let snapshot = snapshotForCurrentState()
        //        dataSource.apply(snapshot, animatingDifferences: false)
       
        configureDataSource()
        collView.collectionViewLayout = generateLayout()
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, AlbumItem>(collectionView: collView) {
            (collectionView: UICollectionView, indexPath: IndexPath, albumItem: AlbumItem) -> UICollectionViewCell? in
            
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .featuredAlbums:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FeaturedCollectionViewCell.reuseIdentifer,
                    for: indexPath) as? FeaturedCollectionViewCell else { fatalError("Could not create new cell") }
                cell.imgTile.image = UIImage(contentsOfFile: albumItem.imageItems[0].thumbnailURL.path)
                cell.lblTitle.text = albumItem.albumTitle
                cell.lblCount.text = "\(albumItem.imageItems.count) Photos"
                return cell
                
            case .sharedAlbums:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SharedCollectionViewCell.reuseIdentifer,
                    for: indexPath) as? SharedCollectionViewCell else { fatalError("Could not create new cell") }
                cell.imgTile.image = UIImage(contentsOfFile: albumItem.imageItems[0].thumbnailURL.path)
                cell.lblTitle.text = albumItem.albumTitle
                return cell
                
            case .myAlbums:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AlbumsCollectionViewCell.reuseIdentifer,
                    for: indexPath) as? AlbumsCollectionViewCell else { fatalError("Could not create new cell") }
                cell.imgTile.image = UIImage(contentsOfFile: albumItem.imageItems[0].thumbnailURL.path)
                cell.lblTitle.text = albumItem.albumTitle
                return cell
                
            }
        }
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "sectionHeader",
                for: indexPath) as? HeaderView else { fatalError("Cannot create header view") }
            
            supplementaryView.lblTitle.text = Section.allCases[indexPath.section].rawValue
            return supplementaryView
        }
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, AlbumItem> {
        let allAlbums = albumsInBaseDirectory()
        let sharingSuggestions = Array(albumsInBaseDirectory().prefix(3))
        let sharedAlbums = Array(albumsInBaseDirectory().suffix(3))
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, AlbumItem>()
        snapshot.appendSections([Section.featuredAlbums])
        snapshot.appendItems(sharingSuggestions)
        
        snapshot.appendSections([Section.sharedAlbums])
        snapshot.appendItems(sharedAlbums)
        
        snapshot.appendSections([Section.myAlbums])
        snapshot.appendItems(allAlbums)
        return snapshot
    }
    
    func albumsInBaseDirectory() -> [AlbumItem] {
        guard let bundleURL = Bundle.main.url(forResource: "PhotoData", withExtension: "") else { return [AlbumItem]() }
        // guard let baseURL = bundleURL else { return [] }
        
        let fileManager = FileManager.default
        do {
            return try fileManager.albumsAtURL(bundleURL)
        } catch {
            print(error)
            return []
        }
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch (sectionLayoutKind) {
            case .featuredAlbums: return self.generateFeaturedAlbumsLayout(isWide: isWideView)
            case .sharedAlbums: return self.generateSharedlbumsLayout()
            case .myAlbums: return self.generateMyAlbumsLayout(isWide: isWideView)
            }
        }
        return layout
    }
    
    func generateFeaturedAlbumsLayout(isWide: Bool) -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .fractionalWidth(2/3))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)

      // Show one item plus peek on narrow screens, two items plus peek on wider screens
      let groupFractionalWidth = isWide ? 0.475 : 0.95
      let groupFractionalHeight: Float = isWide ? 1/3 : 2/3
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
        heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
      group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(44))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: headerSize,
        elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

      let section = NSCollectionLayoutSection(group: group)
      section.boundarySupplementaryItems = [sectionHeader]
      section.orthogonalScrollingBehavior = .groupPaging

      return section
    }

    
    func generateSharedlbumsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(140),
            heightDimension: .absolute(186))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func generateMyAlbumsLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let groupHeight = NSCollectionLayoutDimension.fractionalWidth(isWide ? 0.25 : 0.5)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: isWide ? 4 : 2)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let vc = storyboard?.instantiateViewController(identifier: "details") as! AlbumDetailViewController
        vc.albumURL = item.albumURL
        navigationController?.pushViewController(vc, animated: true)
    }
}
