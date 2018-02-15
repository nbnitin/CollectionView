//
//  ExtraData.swift
//  CollectionView
//
//  Created by Nitin Bhatia on 30/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import Foundation

class Data1{
    var img : String
    var like : Int
    var dislike : Int
    
    init(img : String,like : Int , dislike : Int){
        self.img = img
        self.like = like
        self.dislike = dislike
    }
    
    class func setupData()->[Data1]{
    
        var data : [Data1] = []
        for i in 0...5{
            let d = Data1(img: "image-\(i+1)", like: 0, dislike: 0)
            data.append(d)
        }
        return data
      }
}
