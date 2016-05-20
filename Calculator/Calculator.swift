//
//  Calculator.swift
//  Calculator
//
//  Created by Chris on 5/12/16.
//  Copyright © 2016 Prince Fungus. All rights reserved.
//

import Foundation

struct Calculator {
    typealias DoubleStack = [Double]
    typealias OperationStack = [Operation]
    
    static var numberStack = DoubleStack()
    static var operationStack = OperationStack()
    
    private static var containsTwoOperands: Bool {
        return numberStack.count > 1
    }
    
    private static var containsAnOperator: Bool {
        return operationStack.count > 0
    }
    
    private static var readyToCalculate: Bool {
        return containsTwoOperands && containsAnOperator
    }
    
    static var result: Double = 0
    static var delegate: CalculatorDelegate?
    
    static func pushToNumberStack(number: Double) {
        numberStack.append(number)
        print("number stack: \(Calculator.numberStack)")
        print("operation stack: \(Calculator.operationStack)")

        observeReadyToCalculate()
    }
    
    static func pushToOperationStack(operation: Operation) {
        operationStack.append(operation)
        print("number stack: \(Calculator.numberStack)")
        print("operation stack: \(Calculator.operationStack)")

        observeReadyToCalculate()
    }
    
    static func observeReadyToCalculate() {
        if readyToCalculate { calculate() }
    }
    
    static  func calculate() {
        let a = numberStack.removeLast()
        let b = numberStack.removeLast()
        let operation = operationStack.removeLast()
        
        result = performOperation(operation, on: a, and: b)
        numberStack.append(result)
      
        print("number stack: \(Calculator.numberStack)")
        print("operation stack: \(Calculator.operationStack)")

        delegate?.didCalculateResult(result)
    }
    
    static func performOperation(operation: Operation, on a: Double, and b: Double) -> Double {
        switch operation {
        case .Add:
            return a + b
        case .Subtract:
            return b - a
        case .Multiply:
            return a * b
        case .Divide:
            return b / a
        case .Equal:
            return readyToCalculate ? result: numberStack[0]
        case .Sin:
            return 0
        case .Cos:
            return 0
        }
    }
    
    static func reset() {
        numberStack.removeAll()
        operationStack.removeAll()
        result = 0
    }
}

enum Operation: String {
    case Add = "+"
    case Subtract = "-"
    case Multiply = "×"
    case Divide = "÷"
    case Equal = "="
    case Sin = "sin"
    case Cos = "cos"
}

protocol CalculatorDelegate {
    func didCalculateResult(result: Double)
}
