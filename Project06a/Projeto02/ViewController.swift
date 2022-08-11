//
//  ViewController.swift
//  Projeto02
//
//  Created by Karen Oliveira on 14/07/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var rounds = 0
    var message =  ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain","uk", "us"]
        
        
        
        //border
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        button1.imageView?.contentMode = .scaleAspectFill
        
        askQuestion(action: nil)
        
    }
    
    func askQuestion(action: UIAlertAction!) {
        
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        //Score on Navigation Bar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
        
        correctAnswer = Int.random(in:0...2)
        title = (countries[correctAnswer].uppercased())
        }
    
    @objc func showScore() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score.description)")
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        message = "Your score is \(score)"
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! \n That’s the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        //Tracking number of rounds
        rounds += 1
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                
                present(ac, animated: true)
        
        //After 10 rounds message alert change
        if rounds == 10{
            ac.title = "Game Over"
            ac.message =  "After 10 rounds \n Your final score is \(score)"
        }

    }
        
}

