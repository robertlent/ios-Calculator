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
    var savedNum:Int = 0
    var lastButtonWasOperation:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        guard let labelInt:Int = Int(labelText) else {
            return
        }
        
        if currentOperation == .not_set || lastButtonWasOperation {
            return
        }
        
        switch currentOperation {
        case .addition:
            savedNum += labelInt
        case .subtraction:
            savedNum -= labelInt
        case .multiplication:
            savedNum *= labelInt
        case .division:
            savedNum /= labelInt
        default:
            return
        }
        
        currentOperation = .not_set
        labelText = "\(savedNum)"
        updateText()
        lastButtonWasOperation = true
        
        if currentOperation == .addition {
            savedNum += labelInt
        } else if currentOperation == .subtraction {
            savedNum -= labelInt
        }
    }
    
    @IBAction func pressedNumber(_ sender: UIButton) {
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
        guard let labelInt:Int = Int(labelText) else {
            return
        }
        
        if currentOperation == .not_set {
            savedNum = labelInt
        }
        
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: labelInt)
        
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

