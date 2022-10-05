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
    var mainLabel = UILabel()
    var theWord = String()
    var theSplitWord = [Character]()
    var hideWord = [Character]()
    var scoreLabel = UILabel()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
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
        
        // MARK: split string into character
        theWord = allWords.randomElement() ?? "silkworm"
        theSplitWord = Array(theWord)
        
        // MARK: hide word
        for _ in theSplitWord {
            hideWord.append(contentsOf: "?")
        }
        
        
        // MARK: Labels
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.text = String(hideWord)
        usedWords.removeAll(keepingCapacity: true)
        view.addSubview(mainLabel)
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreLabel)
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
}

