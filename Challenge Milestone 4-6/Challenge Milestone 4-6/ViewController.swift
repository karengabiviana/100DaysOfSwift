//
//  ViewController.swift
//  Challenge Milestone 4-6
//
//  Created by Karen Oliveira on 17/08/22.
//

import UIKit

class ViewController: UITableViewController {
    var items = [String]() // where the items will be save
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar
        title = "My List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearItems))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    @objc func addItem() {
        
    }
    
    @objc func clearItems() {
        
    }
}

