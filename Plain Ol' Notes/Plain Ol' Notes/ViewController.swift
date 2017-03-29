//
//  ViewController.swift
//  Plain Ol' Notes
//
//  Created by Todd Perkins on 12/6/16.
//  Copyright © 2016 Todd Perkins. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    var data:[String] = ["Row 1","Row 2","Row 3","Row 1","Row 2","Row 3","Row 1","Row 2","Row 3","Row 1","Row 2","Row 3","Row 1","Row 2","Row 3","Row 1","Row 2","Row 3","Row 1","Row 2","Row 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Notes"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNotes))
        
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        
    }
    
    func addNotes() {
        let name : String = "Row \(data.count + 1)"
        data.insert(name, at: 0)
        let indexPath: IndexPath = IndexPath (row:0, section:0)
        table.insertRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell:UITableViewCell = UITableViewCell()
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!        
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }


}

