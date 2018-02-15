//
//  LibraryModel.swift
//  Aliyah Media
//
//  Created by nitin bhatia on 2/12/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import Foundation

class LibraryModel{
    var id : String
    var name : String
    var date : String
    var totalItems : String
    
    init(id:String,name:String,date:String,totalItems:String){
        self.id = id
        self.name = name
        self.date = date
        self.totalItems = totalItems
    }
}
