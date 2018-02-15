//
//  Articles.swift
//  Aliyah Media
//
//  Created by nitin bhatia on 2/14/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import Foundation

class Articles{
    var id : String
    var title : String
    var desc : String
    var like : String
    var comment : String
    var share : String
    var image : String
    var category : [String:String]
    
    init(id : String, title : String, desc : String, like : String, comment : String, share : String, category : [String:String], image : String ){
        self.id = id
        self.title = title
        self.desc = desc
        self.like = like
        self.comment = comment
        self.share = share
        self.category = category
        self.image = image
    }
}
