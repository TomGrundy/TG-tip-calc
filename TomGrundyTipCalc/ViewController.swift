//
//  ViewController.swift
//  TomGrundyTipCalc
//
//  Created by Tom Grundy on 7/23/17.
//  Copyright © 2017 Tom Grundy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var billTotalInput: UITextField!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalTipLabel: UILabel!
    @IBOutlet weak var individualTotalLabel: UILabel!
    @IBOutlet weak var individualTipLabel: UILabel!
    
    @IBOutlet weak var tipPercentageButton: UIButton!
    @IBOutlet weak var numberOfTippersButton: UIButton!
    @IBOutlet weak var closePickerButton: UIButton!
    
    @IBOutlet weak var percentagePickerView: UIPickerView!
    @IBOutlet weak var numberOfTippersPickerView: UIPickerView!
    
    @IBOutlet weak var ClosePickerUIView: UIView!
    @IBOutlet weak var totalsView: UIView!
    
    var pickerPercentage: [String] = [String]()
    var pickerNumberOfTippers: [String] = [String]()
    let sizeOfPickerItems: Int = 101
    var billTotal = 0.0
    var activeTextField = 0
    var percentage = "15%"
    var numberOfTippers = "1"
    var basePicker:UIPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let defaults = UserDefaults.standard
        percentage = defaults.string(forKey: "default_percentage") ?? "15%"
        
        var index = 0;
        
        while index < sizeOfPickerItems {
            pickerPercentage.append("\(index)%")
            pickerNumberOfTippers.append("\(index)")
            index = index + 1
        }
        
        percentagePickerView.dataSource = self
        percentagePickerView.delegate = self
        percentagePickerView.isHidden = true
        numberOfTippersPickerView.dataSource = self
        numberOfTippersPickerView.delegate = self
        numberOfTippersPickerView.isHidden = true
        
        ClosePickerUIView.isHidden = true
        
        billTotalInput.delegate = self as? UITextFieldDelegate
        billTotalInput.keyboardType = UIKeyboardType.decimalPad
        billTotalInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addDoneButton()
        
        let timeBillTotalSaved = defaults.double(forKey: "bill_total_time_saved")
        let tenMinutes: Double = 60*10.0
        if (NSDate().timeIntervalSince1970 <= timeBillTotalSaved + tenMinutes) {
            let savedBillTotal: Double = defaults.double(forKey: "bill_total")
            if (savedBillTotal != 0) {
                billTotal = savedBillTotal
                billTotalInput.text = "\(billTotal)"
                calculateValues()
            }
        }
        
        calculateValues()
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.billTotalInput.becomeFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = UserDefaults.standard
        let defaultPercentage = defaults.string(forKey: "default_percentage") ?? "not_set"
        
        if (defaultPercentage != "not_set") {
            percentage = defaultPercentage
            calculateValues()
            animateTotalsViewChange()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch activeTextField {
            case 1:
                return pickerPercentage.count
            case 2:
                return pickerNumberOfTippers.count
            default:
                return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch activeTextField {
            case 1:
                return pickerPercentage[row]
            case 2:
                return pickerNumberOfTippers[row]
            default:
                return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch activeTextField {
            case 1:
                percentage = pickerPercentage[row]
                calculateValues()
                animateTotalsViewChange()
            case 2:
                numberOfTippers = pickerNumberOfTippers[row]
                calculateValues()
                animateTotalsViewChange()
            default:
                percentage = ""
                numberOfTippers = ""
                calculateValues()
                animateTotalsViewChange()
        }
    }

    @IBAction func closePickerView(_ sender: Any) {
        percentagePickerView.isHidden = true
        numberOfTippersPickerView.isHidden = true
        ClosePickerUIView.isHidden = true
    }
    
    
    func textFieldDidChange(_ textField: UITextField) {
        billTotal = Double(billTotalInput.text ?? "0.0") ?? 0.0
        let defaults = UserDefaults.standard
        defaults.set(billTotal, forKey: "bill_total")
        defaults.set(NSDate().timeIntervalSince1970, forKey: "bill_total_time_saved")
//        billTotalInput.text = "\(billTotal)"
        calculateValues()
        animateTotalsViewChange()
    }
    
    @IBAction func tipPercentagePressed(_ sender: Any) {
        activeTextField = 1
        percentagePickerView.isHidden = false
        ClosePickerUIView.isHidden = false
        percentagePickerView.reloadAllComponents()
    }
    
    
    @IBAction func numberOfTippersPressed(_ sender: Any) {
        activeTextField = 2
        numberOfTippersPickerView.isHidden = false
        ClosePickerUIView.isHidden = false
        numberOfTippersPickerView.reloadAllComponents()
    }
    
    func calculateValues() {
        let defaults = UserDefaults.standard
        let defaultCurrency = defaults.string(forKey: "default_currency") ?? "$"
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.locale = defaultCurrency == "€" ? Locale(identifier: "fr_FR") : defaultCurrency == "£" ? Locale(identifier: "en_GB") : Locale(identifier: "en_US")
        
        let noPercentageSymbolIndex = percentage.index(percentage.endIndex, offsetBy: -1)
        let percentageRange = percentage.startIndex ..< noPercentageSymbolIndex
        let castablePercentage = percentage[percentageRange]
        let percentageDouble = Double(castablePercentage) ?? 0.0
        let tip: Double = percentageDouble * 0.01
        let totalTipPercentage: Double = tip + 1.0
        let total = billTotal * totalTipPercentage
        let totalTip = billTotal * tip
        let individualTotal: Double = total / Double(numberOfTippers)!
        let individualTip: Double = totalTip / Double(numberOfTippers)!
        
        tipPercentageButton.setTitle("Tip Percentage: \(percentage)", for: .normal)
        numberOfTippersButton.setTitle("Number of Tippers: \(numberOfTippers)", for: .normal)
        totalLabel.text = "\(numberFormatter.string(from: NSNumber(value: total))!)"
        totalTipLabel.text = "\(numberFormatter.string(from: NSNumber(value: totalTip))!)"
        individualTipLabel.text = "\(numberFormatter.string(from: NSNumber(value: individualTip))!)"
        individualTotalLabel.text = "\(numberFormatter.string(from: NSNumber(value: individualTotal))!)"
    }
    
    func animateTotalsViewChange() {
        let firstAlphaValue: CGFloat = totalsView.alpha == 0.0 ? 1.0 : 0.0
        let secondAlphaValue: CGFloat = totalsView.alpha == 0.0 ? 0.0 : 1.0
        UIView.animate(withDuration: 0.25, animations: {
            self.totalsView.alpha = firstAlphaValue
        })
        UIView.animate(withDuration: 0.25, delay: 0.25, animations: {
            self.totalsView.alpha = secondAlphaValue
        })
    }
    
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        billTotalInput.inputAccessoryView = keyboardToolbar
    }
}


