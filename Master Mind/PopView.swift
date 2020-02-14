//
//  PopView.swift
//  Master Mind
//
//  Created by Guillaume on 13/02/2020.
//  Copyright © 2020 Guillaume. All rights reserved.
//

import UIKit

class PopView: UIViewController {
    
    var parrentButton: UIButton = UIButton()
    
    @IBOutlet weak var Stack1: UIStackView!
    @IBOutlet weak var Stack2: UIStackView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let nbColors:Int = color.allCases.count
        let mid: Int = nbColors / 2
        var i = 0
        
        for col in color.allCases {
            i += 1
            let btn: UIButton = UIButton()
            btn.setTitle(col.rawValue, for: .normal)
            btn.setTitleColor(.blue, for: .normal)
            setBtnColor(btn)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.addTarget(self, action: #selector(PopView.setColor(sender:)), for: .touchUpInside)
            if i <= mid {
                self.Stack1.addArrangedSubview(btn)
            } else {
                self.Stack2.addArrangedSubview(btn)
            }
        }
    }
    
    @objc func setColor(sender: UIButton) {
        self.parrentButton.setTitle(sender.titleLabel?.text!, for: .normal)
        self.parrentButton.setTitleColor(UIColor.clear, for: .normal)

        switch sender.titleLabel?.text {
        case color.red.rawValue:
            self.parrentButton.backgroundColor = UIColor.red
        case color.green.rawValue:
            self.parrentButton.backgroundColor = UIColor.green
        case color.blue.rawValue:
            self.parrentButton.backgroundColor = UIColor.blue
        case color.yellow.rawValue:
            self.parrentButton.backgroundColor = UIColor.yellow
        case color.white.rawValue:
            self.parrentButton.backgroundColor = UIColor.white
        case color.black.rawValue:
            self.parrentButton.backgroundColor = UIColor.black
        default:
            self.parrentButton.backgroundColor = UIColor.clear
        }
        
        self.dismiss(animated: true, completion: nil)
    }

}
