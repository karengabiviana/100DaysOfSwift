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
    
    var splitWord = [Character]()
    var hideWord = [Character]()
    
    var mainLabel = UILabel()
    var scoreLabel = UILabel()
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    
    var plus = UIButton()
    
    var buttonsView = UIView()
    var mistakesView = UIView()
    
    let buttonTitle = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",  "U", "", "V", "W", "X", "Y", "Z", ""]
    
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        integrateWordBase()
        randomWord()
        manipulateTheWord()
        
        configLabels()
        configViews()
        configLettersButtons()
        
        
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
            
//            plus.centerXAnchor.constraint(equalTo: mainLabel.centerXAnchor),
//            plus.topAnchor.constraint(equalTo: mainLabel.bottomAnchor),
//            plus.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            
            buttonsView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 40),
            buttonsView.leadingAnchor.constraint(greaterThanOrEqualTo:  view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonsView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            
        ])
        
    }
    
    
    func integrateWordBase() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
    }
    
    func randomWord() {
        theWord = allWords.randomElement() ?? "silkworm"
    }
    
    func manipulateTheWord() {
        splitWord = Array(theWord)
    
        for _ in splitWord {
            hideWord.append(contentsOf: "?")
        }
    }
    
    func configLabels() {
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: \(score)"
        scoreLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(scoreLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.text = String(splitWord)
        mainLabel.font = UIFont.systemFont(ofSize: 24)
        usedWords.removeAll(keepingCapacity: true)
        view.addSubview(mainLabel)
    }
    
    func configViews() {
        mistakesView.translatesAutoresizingMaskIntoConstraints = false
//        mistakesView.backgroundColor = .orange
        mistakesView.layer.cornerRadius = 16
        mistakesView.layer.borderWidth = 1
//        mistakesView.layer.borderColor =
        view.addSubview(mistakesView)
        
        
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
    }
    
    func configLettersButtons() {
        let width = 40
        let height = 40
        var i = 0

        for row in 0..<4 {
            for column in 0..<7 {

                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                letterButton.tintColor = .black
                letterButton.setTitle(String(buttonTitle[ i ]), for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)

                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame

                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                i += 1
            }

        }
    }
    
    func plusButton() {
                plus.translatesAutoresizingMaskIntoConstraints = false
                plus.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                plus.backgroundColor = .orange
                view.addSubview(plus)
    }
    

    @objc func letterTapped(_ sender: UIButton) {
        
//        let ac = UIAlertController(title: "Let's Go!", message: nil, preferredStyle: .alert)
//        ac.addTextField()
//
//        let submitAction = UIAlertAction(title: "submit", style: .default) {
//            [unowned self] _ in
//            let answer = ac.textFields![0].text
//            self.submit(answer!)
//        }
//        ac.addAction(submitAction)
//        present(ac, animated: true)
        
        let butttonTapped = Array(_immutableCocoaArray: sender.titleLabel!) ?? ["!"]

        if theWord.contains(butttonTapped[0]){
            hideWord.append(contentsOf: butttonTapped[0])
//            self.loadView()
        }
    }
    
    func submit(_ answer:String) {
        var strAnswer = answer
        var charAnswer = Array(strAnswer)
        
        if strAnswer != "!" {
            if splitWord.contains(charAnswer[0]) {
            
                splitWord.append(contentsOf: strAnswer)
            
                self.loadView()
            }
        }
    }
}


