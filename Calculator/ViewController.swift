//
//  ViewController.swift
//  Calculator
//
//  Created by Robert on 7/3/17.
//  Copyright © 2017 Lent Coding. All rights reserved.
//

import UIKit

enum operations {
    case not_set
    case addition
    case subtraction
    case multiplication
    case division
}

class ViewController: UIViewController {
    @IBOutlet weak var output: UILabel!
    
    var labelText:String = "0"
    var currentOperation:operations = .not_set
    var savedNum:Double = 0
    var lastButtonWasOperation:Bool = false

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBAction func pressedPlus(_ sender: Any) {
        changeOperation(.addition)
    }

    @IBAction func pressedSubract(_ sender: Any) {
        changeOperation(.subtraction)
    }
    
    @IBAction func pressedMultiply(_ sender: Any) {
        changeOperation(.multiplication)
    }
    
    @IBAction func pressedDivide(_ sender: Any) {
        changeOperation(.division)
    }
    
    @IBAction func pressedEquals(_ sender: Any) {
        guard let labelDouble:Double = Double(labelText) else {
            return
        }
        
        if currentOperation == .not_set || lastButtonWasOperation {
            return
        }
        
        switch currentOperation {
        case .addition:
            savedNum += labelDouble
        case .subtraction:
            savedNum -= labelDouble
        case .multiplication:
            savedNum *= labelDouble
        case .division:
            savedNum /= labelDouble
        default:
            return
        }
        
        currentOperation = .not_set
        labelText = "\(savedNum)"
        updateText()
        lastButtonWasOperation = true
    }
    
    @IBAction func pressedNumber(_ sender: UIButton) {
        if labelText.characters.count == 10 && !lastButtonWasOperation {
            return
        }
        
        let buttonValue:String? = sender.titleLabel?.text
        
        if lastButtonWasOperation {
            lastButtonWasOperation = false
            labelText = "0"
        }
        
        labelText = labelText.appending(buttonValue!)
        
        updateText()
    }
    
    @IBAction func pressedClear(_ sender: Any) {
        labelText = "0"
        currentOperation = .not_set
        savedNum = 0
        lastButtonWasOperation = false
        output.text = "0"
    }
    
    func updateText() {
        guard let labelDouble:Double = Double(labelText) else {
            return
        }
        
        if currentOperation == .not_set {
            savedNum = labelDouble
        }
        
        let formatter:NumberFormatter = NumberFormatter()
        
        //If the label is at its length limit, change the number to Scientific notation
        if labelText.characters.count > 10 {
            formatter.numberStyle = .scientific
            formatter.maximumFractionDigits = 6
        } else {
            formatter.numberStyle = .decimal
        }
        
        let num:NSNumber = NSNumber(value: labelDouble)
        output.text = formatter.string(from: num)
    }
    
    func changeOperation(_ newOperation:operations) {
        if savedNum == 0 {
            return
        }
        
        currentOperation = newOperation
        lastButtonWasOperation = true
    }
    
}

