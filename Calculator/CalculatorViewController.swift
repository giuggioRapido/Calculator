//
//  ViewController.swift
//  Calculator
//
//  Created by Chris on 5/12/16.
//  Copyright © 2016 Prince Fungus. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, CalculatorDelegate {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var keyPad: UIView!
    
    var displayedNumber: Double {
        guard let number = Double(display.text!) else {
            print("Error converting display content to Double")
            return 010101
        }
        return number
    }
    var userIsTyping = false
    var activeOperation: Operation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display.text = "0"
        Calculator.delegate = self
    }
    
    @IBAction func enterDigit(sender: UIButton) {
        let π = String(M_PI)
        let digitString = (sender.currentTitle == "π" ? π : sender.currentTitle)!
        
        if let operation = activeOperation {
            Calculator.pushToOperationStack(operation)
            activeOperation = nil
        }
        
        if userIsTyping {
            /// Append display text.
            display.text = display.text! + digitString
        } else {
            /// Replace display text.
            display.text = digitString
            userIsTyping = true
        }
        
    }
    
    @IBAction func enterDecimalPoint(sender: UIButton) {
        let displayContainsDecimal = display.text?.containsString(".")
        if !displayContainsDecimal! {
            display.text = display.text! + "."
        }
    }
    
    @IBAction func enterOperater(sender: UIButton) {
        if userIsTyping {
            Calculator.pushToNumberStack(displayedNumber)
            userIsTyping = false
        }
        activeOperation = Operation(rawValue: sender.currentTitle!)
    }
    
    @IBAction func clearDisplay() {
        display.text = "0"
        userIsTyping = false
        Calculator.reset()
    }
    
    func didCalculateResult(result: Double) {
        display.text = String(format: "%g", result)
    }
}

