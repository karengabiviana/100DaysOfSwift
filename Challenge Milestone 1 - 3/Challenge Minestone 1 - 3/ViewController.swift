//
//  ViewController.swift
//  Challenge Minestone 1 - 3
//
//  Created by Karen Oliveira on 22/07/22.
//

import UIKit

class ViewController: UITableViewController {

    var flags = [UIImage(named: "estonia"), UIImage(named: "france")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Milestone 1 - 3"
        
        
//        let fm = FileManager.default
//        let path = Bundle.main.resourcePath!
//        let items = try! fm.contentsOfDirectory(atPath: path)
//
//        for item in items {
//            flags.append(item)
//
//        }
//
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        //cell.textLabel?.image = flags[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flags.count
    }
}
