//
//  CollectionViewHeader.swift
//  CollectionViewCompositionalLayout
//
//  Created by Nitin Bhatia on 06/04/22.
//

import UIKit
class HeaderView: UICollectionReusableView {
    @IBOutlet var lblTitle : UILabel!
}


class SyncingBadgeView: UICollectionReusableView {
  static let reuseIdentifier = "syncing-badge"
    let imageView = UIImageView(image: UIImage(named: "iconfinder_sync-01_186384"))

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
    startAnimating()
  }

  required init?(coder: NSCoder) {
    fatalError("Not implemented")
  }
}

extension SyncingBadgeView {
  func configure() {
    backgroundColor = .white

    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    addSubview(imageView)

    let inset = CGFloat(2)
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      imageView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
    ])

    let radius = bounds.width / 2.0
    layer.cornerRadius = radius
    layer.borderColor = UIColor.black.cgColor
    layer.borderWidth = 1.0
  }

  func startAnimating() {
    let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotation.toValue = Double.pi * 2
    rotation.duration = 1
    rotation.isCumulative = true
    rotation.repeatCount = Float.greatestFiniteMagnitude
    imageView.layer.add(rotation, forKey: "rotationAnimation")
  }
}
