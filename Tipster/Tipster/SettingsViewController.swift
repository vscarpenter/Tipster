//
//  SettingsViewController.swift
//  Tipster
//
//  Created by Vinny Carpenter on 12/26/14.
//  Copyright (c) 2014 Vinny Carpenter. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var tipControl: UISegmentedControl!
    let tips = [18, 20, 25]
    var userDefaults : NSUserDefaults?
    let defaultTip: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCorrectSegment()
        tipControl.layer.cornerRadius = 5.0
        tipControl.layer.masksToBounds = true
        tipControl.tintColor = UIColor(red: 92.0/255, green: 69.0/255, blue: 133.0/255, alpha: 0.8)
    }
    
    override func viewWillAppear(animated: Bool) {
      selectCorrectSegment()
        
    }
    
    func selectCorrectSegment() {
        userDefaults = NSUserDefaults.standardUserDefaults()
        let tipVal = userDefaults?.integerForKey("defaultTip")
        tipControl.selectedSegmentIndex = 0
        for (index,tmp) in enumerate(tips) {
            if(tipVal == tmp){
                tipControl.selectedSegmentIndex = index
            }
        }
        let currentTip = tips[tipControl.selectedSegmentIndex]
        self.tipLabel.text = "Default Tip is \(currentTip)%"
    }
    
    @IBAction func defaultTipChanged(sender: AnyObject) {
        let currentTip = tips[tipControl.selectedSegmentIndex]
        self.tipLabel.text = "Default Tip is \(currentTip)%"
        userDefaults?.setInteger(currentTip, forKey: "defaultTip")
        userDefaults?.synchronize()
    }
}
