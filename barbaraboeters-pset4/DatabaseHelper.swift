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
    static let instance = DatabaseHelper()
    private var db: Connection?

    private let list = Table("list")
    private let id = Expression<Int64>("id")
    private let item = Expression<String?>("item")
    
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
                t.column(item)
            })
        } catch {
            throw error
        }
    }

    func addItem(citem: String) throws -> Int64? {
        do {
            let insert = list.insert(item <- citem)
            let id = try db!.run(insert)
            print(id)
            print(insert.asSQL())
            return id
        } catch {
            throw error
        }
    }
    
    func getList() -> [List] {
        var items = [List]()
        do {
            for list in try db!.prepare(self.list) {
                items.append(List(id: list[id], item: list[item]!))
            }
        } catch {
            print("Select failed")
        }
        return items
    }
    
    func deleteItem(cid: Int64) -> Bool {
        do {
            let thing = list.filter(id == cid)
            try db!.run(thing.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
}
