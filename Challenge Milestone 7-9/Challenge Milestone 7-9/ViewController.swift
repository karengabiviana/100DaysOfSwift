//
//  ViewController.swift
//  Challenge Milestone 7-9
//
//  Created by Karen Oliveira on 26/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    var labelTest = UILabel()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .orange
        
        // MARK: "database" logic
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        
        // MARK: Labels
        labelTest = UILabel()
        labelTest.translatesAutoresizingMaskIntoConstraints = false
        labelTest.text = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        view.addSubview(labelTest)
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
            labelTest.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
}

