//
//  SettingViewController.swift
//  TipHelper
//
//  Created by Yuanjie Xie on 3/2/17.
//  Copyright © 2017 Yuanjie Xie. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var TipPercentTextFiled1: UITextField!
    @IBOutlet weak var TipPercentTextFiled2: UITextField!
    @IBOutlet weak var TipPercentTextFiled3: UITextField!
    
    var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    var tipPercents: [Int] = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // put tip percents from MainViewController segment into three textfield
        tipPercents = defaults.array(forKey: "SavedTipPercentages")  as? [Int] ?? [Int]()
        TipPercentTextFiled1.text = String(tipPercents[0]);
        TipPercentTextFiled2.text = String(tipPercents[1]);
        TipPercentTextFiled3.text = String(tipPercents[2]);
    }


    @IBAction func UpdateButton(_ sender: Any) {
        // Setting bill amount
        tipPercents[0] = Int(TipPercentTextFiled1.text!)!
        tipPercents[1] = Int(TipPercentTextFiled2.text!)!
        tipPercents[2] = Int(TipPercentTextFiled3.text!)!
        // update the percentage
        defaults.set(tipPercents, forKey: "SavedTipPercentages")
        defaults.synchronize()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
