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
    var usedLetters = [String]()
    var wrongLetters = [String]()
    
    var word = String()
    var letter = String()
    var displayWord = String()
    
    var mainLabel = UILabel()
    var scoreLabel = UILabel()
    
    var slotMistakes = [UIButton]()
    
    var mistakesView = UIStackView()
    
    let buttonTitle = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",  "U", "", "V", "W", "X", "Y", "Z", ""]
    
    var mistakes = 0
    
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
        setRandomWord()
        wordContainsLetter()
        
        configLabels()
        configViews()
        configLettersButtons()
     
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
    
    func setRandomWord() {
        word = allWords.randomElement() ?? "silkworm"
        word = word.uppercased()
    }
    
    func wordContainsLetter() {
        
        for letter in word {
            let strLetter = String(letter)
            
            if usedLetters.contains(strLetter) {
                displayWord += strLetter
            } else {
                displayWord += "?"
            }
        }
        
    }
    
    func configLabels() {
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: \(score)"
        scoreLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(scoreLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.text = displayWord
        mainLabel.font = UIFont.systemFont(ofSize: 24)
        usedWords.removeAll(keepingCapacity: true)
        view.addSubview(mainLabel)
        
        constraintsLabels()
    }
    
    func configViews() {
        mistakesView.translatesAutoresizingMaskIntoConstraints = false
        mistakesView.layer.cornerRadius = 16
        mistakesView.layer.borderWidth = 1
        view.addSubview(mistakesView)
        
        mistakesView.axis = .horizontal
        mistakesView.alignment = .center
        mistakesView.distribution = .fillEqually
        mistakesView.spacing = 4

        
        constraintsViews()
        addSlotsMistakes()
    }
    
    func addSlotsMistakes() {
       
        for number in 1...7 {
            let slot = UIButton()
            slot.setTitle(String(number), for: .normal)
            slot.layer.borderWidth = 1
            slot.layer.cornerRadius = 16
            slot.backgroundColor = .white
            mistakesView.addArrangedSubview(slot)
            slotMistakes.append(slot)
        }
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
                letterButton.addTarget(self, action: #selector(checkingLetter), for: .touchUpInside)
                
                let frame = CGRect(x: 16 + (column * width), y: 320 + (row * height), width: width, height: height)
                letterButton.frame = frame
                
                view.addSubview(letterButton)
                
                i += 1
            }
        }
    }
    
    
    func constraintsLabels() {
        NSLayoutConstraint.activate([
            
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            scoreLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
    }
    
    func constraintsViews() {
        NSLayoutConstraint.activate([
            mistakesView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 64),
            mistakesView.bottomAnchor.constraint(equalTo: mainLabel.topAnchor, constant: -72),
            mistakesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mistakesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        
        ])
    }
    
    
    @objc func checkingLetter(_ button: UIButton) {
        
        let titleLetter = button.titleLabel?.text ?? "!"
        let strLetter = String(titleLetter)
        
        usedLetters.append(strLetter)
       
        displayWord = ""
        wordContainsLetter()
        mainLabel.text = displayWord
        button.isEnabled = false
        
        if !word.contains(strLetter) {
            wrongLetters.append(strLetter)
            slotMistakes[mistakes].setTitle(strLetter, for: .normal)
            slotMistakes[mistakes].backgroundColor = .lightGray

            mistakes += 1
        }
    }
}
