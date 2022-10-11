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
    
    var word = String()
    var usedLetters = [String]()
    var displayWord = String()
    
    var mainLabel = UILabel()
    var scoreLabel = UILabel()
    
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
        setRandomWord()
        manipulateWord()
        
        configLabels()
        configViews()
        configLettersButtons()
        plusButton()
     
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
    }
    
    func manipulateWord() {
        
        for letter in word {
            let strLetter = String(letter)
            
            if usedLetters.contains(strLetter) {
                displayWord += strLetter
            } else {
                displayWord += "?"
            }
        }

    }
    
   @objc func checkingLetter() {
       let letter = word.first ?? "@"
       let strLetter = String(letter)
       
        usedLetters.append(strLetter)
        manipulateWord()
        mainLabel.text = displayWord
//        displayWord = ""
    
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
        //        mistakesView.backgroundColor = .orange
        mistakesView.layer.cornerRadius = 16
        mistakesView.layer.borderWidth = 1
        //        mistakesView.layer.borderColor =
        view.addSubview(mistakesView)
        
        
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        constraintsViews()
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
                i += 1
            }
            
        }
    }
    
    
    func plusButton() {
        plus.translatesAutoresizingMaskIntoConstraints = false
        plus.setTitle("+", for: .normal)
        plus.backgroundColor = .lightGray
        view.addSubview(plus)
        
        plus.addTarget(self, action: #selector(checkingLetter), for: .touchUpInside)
        
        constraintsPlusButton()
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
            
            buttonsView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 40),
            buttonsView.leadingAnchor.constraint(greaterThanOrEqualTo:  view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonsView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    
    func constraintsPlusButton() {

        
        NSLayoutConstraint.activate([
            plus.centerXAnchor.constraint(equalTo: mainLabel.centerXAnchor),
            plus.topAnchor.constraint(equalTo: mainLabel.bottomAnchor),
            plus.widthAnchor.constraint(equalToConstant: 40),
            plus.heightAnchor.constraint(equalToConstant: 40)
//            plus.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
        ])
    
    }
    
    @objc func letterTapped() {
        
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
        
//        let butttonTapped = Array(_immutableCocoaArray: sender.titleLabel!) ?? ["!"]
        print("Passou")
//        if theWord.contains(butttonTapped[0]){
//            hideWord.append(contentsOf: butttonTapped[0])
//            //            self.loadView()
//        }
    }
    
    func submit(_ answer:String) {
//        var strAnswer = answer
//        var charAnswer = Array(strAnswer)
//
//        if strAnswer != "!" {
//            if splitWord.contains(charAnswer[0]) {
//
//                splitWord.append(contentsOf: strAnswer)
//
//                self.loadView()
//            }
//        }
    }
}


