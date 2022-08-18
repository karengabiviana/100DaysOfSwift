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
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Enter an item:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [unowned self, ac] _ in
            let item = ac.textFields![0].text
            self.submit(item!)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func clearItems() {
        items.removeAll()
        tableView.reloadData()
    }
    
    func submit(_ item: String) {
        items.insert(item, at: 0) //add insert on array "items"
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

