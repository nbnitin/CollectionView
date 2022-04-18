//
//  AlbumDetailViewController.swift
//  CollectionViewCompositionalLayout
//
//  Created by Nitin Bhatia on 06/04/22.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    //variables
    var dataSource: UICollectionViewDiffableDataSource<Section, AlbumDetailItem>! = nil
    var albumURL: URL?
    static let syncingBadgeKind = "syncing-badge-kind"
    
    enum Section {
        case albumBody
    }
    //outlets
    @IBOutlet weak var collView: UICollectionView!
    
    
    convenience init(withPhotosFromDirectory directory: URL) {
        self.init()
        albumURL = directory
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collView.register(SyncingBadgeView.self,
                          forSupplementaryViewOfKind: AlbumDetailViewController.syncingBadgeKind,
                          withReuseIdentifier: SyncingBadgeView.reuseIdentifier)
        configureDataSource()
        collView.collectionViewLayout = generateLayout()
        // Do any additional setup after loading the view.
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, AlbumDetailItem>(collectionView: collView) {
            (collectionView: UICollectionView, indexPath: IndexPath, detailItem: AlbumDetailItem) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath) as? PhotoCollectionViewCell else { fatalError("Could not create new cell") }
            cell.imgTile.image = UIImage(contentsOfFile: detailItem.thumbnailURL.path)
            return cell
        }
        
        dataSource.supplementaryViewProvider = {
            (
                collectionView: UICollectionView,
                kind: String,
                indexPath: IndexPath) -> UICollectionReusableView? in
            
            let hasSyncBadge = indexPath.row % Int.random(in: 1...6) == 0
            
            if let badgeView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SyncingBadgeView.reuseIdentifier,
                for: indexPath) as? SyncingBadgeView {
                
                badgeView.isHidden = !hasSyncBadge
                return badgeView
            } else {
                fatalError("Cannot create new supplementary")
            }
        }
        
        // load our initial data
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        // We have three row styles
        // Style 1: 'Full'
        // A full width photo
        // Style 2: 'Main with pair'
        // A 2/3 width photo with two 1/3 width photos stacked vertically
        // Style 3: 'Triplet'
        // Three 1/3 width photos stacked horizontally
        
        // Syncing badge
        let syncingBadgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: -0.3, y: 0.3))
        let syncingBadge = NSCollectionLayoutSupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(20),
                heightDimension: .absolute(20)),
            elementKind: AlbumDetailViewController.syncingBadgeKind,
            containerAnchor: syncingBadgeAnchor)
        
        // Full
        let fullPhotoItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/3)),
            supplementaryItems: [syncingBadge])
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Main with pair
        let mainItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalHeight(1.0)))
        mainItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let pairItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)))
        pairItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let trailingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)),
            subitem: pairItem,
            count: 2)
        
        let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/9)),
            subitems: [mainItem, trailingGroup])
        
        // Triplet
        let tripletItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)))
        tripletItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let tripletGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/9)),
            subitems: [tripletItem, tripletItem, tripletItem])
        
        // Reversed main with pair
        let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/9)),
            subitems: [trailingGroup, mainItem])
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(16/9)),
            subitems: [fullPhotoItem, mainWithPairGroup, tripletGroup, mainWithPairReversedGroup])
        
        let section = NSCollectionLayoutSection(group:  nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, AlbumDetailItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AlbumDetailItem>()
        snapshot.appendSections([Section.albumBody])
        let items = itemsForAlbum()
        snapshot.appendItems(items)
        return snapshot
    }
    
    func itemsForAlbum() -> [AlbumDetailItem] {
        guard let albumURL = albumURL else { return [] }
        let fileManager = FileManager.default
        do {
            return try fileManager.albumDetailItemsAtURL(albumURL)
        } catch {
            print(error)
            return []
        }
    }
}


//  extension AlbumDetailViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//      guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
//      let photoDetailVC = PhotoDetailViewController(photoURL: item.photoURL)
//      navigationController?.pushViewController(photoDetailVC, animated: true)
//    }
//  }
//


