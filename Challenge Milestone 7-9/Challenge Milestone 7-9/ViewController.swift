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
    var theWord = String()
    
    var theSplitWord = [Character]()
    var hideWord = [Character]()
    
    var mainLabel = UILabel()
    var scoreLabel = UILabel()
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    
    var buttonsView = UIView()
    var mistakesView = UIView()
    
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
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
        
        
        // MARK: Config UI Elements
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: \(score)"
        scoreLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(scoreLabel)
        
        mistakesView.translatesAutoresizingMaskIntoConstraints = false
//        mistakesView.backgroundColor = .orange
        mistakesView.layer.cornerRadius = 16
        mistakesView.layer.borderWidth = 1
//        mistakesView.layer.borderColor =
        view.addSubview(mistakesView)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.text = String(hideWord)
        mainLabel.font = UIFont.systemFont(ofSize: 24)
        usedWords.removeAll(keepingCapacity: true)
        view.addSubview(mainLabel)
        
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
            
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            scoreLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            mistakesView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 64),
            mistakesView.bottomAnchor.constraint(equalTo: mainLabel.topAnchor, constant: -72),
            mistakesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mistakesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
//            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 40),
            buttonsView.leadingAnchor.constraint(greaterThanOrEqualTo:  view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonsView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            
        ])
        
        // MARK: Buttons
        let width = 40
        let height = 40
        var i = 0
        
        for row in 0..<4 {
            for column in 0..<7 {
            
                let buttonTitle = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",  "U", "", "V", "W", "X", "Y", "Z", ""]
                
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                letterButton.tintColor = .black
                letterButton.setTitle(buttonTitle[ i ], for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                i += 1
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @objc func letterTapped(_ sender: UIButton) {
    }
    
//    @objc func submitTapped(_ sender: UIButton) {
//
//    }
//
//    @objc func clearTapped(_ sender: UIButton) {
//
//    }
}

