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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if db == nil {
            print("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addTodo(_ sender: Any) {
        do {
            try db!.create(item: inputText.text!)
        } catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

