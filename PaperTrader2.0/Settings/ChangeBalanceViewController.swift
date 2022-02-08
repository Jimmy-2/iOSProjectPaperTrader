//
//  SettingsViewController.swift
//  PaperTrader2.0
//
//  Created by Jimmy  on 12/9/21.
//

import UIKit

class ChangeBalanceViewController: UITableViewController, UITextFieldDelegate  {
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var editBalanceTextField: UITextField!
    var availableBalance: String?
    var availableBalanceDoub: Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        editBalanceTextField.delegate = self
        
        let defaults = UserDefaults.standard
        availableBalance = defaults.string(forKey: "balanceAmount")
        
        availableBalanceDoub = Double(availableBalance!)!
        
        editBalanceTextField.text = String(format: "%.0f", availableBalanceDoub)
    }
    
    
    @IBAction func doneEditting () {
        if editBalanceTextField.text! == "" {
            showToastMessage(message: "No changes made")

            
        }else {
            let defaults = UserDefaults.standard
            defaults.set(editBalanceTextField.text, forKey: "balanceAmount")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
            
            
           
            var newAmount: String? = editBalanceTextField.text
            var newAmountDoub: Double = Double(newAmount!)!
            var newChangeAmount: Double = defaults.double(forKey: "changeAmount")
            
            if (newAmountDoub > availableBalanceDoub) {
                newChangeAmount += (newAmountDoub - availableBalanceDoub)
            }else if (newAmountDoub < availableBalanceDoub) {
                newChangeAmount -= (availableBalanceDoub - newAmountDoub)
            }
            
            defaults.set(newChangeAmount , forKey: "changeAmount")
            
            showToastMessage2(message: "You have successfully changed your balance to " + editBalanceTextField.text!)
        }
       
        view.endEditing(true)
    }
    
    //MARK: - Text Field Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedChars = "1234567890"
        let allowedCharSet = CharacterSet(charactersIn: allowedChars)
        let typedCharSet = CharacterSet(charactersIn: string)
        
        return allowedCharSet.isSuperset(of: typedCharSet)
     
    }
}
