//
//  ViewController.swift
//  tips
//
//  Created by Mari Gordon on 12/12/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        let timeNow = NSDate()
        let timeLast = NSUserDefaults.standardUserDefaults().objectForKey("savedTime") as? NSDate
        
        if (timeLast != nil && timeNow.timeIntervalSinceDate(timeLast!) < 600) {
            billField.text = NSUserDefaults.standardUserDefaults().stringForKey("savedBill")
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        billField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        
        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "savedTime")
        NSUserDefaults.standardUserDefaults().setObject(billField.text, forKey: "savedBill")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)!
        totalLabel.text = currencyFormatter.stringFromNumber(total)!
    
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

