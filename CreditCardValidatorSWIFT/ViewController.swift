//
//  ViewController.swift
//  CreditCardValidatorSWIFT
//
//  Created by Mario Vizcaino on 23/10/16.
//  Copyright © 2016 Mario Vizcaino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardTypeLabel: UILabel!
    @IBOutlet weak var validateButton: UIButton!
    let ccvalidator = CreditCardValidator()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttonStyle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func validateCard() {
        let cardNumber = cardNumberTextField.text
        if (cardNumber?.isEmpty)!{
            callAlert(message: "FILL THE REQUIRED FIELD")
            setTextStyle(color: UIColor.red, borderWidth: 2)
            return
        }else{
            setTextStyle(color: UIColor.white, borderWidth: 0)
            if ccvalidator.validate(string: cardNumber!) {
                // Card number is valid
                setTextStyle(color: UIColor.green, borderWidth: 2)
                if let type = ccvalidator.type(from: cardNumber!) {
                    cardTypeLabel.text = type.name

                } else {
                    // I Can't detect type of credit card
                    cardTypeLabel.text = "UNKNOW TYPE"
                }
            } else {
                // Card number is invalid
                callAlert(message: "INVALID CARD NUMBER")
                setTextStyle(color: UIColor.red, borderWidth: 2)
            }
        }
    }

    
    func buttonStyle(){
        let button = validateButton
        button?.layer.borderWidth = 1
        button?.layer.borderColor = UIColor.white.cgColor
        button?.layer.cornerRadius = 15
    }
    
    func setTextStyle(color: UIColor, borderWidth: Double){
        let field = cardNumberTextField
        field?.layer.borderWidth = CGFloat(borderWidth)
        field?.layer.borderColor = color.cgColor
    }
    
    func callAlert(message: String){
        let alert = UIAlertController(title: "CREDIT CARD VALIDATOR", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

