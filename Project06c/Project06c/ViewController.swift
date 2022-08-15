//
//  ViewController.swift
//  Project06c
//
//  Created by Karen Oliveira on 15/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    var titleLabel = UILabel()
    var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleLabel()
        configureStackView()
        
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        addButtonsToStackView()
        setStackViewConstraints()
    }
    
    func addButtonsToStackView() {
        let numberOfButtons = 5
        
        for i in 1...numberOfButtons {
            let button = SurveyButton()
            button.setTitle("\(i)", for: .normal)
            stackView.addArrangedSubview(button)
        }
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Learning about stackview"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        
        setTitleLabelConstraints()
    }
    
    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
    }
    
}

