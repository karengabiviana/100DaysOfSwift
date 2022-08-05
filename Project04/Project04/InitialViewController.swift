//
//  InitialViewController.swift
//  Project04
//
//  Created by Karen Oliveira on 05/08/22.
//

import UIKit

class InitialViewController: UITableViewController {
    var websites = ["google.com","apple.com", "hackingwithswift.com"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       websites.count
     }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "site", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
     }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Browser") as? ViewController {
            vc.website = websites[indexPath.row]
            vc.viewDidLoad()
            navigationController?.pushViewController(vc , animated: true)
        }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browser"
        // Do any additional setup after loading the view.
    }
    

}
