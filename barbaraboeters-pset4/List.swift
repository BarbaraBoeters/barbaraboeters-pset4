//
//  List.swift
//  barbaraboeters-pset4
//
//  Created by Barbara Boeters on 23-11-16.
//  Copyright © 2016 Barbara Boeters. All rights reserved.
//

import Foundation

class List {
    let id: Int64?
    var item: String
    
    init(id:Int64) {
        self.id = id
        item = ""
    }
    
    init(id:Int64, item:String) {
        self.id = id
        self.item = item
    }
}
