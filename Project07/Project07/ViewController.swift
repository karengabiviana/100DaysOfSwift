//
//  ViewController.swift
//  Project07
//
//  Created by Karen Oliveira on 29/08/22.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions: [Petition]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(credits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPrompt))
        
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    @objc func credits() {
        let ac = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    @objc func searchPrompt() {
        let ac = UIAlertController(title: "What do you looking for?", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let refresh = UIAlertAction (title: "Clear", style: .cancel) {
            [unowned self] _ in
            self.refreshView()
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [unowned self, ac] _ in
            let answer = ac.textFields![0].text
            self.submit(answer!)
        }
        ac.addAction(submitAction)
        ac.addAction(refresh)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        // if petition has answer inside
        // add to filteredPetitions array
        DispatchQueue.global().async{
            self.filteredPetitions = self.petitions.filter {$0.title.contains(answer) || $0.body.contains(answer) }
        }
        
        // show filteredPetitions
        tableView.reloadData()
        // go back to the initial list
    }
    
    func refreshView() {
        filteredPetitions = nil
        tableView.reloadData()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPetitions?.count ?? petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = (filteredPetitions != nil ? filteredPetitions : petitions)?[indexPath.row]
        cell.textLabel?.text = petition?.title
        cell.detailTextLabel?.text = petition?.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

 
   
