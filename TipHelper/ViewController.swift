//
//  ViewController.swift
//  TipHelper
//
//  Created by Aiden Xie on 2/28/17.
//  Copyright © 2017 Yuanjie Xie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipSegment: UISegmentedControl!
    
    @IBOutlet weak var personNumber: UILabel!
    
    @IBOutlet weak var splitTipLabel: UILabel!
    @IBOutlet weak var splitTotalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    @IBAction func updateCalculation(_ sender: AnyObject) {
        
        // textField to double number. ?? return 0 if nil
        let bill = Double(billTextField.text!) ?? 0
        let tipPercentage = [0.1, 0.15, 0.2]
        let tip = bill * tipPercentage[tipSegment.selectedSegmentIndex]
        let total = bill + tip
        tipLabel.text = String(format:"$%0.2f", tip)
        totalLabel.text = String(format:"$%0.2f", total)
        
        // split between 1 person after input/tip percentage change
        personNumber.text = "1"
        splitTipLabel.text = String(format:"$%0.2f", tip)
        splitTotalLabel.text = String(format:"$%0.2f", total)
    }
    

    @IBAction func addButtonTap(_ sender: UIButton) {
        var number = Int(personNumber.text!) ?? 1
        number += 1
        personNumber.text = "\(number)"
        updateSplit(number: number)
    }
    
    
    @IBAction func minusButtonTap(_ sender: UIButton) {
        var number = Int(personNumber.text!) ?? 1
        number -= 1
        if (number < 1) {
            number = 1
        }
        personNumber.text = "\(number)"
        updateSplit(number: number)
    }
    
    // update split of tip and total with number
    func updateSplit(number: Int) {
        // split tip
        let tipStr = tipLabel.text!
        let tipIndex = tipStr.index(tipStr.startIndex, offsetBy:1)
        let tipString = tipStr.substring(from: tipIndex)
        let tip = Double(tipString)
        splitTipLabel.text = String(format:"$%0.2f", splitCalculate(number: number, amount: tip!))
        
        
        // split total
        let totalStr = totalLabel.text!
        let totalIndex = totalStr.index(totalStr.startIndex, offsetBy:1)
        let totalString = totalStr.substring(from: totalIndex)
        //print(totalString)
        let total = Double(totalString)
        splitTotalLabel.text = String(format:"$%0.2f", splitCalculate(number: number, amount: total!))

    }
    
    // return divide calculation amount / number
    func splitCalculate(number: Int, amount: Double) -> Double{
        let split = amount / Double(number)
        return split
    }
    
    
    
}

