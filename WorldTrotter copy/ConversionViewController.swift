//
//  ConversionViewController.swift
//  WorldTrotter2
//
//  Created by Spencer Goff on 5/24/17.
//  Copyright © 2017 Spencer Goff. All rights reserved.
//

import UIKit
import Foundation

class ConversionViewController: UIViewController, UITextFieldDelegate { //UITextFieldDelegate enables instance to disallow changes to test field
    
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() { //executes the first time the app loads
        super.viewDidLoad()
        print("ConversionViewController has loaded its view.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let currentHour = Calendar.current.component(.hour, from: Date())
        if(currentHour > 19 || currentHour < 7) {
            self.view.backgroundColor = UIColor.blue
        }
        else {
            self.view.backgroundColor = UIColor.yellow
        }
        
    }
    
    var fahrenheitValue: Double? { //optional since it can be nil
        didSet {
            updateCelciusValue()
        }
    }
    
    var celciusValue: Double? {
        if let value = fahrenheitValue { //if value is nil, will jump to else
            return (value - 32)*(5/9)
        }
        else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func updateCelciusValue(){ //gets called whenever text field changes
        if let value = celciusValue {
            celciusLabel.text = "\(value)"
        }
        else{
            celciusLabel.text = "???"
        }
    }

    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField){ //gets called whenever text field changes
       
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = number.doubleValue
        }
        else{
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) { //gets called whenever the user taps outside of the text field
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "." // = former unless the former is nil, then it = the latter
        
        let replacementTextHasLetters = string.rangeOfCharacter(from: NSCharacterSet.letters)
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil { //if both the current and replacement text have a decimal, reject the replacement
            return false //reject decimal input (currently a decimal in field)
        }
        else if replacementTextHasLetters != nil {
            return false //reject letter input
        }
        else {
            return true //accept decimal input (not currently a decimal in field)
        }
    }
    
}































