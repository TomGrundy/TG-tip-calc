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
    
    var pickerPercentage: [String] = [String]()
    var pickerNumberOfTippers: [String] = [String]()
    let sizeOfPickerItems: Int = 101
    var billTotal = 0.0
    var activeTextField = 0
    var percentage = "0%"
    var numberOfTippers = "0"
    var basePicker:UIPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        
        billTotalInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            case 2:
                numberOfTippers = pickerNumberOfTippers[row]
                calculateValues()
            default:
                percentage = ""
                numberOfTippers = ""
                calculateValues()
        }
    }

    @IBAction func closePickerView(_ sender: Any) {
        percentagePickerView.isHidden = true
        numberOfTippersPickerView.isHidden = true
        ClosePickerUIView.isHidden = true
    }
    
    
    func textFieldDidChange(_ textField: UITextField) {
        billTotal = Double(billTotalInput.text ?? "0.0") ?? 0.0
        calculateValues()
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
        totalLabel.text = "$\(round(total * 100)/100)"
        totalTipLabel.text = "$\(round(totalTip * 100)/100)"
        individualTipLabel.text = "$\(round(individualTip * 100)/100)"
        individualTotalLabel.text = "$\(round(individualTotal * 100)/100)"
    }
}


