//
//  SurveyButton.swift
//  Project06c
//
//  Created by Karen Oliveira on 15/08/22.
//

import UIKit

class SurveyButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .red
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 24)
        layer.cornerRadius = 8
    }

}
