//
//  ViewController.swift
//  CollectionView
//
//  Created by Nitin Bhatia on 30/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var data : Data? = nil

    @IBOutlet weak var lblDislike: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img1 = data?.img
        let like = data?.like
        let dislike = data?.dislike
        
        img.image = UIImage(named: img1!)
        lblDislike.text = "Total Dislikes : \(dislike!)"
        lblLike.text = "Total Likes : \(like!)"
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
