//
//  CalculatorViewController.swift
//  CalculatorApp
//
//  Created by 黃昌齊 on 2021/8/4.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var dialFirstDigit = true
    var decimals = false
    var result = 0
    var equation = ""
    
    @IBOutlet var numberButton: [UIButton]!
    @IBOutlet var operatorButton: [UIButton]!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberLabel.text = "0"
        numberLabel.adjustsFontSizeToFitWidth = true
        for num in 0...9 {
            numberButton[num].layer.cornerRadius = numberButton[num].bounds.height * 1/2
        }
        for num in 0...7 {
            operatorButton[num].layer.cornerRadius = operatorButton[num].bounds.height * 1/2
        }
    }
    
    @IBAction func pressNumber(_ sender: UIButton) {
        let inputNum = sender.tag
        //判斷是否輸入第一位數
        if dialFirstDigit == true {
            numberLabel.text = String(inputNum)
            dialFirstDigit = false
        } else {
            //判斷第一位數是否為0
            if numberLabel.text != "0" {
                numberLabel.text! += String(inputNum)
            } else {
                numberLabel.text = ""
                numberLabel.text! += String(inputNum)
            }
        }
        print(numberLabel.text)
    }
    
    @IBAction func printDot(_ sender: UIButton) {
        numberLabel.text! += "."
        dialFirstDigit = false
        decimals = true
    }
    
    
    @IBAction func calculateNums(_ sender: UIButton) {
        guard let inputNum = numberLabel.text else { return }
        var doubleNum: String
        if decimals == false {
            doubleNum = ".0"
        } else {
            doubleNum = ""
        }
        switch sender.tag {
        case 0: //歸零
            result = 0
            numberLabel.text = "0"
            decimals = false
            equation = ""
        case 1: //階乘
            result = 1
            if decimals == true {
                showAlert()
            } else {
                if let factorialNum = Int(numberLabel.text!) {
                    if factorialNum != 0 {
                        for num in 1...factorialNum {
                            result *= num
                        }
                    }
                }
                numberLabel.text = String(result)
            }
        case 2: //除
            equation += inputNum + doubleNum + "/"
        case 3: //乘
            equation += inputNum + doubleNum + "*"
        case 4: //減
            equation += inputNum + doubleNum + "-"
        case 5: //加
            equation += inputNum + doubleNum + "+"
        default:
            break
        }
        dialFirstDigit = true
        print(equation)
    }
    
    @IBAction func equal(_ sender: Any) {
        if let inputNum = numberLabel.text {
            equation += inputNum
            print(equation)
        }
        let expression = NSExpression(format: equation)
        if let calculateResult = expression.expressionValue(with: nil, context: nil) as? Double {
            print(calculateResult)
            if calculateResult.truncatingRemainder(dividingBy: 1) == 0 {
                numberLabel.text = String(calculateResult.floor(toInteger: 1))
            } else {
                numberLabel.text = String(calculateResult.rounding(toDecimal: 6))
            }
        }
        dialFirstDigit = true
        //decimals = false
        equation = ""
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Error!", message: "Factorial can only be integers.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}
