//
//  AlbumItem.swift
//  CollectionViewCompositionalLayout
//
//  Created by Nitin Bhatia on 06/04/22.
//

import Foundation

class AlbumItem: Hashable {
  let albumURL: URL
  let albumTitle: String
  let imageItems: [AlbumDetailItem]

  init(albumURL: URL, imageItems: [AlbumDetailItem] = []) {
    self.albumURL = albumURL
    self.albumTitle = albumURL.lastPathComponent.displayNicely
    self.imageItems = imageItems
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  static func == (lhs: AlbumItem, rhs: AlbumItem) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  private let identifier = UUID()
}

class AlbumDetailItem: Hashable {
  let photoURL: URL
  let thumbnailURL: URL
  let subitems: [AlbumDetailItem]

  init(photoURL: URL, thumbnailURL: URL, subitems: [AlbumDetailItem] = []) {
    self.photoURL = photoURL
    self.thumbnailURL = thumbnailURL
    self.subitems = subitems
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  static func == (lhs: AlbumDetailItem, rhs: AlbumDetailItem) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  private let identifier = UUID()
}





extension FileManager {
  func albumsAtURL(_ fileURL: URL) throws -> [AlbumItem] {
    let albumsArray = try self.contentsOfDirectory(
      at: fileURL,
      includingPropertiesForKeys: [.nameKey, .isDirectoryKey],
      options: .skipsHiddenFiles
    ).filter { (url) -> Bool in
      do {
        let resourceValues = try url.resourceValues(forKeys: [.isDirectoryKey])
        return resourceValues.isDirectory! && url.lastPathComponent.first != "_"
      } catch { return false }
    }.sorted(by: { (urlA, urlB) -> Bool in
      do {
        let nameA = try urlA.resourceValues(forKeys:[.nameKey]).name
        let nameB = try urlB.resourceValues(forKeys: [.nameKey]).name
        return nameA! < nameB!
      } catch { return true }
    })

    return albumsArray.map { fileURL -> AlbumItem in
      do {
        let detailItems = try self.albumDetailItemsAtURL(fileURL)
        return AlbumItem(albumURL: fileURL, imageItems: detailItems)
      } catch {
        return AlbumItem(albumURL: fileURL)
      }
    }
  }

  func albumDetailItemsAtURL(_ fileURL: URL) throws -> [AlbumDetailItem] {
    guard let components = URLComponents(url: fileURL, resolvingAgainstBaseURL: false) else { return [] }

    let photosArray = try self.contentsOfDirectory(
      at: fileURL,
      includingPropertiesForKeys: [.nameKey, .isDirectoryKey],
      options: .skipsHiddenFiles
    ).filter { (url) -> Bool in
      do {
        let resourceValues = try url.resourceValues(forKeys: [.isDirectoryKey])
        return !resourceValues.isDirectory!
      } catch { return false }
    }.sorted(by: { (urlA, urlB) -> Bool in
      do {
        let nameA = try urlA.resourceValues(forKeys:[.nameKey]).name
        let nameB = try urlB.resourceValues(forKeys: [.nameKey]).name
        return nameA! < nameB!
      } catch { return true }
    })

    return photosArray.map { fileURL in AlbumDetailItem(
      photoURL: fileURL,
      thumbnailURL: URL(fileURLWithPath: "\(components.path)thumbs/\(fileURL.lastPathComponent)")
      )}
  }
}

extension StringProtocol {
  var firstUppercased: String {
    return prefix(1).uppercased() + dropFirst()
  }

  var displayNicely: String {
    return firstUppercased.replacingOccurrences(of: "_", with: " ")
  }
}
