//
//  LibraryDetailViewController.swift
//  Aliyah Media
//
//  Created by nitin bhatia on 2/14/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import UIKit

class LibraryDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,PinterestLayoutDelegate,cellDelegate {

    //Mark:- Outlets
    @IBOutlet weak var collView: UICollectionView!
    
    
    //Mark:- Variables
    var libraryId : String!
    var article : [Articles] = []
    private let leftAndRightPaddings: CGFloat = 8.0
    private let numberOfItemsPerRow: CGFloat = 3.0
    private let heightAdjustment: CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        libraryId = "25"
        
        collView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        if let layout = collView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        callApi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark:- Collection view
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return article.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LibraryDetailCollectionViewCell
        cell.lblCat.text = article[indexPath.row].category["title"]
        let str = article[indexPath.row].desc.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
        cell.lblDesc.text = str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        //cell.lblLike.text = article[indexPath.row].like
        cell.lblShare.text = article[indexPath.row].share
        cell.lblComment.text = article[indexPath.row].comment
        cell.lblTitle.text = article[indexPath.row].title
        cell.lblCatDesc.text = "15M"
        cell.delegate = self
        cell.articleId = article[indexPath.row].id
        cell.libId = libraryId
        
        
        //Create Attachment
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = #imageLiteral(resourceName: "icons8-heart-16")
        //Set bound to reposition
        let imageOffsetY:CGFloat = -5.0;
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        //Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        //Add image to mutable string
        completeText.append(attachmentString)
        //Add your text to mutable string
        let  textAfterIcon = NSMutableAttributedString(string:" " + article[indexPath.row].like)
        completeText.append(textAfterIcon)
        cell.lblLike.textAlignment = .right
        cell.lblLike.attributedText = completeText
        
        cell.addAllCornerRadiusToCell(radius: 5.0)
        cell.addShadow()
       
        return cell
        
    }
    
    
    //MARK: - PINTEREST LAYOUT DELEGATE
          // 1. Returns the photo height
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        
        if ( indexPath.row % 2 != 0 ){
            return 278 - 30
        }
            return 300
    }
    
    //Mark:- Calls api
    func callApi(){
        
        
            
            
            if let path = Bundle.main.path(forResource: "new", ofType: "json") {
                do {
                    let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    if let jsonResult: NSDictionary =  try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    {
                        print(jsonResult)
                        
                        
            let res = jsonResult["data"] as! [String:AnyObject]
            
            if ( res["total"] as! Int != 0 ) {
                let results = res["results"] as! NSArray
                for i in 0...results.count - 1{
                    let data = results[i] as! [String:AnyObject]
                    let cat = data["catid"] as! [String:String]
                    let like = "0"
                    let share = "0"
                    let comment = "0"
                    let id = data["id"] as! String
                    let image = ""
                    let title = data["title"] as! String
                    let desc = data["fulltext"] as! String
                    
                    let temp = Articles.init(id: id, title: title, desc: desc, like: like, comment: comment, share: share, category: cat, image: image)
                    self.article.append(temp)
                }
                self.collView.reloadData()
            }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
       
    }
    
    func cellNeedToRemove(id:String){
        print(id)
        let index = article.index(where: { (item) -> Bool in
            item.id == id // test if this is the item you're looking for
        })
        let indexPath = IndexPath(row: index!, section: 0)
        self.article.remove(at: index!)
        self.collView.deleteItems(at: [indexPath])
    }

}
