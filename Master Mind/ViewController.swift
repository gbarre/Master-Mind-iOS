//
//  ViewController.swift
//  Master Mind
//
//  Created by Guillaume on 13/02/2020.
//  Copyright © 2020 Guillaume. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetLine: StackLine!
    @IBOutlet weak var Attempt1: StackLine!
    @IBOutlet weak var Attempt2: StackLine!
    @IBOutlet weak var Attempt3: StackLine!
    @IBOutlet weak var Attempt4: StackLine!
    @IBOutlet weak var Attempt5: StackLine!
    @IBOutlet weak var Attempt6: StackLine!
    @IBOutlet weak var Attempt7: StackLine!
    @IBOutlet weak var Attempt8: StackLine!
    @IBOutlet weak var Attempt9: StackLine!
    @IBOutlet weak var Attempt10: StackLine!
    
    var attemptId: Int = 0
    var currentAttemptStack: StackLine = StackLine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
    func startGame() {
        currentAttemptStack = StackLine()
        initGame()
        initLine(line: Attempt1)
    }
    
    func initGame() {
        let target: Line = Line(
            element1: color.allCases.randomElement()!,
            element2: color.allCases.randomElement()!,
            element3: color.allCases.randomElement()!,
            element4: color.allCases.randomElement()!
        )
        
        targetLine.C1.setTitle(target.element1.rawValue, for: .normal)
        targetLine.C2.setTitle(target.element2.rawValue, for: .normal)
        targetLine.C3.setTitle(target.element3.rawValue, for: .normal)
        targetLine.C4.setTitle(target.element4.rawValue, for: .normal)
        
        setBtnColor(targetLine.C1)
        setBtnColor(targetLine.C2)
        setBtnColor(targetLine.C3)
        setBtnColor(targetLine.C4)
        
        hideTarget(true)
        
        attemptId = 0
        let remainAttempts = 10 - attemptId
        targetLine.infos.text = remainingTries + "\(remainAttempts)"
        
        let attempts: [StackLine] = [
            Attempt1,
            Attempt2,
            Attempt3,
            Attempt4,
            Attempt5,
            Attempt6,
            Attempt7,
            Attempt8,
            Attempt9,
            Attempt10
        ]
        
        for attempt in attempts {
            attempt.C1.setTitle(defaultButtonText, for: .normal)
            attempt.C2.setTitle(defaultButtonText, for: .normal)
            attempt.C3.setTitle(defaultButtonText, for: .normal)
            attempt.C4.setTitle(defaultButtonText, for: .normal)
            
            attempt.C1.setTitleColor(.systemBlue, for: .normal)
            attempt.C2.setTitleColor(.systemBlue, for: .normal)
            attempt.C3.setTitleColor(.systemBlue, for: .normal)
            attempt.C4.setTitleColor(.systemBlue, for: .normal)
            
            attempt.C1.backgroundColor = UIColor.clear
            attempt.C2.backgroundColor = UIColor.clear
            attempt.C3.backgroundColor = UIColor.clear
            attempt.C4.backgroundColor = UIColor.clear
            
            attempt.Check.isHidden = false
            attempt.Check.isEnabled = false
            attempt.infos.isHidden = true
        }
    }
    
    func initLine(line: StackLine) {
        self.attemptId += 1
        self.currentAttemptStack = line

        line.C1.isEnabled = true
        line.C2.isEnabled = true
        line.C3.isEnabled = true
        line.C4.isEnabled = true
        line.Check.isEnabled = true
        line.Check.isHidden = false
        line.infos.isHidden = true
        
        line.C1.addTarget(self, action: #selector(openPop), for: .touchUpInside)
        line.C2.addTarget(self, action: #selector(openPop), for: .touchUpInside)
        line.C3.addTarget(self, action: #selector(openPop), for: .touchUpInside)
        line.C4.addTarget(self, action: #selector(openPop), for: .touchUpInside)
        line.Check.addTarget(self, action: #selector(checkLine), for: .touchUpInside)
        
    }
    
    func blockLine(line: StackLine) {
        line.C1.isEnabled = false
        line.C2.isEnabled = false
        line.C3.isEnabled = false
        line.C4.isEnabled = false
        line.Check.isEnabled = false
        line.Check.isHidden = true
        line.infos.isHidden = false
    }
    
    @objc func openPop(sender: UIButton!) {
        performSegue(withIdentifier: popSegue, sender: sender)
    }
    
    @objc func checkLine(sender: UIButton!) {
        var testing: [String] = [
            currentAttemptStack.C1.titleLabel!.text!,
            currentAttemptStack.C2.titleLabel!.text!,
            currentAttemptStack.C3.titleLabel!.text!,
            currentAttemptStack.C4.titleLabel!.text!
        ]
        
        for i in 0...testing.count-1 {
            if testing[i].count < 3 {
                let controller = UIAlertController(title: warning, message: noEmpty, preferredStyle: UIAlertController.Style.alert)
                controller.addAction(UIAlertAction(title: ok, style: UIAlertAction.Style.destructive, handler: nil))
                self.present(controller, animated: true, completion: nil)
                return
            }
        }
        
        let attempts = 10 - attemptId
        targetLine.infos.text = remainingTries + "\(attempts)"
        
        var good: Int = 0
        var missPlaced: Int = 0
        
        var target: [String] = [
            targetLine.C1.titleLabel!.text!,
            targetLine.C2.titleLabel!.text!,
            targetLine.C3.titleLabel!.text!,
            targetLine.C4.titleLabel!.text!
            ]
        
        // Look for good colors
        for i in 0...target.count-1 {
            if testing[i] == target[i] {
                good += 1
                target[i] = x
                testing[i] = y
            }
        }
        
        // Look for missPlaced
        for i in 0...target.count-1 {
            for j in 0...target.count-1 {
                if testing[i] == target[j] {
                    missPlaced += 1
                    target[j] = x
                    testing[i] = y
                }
            }
        }
        
        currentAttemptStack.infos.text = bp + "\(good)" + mp + "\(missPlaced)"
        
        if good < 4 {
            switch self.attemptId {
            case 1:
                blockLine(line: Attempt1)
                initLine(line: Attempt2)
            case 2:
                blockLine(line: Attempt2)
                initLine(line: Attempt3)
            case 3:
                blockLine(line: Attempt3)
                initLine(line: Attempt4)
            case 4:
                blockLine(line: Attempt4)
                initLine(line: Attempt5)
            case 5:
                blockLine(line: Attempt5)
                initLine(line: Attempt6)
            case 6:
                blockLine(line: Attempt6)
                initLine(line: Attempt7)
            case 7:
                blockLine(line: Attempt7)
                initLine(line: Attempt8)
            case 8:
                blockLine(line: Attempt8)
                initLine(line: Attempt9)
            case 9:
                blockLine(line: Attempt9)
                initLine(line: Attempt10)
            default:
                blockLine(line: Attempt10)
                let controller = UIAlertController(title: gameOver, message: sorry, preferredStyle: UIAlertController.Style.alert)
                controller.addAction(UIAlertAction(title: ok, style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.startGame()}))
                self.present(controller, animated: true, completion: nil)
                hideTarget(false)
            }
        } else {
            let controller = UIAlertController(title: congrats, message: win, preferredStyle: UIAlertController.Style.alert)
            controller.addAction(UIAlertAction(title: ok, style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.startGame()}))
            self.present(controller, animated: true, completion: nil)
            hideTarget(false)
        }
    }
    
    func hideTarget(_ action: Bool) {
        targetLine.C1.isHidden = action
        targetLine.C2.isHidden = action
        targetLine.C3.isHidden = action
        targetLine.C4.isHidden = action
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == popSegue {
            let vc: PopView = segue.destination as! PopView
            vc.parrentButton = sender as! UIButton
        }
    }
}
