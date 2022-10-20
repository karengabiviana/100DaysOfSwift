//
//  ViewController.swift
//  Challenge Milestone 7-9
//
//  Created by Karen Oliveira on 26/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    var allWords = [String]()
    var usedLetters = [String]()
    var wrongLetters = [String]()
    
    var word = String()
    var letter = String()
    var displayWord = String()
    
    var wordLabel = UILabel()
    var scoreLabel = UILabel()
    var slotMistakes = [UILabel]()
    
    var mistakesView = UIStackView()
    var showMistakesView = UIView()
    
    var allLetterButtons = [UIButton]()
    let buttonTitle = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",  "U", "", "V", "W", "X", "Y", "Z", ""]
    
    var mistakes = 0
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    let leftTitleAlertAction = "New Game"
    let nextRightTitleAlertAction = "Next Word"
    let revealRigthMessageAlertAction = "Reveal Word"
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        integrateWordBase()
        setRandomWord()
        checkIfWordContainsLetter()
        
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
    }
    
    func setRandomWord() {
        word = allWords.randomElement() ?? "silkworm"
        word = word.uppercased()
    }
    
    func checkIfWordContainsLetter() {
        //clean variable to not concatenated with last version
        displayWord = ""
        
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
        
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.text = displayWord
        wordLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(wordLabel)
        
        constraintsLabels()
    }
    
    func configViews() {
        showMistakesView.translatesAutoresizingMaskIntoConstraints = false
        showMistakesView.layer.cornerRadius = 16
        showMistakesView.layer.borderWidth = 1
        view.addSubview(showMistakesView)
        
        mistakesView.translatesAutoresizingMaskIntoConstraints = false
        mistakesView.axis = .horizontal
        mistakesView.alignment = .center
        mistakesView.distribution = .fillEqually
        mistakesView.spacing = 4
        showMistakesView.addSubview(mistakesView)
        
        constraintsViews()
        addSlotsMistakes()
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
                
                let frame = CGRect(x: 32 + (column * width), y: 400 + (row * height), width: width, height: height)
                letterButton.frame = frame
                
                view.addSubview(letterButton)
                allLetterButtons.append(letterButton)
                
                i += 1
            }
        }
    }
    
    func constraintsLabels() {
        NSLayoutConstraint.activate([
            
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            scoreLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
    }
    
    func constraintsViews() {
        NSLayoutConstraint.activate([
            showMistakesView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 64),
            showMistakesView.bottomAnchor.constraint(equalTo: wordLabel.topAnchor, constant: -72),
            showMistakesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            showMistakesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            mistakesView.topAnchor.constraint(equalTo: showMistakesView.topAnchor, constant: 16),
            mistakesView.bottomAnchor.constraint(equalTo: showMistakesView.bottomAnchor, constant: -16),
            mistakesView.leadingAnchor.constraint(equalTo: showMistakesView.leadingAnchor, constant: 16),
            mistakesView.trailingAnchor.constraint(equalTo: showMistakesView.trailingAnchor, constant: -16),
            
        ])
    }
    
    func addSlotsMistakes() {
        
        for number in 1...7 {
            let slot = UILabel()
            slot.text = String(number)
            slot.textColor = .lightGray
            slot.textAlignment = .center
            slot.layer.borderWidth = 1
            slot.layer.cornerRadius = 10
            slot.layer.borderColor = .init(gray: 0.6, alpha: 1)
            slot.backgroundColor = .white
            
            mistakesView.addArrangedSubview(slot)
            slotMistakes.append(slot)
        }
    }
    
    @objc func checkingLetter(_ button: UIButton) {
        // get letter from the button
        let titleLetter = button.titleLabel?.text ?? "!"
        // for comparison in 'wordContainsLetter' it must have a string
        let strLetter = String(titleLetter)
        
        //add letter on array to check
        usedLetters.append(strLetter)
        
        checkIfWordContainsLetter()
        
        wordLabel.text = displayWord
        
        button.isEnabled = false
        
        //in case the answer is the wrong letter
        // letter will apear in the mistakes view
        if !word.contains(strLetter) {
            wrongLetters.append(strLetter)
            slotMistakes[mistakes].text = strLetter
            slotMistakes[mistakes].textColor = .black
            slotMistakes[mistakes].layer.borderColor = .init(gray: 0, alpha: 1)
            
            mistakes += 1
        }
        
        validateScorePoints()
    }
    
    func validateScorePoints() {
        if mistakes < 7 && !displayWord.contains("?") {
            score += 3
            setAlert(if: true)
        } else if mistakes == 7 {
            score -= 1
            setAlert(if: false)
        }
    }
    
    func setAlert(if status: Bool) {
        var titleAlert: String
        var messageAlert: String
        
        var leftButttonAlert: UIAlertAction
        var rightButtonAlert: UIAlertAction
        
        switch status {
        case true:
            
            titleAlert = "Good Game!"
            messageAlert = "Your score is \(score).\n Let's go to the next word?"
            
            leftButttonAlert = UIAlertAction(title: leftTitleAlertAction, style: .destructive, handler: startFromScratch)
            rightButtonAlert = UIAlertAction(title: nextRightTitleAlertAction, style: .default, handler: setNextWord)
            
        case false:
            
            titleAlert = "Sorry!"
            messageAlert = "Your score is \(score).\n Good Luck with the next!"
            
            leftButttonAlert = UIAlertAction(title: leftTitleAlertAction, style: .destructive, handler: startFromScratch)
            rightButtonAlert = UIAlertAction(title: revealRigthMessageAlertAction, style: .default, handler: revealTheWord)
        }
        
        let ac = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)
        
        ac.addAction(leftButttonAlert)
        ac.addAction(rightButtonAlert)
        
        present(ac, animated: true)
    }
    
    func startFromScratch(action: UIAlertAction!) {
        resetGame()
        score = 0
    }
    
    func setNextWord(action: UIAlertAction!) {
        resetGame()
    }
    
    func revealTheWord(action: UIAlertAction!) {
        let ac = UIAlertController(title: "The word is:" , message: word, preferredStyle: .alert)
        
        present(ac, animated: true)
        let leftButton = UIAlertAction(title: leftTitleAlertAction, style: .destructive, handler: startFromScratch)
        let rightButton = UIAlertAction(title: nextRightTitleAlertAction, style: .default, handler: setNextWord)
        
        ac.addAction(leftButton)
        ac.addAction(rightButton)
    }
    
    func resetGame() {
        // reset word label
        displayWord = ""
        usedLetters = []
        setRandomWord()
        checkIfWordContainsLetter()
        wordLabel.text = displayWord
        
        // reset mistakes
        for mistakes in 0...6 {
            slotMistakes[mistakes].text = String(mistakes+1)
            slotMistakes[mistakes].textColor = .lightGray
            slotMistakes[mistakes].textAlignment = .center
            slotMistakes[mistakes].layer.borderWidth = 1
            slotMistakes[mistakes].layer.cornerRadius = 10
            slotMistakes[mistakes].layer.borderColor = .init(gray: 0.6, alpha: 1)
            slotMistakes[mistakes].backgroundColor = .white
        }
        wrongLetters = []
        mistakes = 0
        
        //reset buttons
        for button in allLetterButtons.indices {
            allLetterButtons[button].isEnabled = true
        }
    }
}
