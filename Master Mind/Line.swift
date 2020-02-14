//
//  Line.swift
//  Master Mind
//
//  Created by Guillaume on 13/02/2020.
//  Copyright © 2020 Guillaume. All rights reserved.
//

import UIKit

enum color: String, CaseIterable {
    case red
    case green
    case blue
    case yellow
    case white
    case black
}

struct Line {
    var element1: color
    var element2: color
    var element3: color
    var element4: color
}

extension UIColor {
    struct color {
        static let red = UIColor.red
    }
}

func setBtnColor(_ btn: UIButton) {

    switch btn.titleLabel?.text {
    case color.red.rawValue:
        btn.backgroundColor = UIColor.red
    case color.green.rawValue:
        btn.backgroundColor = UIColor.green
    case color.blue.rawValue:
        btn.backgroundColor = UIColor.blue
    case color.yellow.rawValue:
        btn.backgroundColor = UIColor.yellow
    case color.white.rawValue:
        btn.backgroundColor = UIColor.white
    case color.black.rawValue:
        btn.backgroundColor = UIColor.black
    default:
        btn.backgroundColor = UIColor.clear
    }
    btn.setTitleColor(UIColor.clear, for: .normal)
}
