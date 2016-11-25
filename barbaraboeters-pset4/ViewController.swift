//
//  ViewController.swift
//  barbaraboeters-pset4
//
//  Created by Barbara Boeters on 21-11-16.
//  Copyright © 2016 Barbara Boeters. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var addText: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let db = DatabaseHelper()
    private var selectedTodo: Int?
    private var items = [List]()
    var checked = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if db == nil {
            print("error")
        }
        items = DatabaseHelper.instance!.getList()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedTodo = indexPath.row
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        var label: UILabel?
        label = cell.viewWithTag(1) as? UILabel
        cell.label?.text = items[indexPath.row].item
        print(items[indexPath.row].check)
        cell.checkmark.isOn = items[indexPath.row].check
        return cell
    }

    // http://www.ioscreator.com/tutorials/delete-rows-table-view-ios8-swift
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            selectedTodo = indexPath.row
            try db!.deleteItem(cid: items[selectedTodo!].id!)
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func addTodo(_ sender: Any) {
        do {
            try db!.addItem(citem: inputText.text!)
            items = DatabaseHelper.instance!.getList()
            inputText.text = ""
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
}

