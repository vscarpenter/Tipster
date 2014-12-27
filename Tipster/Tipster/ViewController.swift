//
//  ViewController.swift
//  Tipster
//
//  Created by Vinny Carpenter on 12/26/14.
//  Copyright (c) 2014 Vinny Carpenter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var tipControl: UISegmentedControl!
    
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var tipLabel: UILabel!
    
    var userDefaults : NSUserDefaults?
    let tips = [ 18, 20, 25]
    var defaultTip : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tipLabel.text = "$ 0.00"
        self.totalLabel.text = "$ 0.00"
        
        amountTextField.delegate = self
        tipControl.layer.cornerRadius = 5.0
        tipControl.layer.masksToBounds = true
        tipControl.tintColor = UIColor(red: 92.0/255, green: 69.0/255, blue: 133.0/255, alpha: 0.8)
        tipControl.selectedSegmentIndex = 0
        
        userDefaults = NSUserDefaults.standardUserDefaults()
        
        defaultTip = userDefaults?.integerForKey("defaultTip")
        
        for (index,tmp) in enumerate(tips) {
            if(defaultTip == tmp){
                tipControl.selectedSegmentIndex = index
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        defaultTip = userDefaults?.integerForKey("defaultTip")
        
        for (index,tmp) in enumerate(tips) {
            if(defaultTip == tmp){
                tipControl.selectedSegmentIndex = index
            }
        }
        billAmtEntered(self)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        amountTextField.resignFirstResponder()
        return true;
    }
    
    @IBAction func billAmtEntered(sender: AnyObject) {
        calculateTipAndTotal()
    }
    
    @IBAction func tipControlChange(sender: AnyObject) {
        calculateTipAndTotal()
    }
    
    func calculateTipAndTotal() {
        let bill = (amountTextField.text as NSString).doubleValue
        let total = bill + bill * (Double(tips[tipControl.selectedSegmentIndex])/100)
        totalLabel.text = NSString(format: "$%.2f", total)
        tipLabel.text = NSString(format: "$%.2f", bill * Double(tips[tipControl.selectedSegmentIndex])/100)
        
    }
}

