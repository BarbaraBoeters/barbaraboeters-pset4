//
//  DatabaseHelper.swift
//  barbaraboeters-pset4
//
//  Created by Barbara Boeters on 22-11-16.
//  Copyright © 2016 Barbara Boeters. All rights reserved.
//

import Foundation
import SQLite

class DatabaseHelper {
    
    private let list = Table("list")
    private let id = Expression<Int64>("id")
    private let item = Expression<String?>("item")
    
    private var db: Connection?

    init?() {
        do {
            try setupDatabase()
        } catch {
            print(error)
            return nil
        }
    }
    
    
    private func setupDatabase() throws {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do {
            db = try Connection("\(path)/db.sqlite3")
            try createTable()
        } catch {
            throw error
        }
    }
    
    private func createTable() throws {
        do {
            try db!.run(list.create(ifNotExists: true) {
                t in
                t.column(id, primaryKey: .autoincrement)
                t.column(item, unique: true)
            })
        } catch {
            throw error
        }
    }
    
    func create(item: String) throws {
        let insert = list.insert(self.item <- item)
        do {
            let rowId = try db!.run(insert)
            print(rowId)
        } catch {
            throw error
        }
    }
}
