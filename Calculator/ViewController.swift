//
//  ViewController.swift
//  Calculator
//
//  Created by Robert Lent on 7/3/17.
//  Copyright © 2017 Lent Coding. All rights reserved.
//
//  Updated on 2/25/18.

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
        changeOperation(newOperation: .addition)
    }
    
    @IBAction func pressedSubract(_ sender: Any) {
        changeOperation(newOperation: .subtraction)
    }
    
    @IBAction func pressedMultiply(_ sender: Any) {
        changeOperation(newOperation: .multiplication)
    }
    
    @IBAction func pressedDivide(_ sender: Any) {
        changeOperation(newOperation: .division)
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
    
    @IBAction func pressedClear(_ sender: Any) {
        labelText = "0";
        currentOperation = .not_set
        savedNum = 0
        lastButtonWasOperation = false
        output.text = "0"
    }
    
    @IBAction func pressedNumber(_ sender: UIButton) {
        if labelText.count == 10 && !lastButtonWasOperation {
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
    
    func updateText() {
        guard let labelDouble:Double = Double(labelText) else {
            return
        }
        
        if currentOperation == .not_set {
            savedNum = labelDouble
        }
        
        let formatter:NumberFormatter = NumberFormatter()
        
        //If the label is at its length limit, change the number to Scientific notation
        if labelText.count > 10 {
            formatter.numberStyle = .scientific
            formatter.maximumFractionDigits = 6
        } else {
            formatter.numberStyle = .decimal
        }
        
        let num:NSNumber = NSNumber(value: labelDouble)
        output.text = formatter.string(from: num)
    }
    
    func changeOperation(newOperation:operations) {
        if (savedNum == 0) {
            return
        }
        
        currentOperation = newOperation
        lastButtonWasOperation = true
    }

}

