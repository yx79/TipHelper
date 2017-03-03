//
//  ViewController.swift
//  TipHelper
//
//  Created by Aiden Xie on 2/28/17.
//  Copyright © 2017 Yuanjie Xie. All rights reserved.
//

import UIKit

struct defaultsKeys {
    static let key = "billAmountStringKey"
}

class ViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipSegment: UISegmentedControl!
    
    @IBOutlet weak var personNumber: UILabel!
    
    @IBOutlet weak var splitTipLabel: UILabel!
    @IBOutlet weak var splitTotalLabel: UILabel!
    
    // global var
    var currencyFormatter = NumberFormatter()
    var tip : Double = Double()
    var total : Double = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // use currency formatter to locale-specific currency and show currency thousands separators
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = NSLocale.current
        
        // Set default value to 0
        tipLabel.text = currencyFormatter.string(from: NSNumber(value:0))
        totalLabel.text = currencyFormatter.string(from: NSNumber(value:0))
        splitTipLabel.text = tipLabel.text
        splitTotalLabel.text = totalLabel.text
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        billTextField.becomeFirstResponder()
    }
    
    
    //Use UserDefaults to remember the bill amount across app restarts
    override func viewWillDisappear(_ animated: Bool) {
        // Setting bill amount
        let defaults = UserDefaults.standard
        defaults.setValue(billTextField.text, forKey: defaultsKeys.key)
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Getting the saved bill amount
        let defaults = UserDefaults.standard
        if let valueString = defaults.string(forKey: defaultsKeys.key) {
            billTextField.text = valueString
        }
    }

    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    @IBAction func updateCalculation(_ sender: AnyObject) {
        // textField to double number. ?? return 0 if nil
        let bill = Double(billTextField.text!) ?? 0
        let tipPercentage = [0.1, 0.15, 0.2]
        tip = bill * tipPercentage[tipSegment.selectedSegmentIndex]
        total = bill + tip
        
        tipLabel.text = currencyFormatter.string(from: NSNumber(value:tip))
        totalLabel.text = currencyFormatter.string(from: NSNumber(value:total))
        
        // split between 1 person after input/tip percentage change
        personNumber.text = "1"
        splitTipLabel.text = tipLabel.text
        splitTotalLabel.text = totalLabel.text
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
        let splitTip = splitCalculate(number: number, amount: tip)
        splitTipLabel.text = currencyFormatter.string(from: NSNumber(value:splitTip))
        
        // split total
        let splitTotal = splitCalculate(number: number, amount: total)
        splitTotalLabel.text = currencyFormatter.string(from: NSNumber(value: splitTotal))
    }
    
    // return divide calculation amount / number
    func splitCalculate(number: Int, amount: Double) -> Double{
        let split = amount / Double(number)
        return split
    }
    
    
    
}

