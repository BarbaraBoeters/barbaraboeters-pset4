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
    let check: Bool
    
    init(id:Int64) {
        self.id = id
        item = ""
        self.check = false
    }
    
    init(id:Int64, item:String, check:Bool) {
        self.id = id
        self.item = item
        self.check = check
    }
}
