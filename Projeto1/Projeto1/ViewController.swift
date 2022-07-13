//
//  ViewController.swift
//  Projeto1
//
//  Created by Karen Oliveira on 29/06/22.
//

import UIKit // the file will reference toolkit

//create a new screen of data called ViewController, based on UIViewController
//we change the UIViewController by UITableViewController
class ViewController: UITableViewController {
    var pictures = [String]()
    
    //method is override from UIViewController, means we can to modify
    override func viewDidLoad() {
        //super means this will run before we run ours
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //FileManager is a data type using to look for files
        let fm = FileManager.default
        // we will tell Bundle.main.resourcePath! the path of my files
        let path = Bundle.main.resourcePath!
        //items will be a String with the name of our files
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        //loop
        for item in items.sorted() {
            // if files name begins with nssl
            if item.hasPrefix("nssl") {
                //this is a picture to load
                pictures.append(item)
            }
        }
        print(pictures)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.totalPictures = pictures.count
            vc.selectedPictureNumber = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

