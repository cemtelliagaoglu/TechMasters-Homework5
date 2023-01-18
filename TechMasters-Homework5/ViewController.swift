//
//  ViewController.swift
//  TechMasters-Homework5
//
//  Created by admin on 17.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var container = ""
    var result: Double?
    var lastOperation = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "0" && container == ""{
            return
        }else{
            let numberString = sender.titleLabel!.text!
            container.append(numberString)
            resultLabel.text = container
        }
    }
    
    @IBAction func operatorPressed(_ sender: UIButton) {
        
        if let number = Double(resultLabel.text!){
            // if resultLabel.text can be converted to Double
            if result == nil{
                let operation = sender.titleLabel!.text!
                if operation == "+" || operation == "-"{
                    result = 0
                    operate(number, with: operation)
                    lastOperation = operation
                }else if operation == "x"{
                    result = 1
                    operate(number, with: operation)
                    lastOperation = operation
                }else if operation == "÷"{
                    result = number * number
                    operate(number, with: operation)
                    lastOperation = operation
                }
            }else{
                // result != nil
                if sender.titleLabel?.text != "="{
                    let operation = sender.titleLabel!.text!
                    operate(number, with: operation)
                    lastOperation = operation
                }else if sender.titleLabel?.text == "="{
                    calculateResult(number: number, with: lastOperation)
                }
            }
        }
    }
    
    @IBAction func modifierPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "." && !container.contains("."){
            container.append(".")
            resultLabel.text?.append(container)
            return
        }else if sender.titleLabel?.text == "AC"{
            clearAll()
            return
        }else if let n = Double(container){
            if sender.titleLabel?.text == "+/-"{
                let negative = n * (-1)
                container = String(negative)
            }else if sender.titleLabel?.text == "%"{
                let percent = n / 100
                container = String(percent)
            }
            resultLabel.text = container
        }
    }
    
    func operate(_ number: Double, with operation: String){
        
        if operation == "+"{
            result! += number
        }else if operation == "-"{
            result! -= number
        }else if operation == "x"{
            result! *= number
        }else if operation == "÷"{
            result! /= number
        }
        resultLabel.text = String(result!)
        container = ""
    }
    
    func calculateResult(number: Double, with lastOperator: String){
        
        guard result != nil else{ return }
        
        switch lastOperator{
        case "+":
            result! += number
        case "-":
            result! -= number
        case"x":
            result! *= number
        case "÷":
            result! /= number
        default:
            return
        }
        resultLabel.text = String(result!)
        container = ""
        result = nil
    }
    
    func clearAll(){
        result = nil
        resultLabel.text = "0"
        container = ""
    }
}

