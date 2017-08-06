//
//  SettingsViewController.swift
//  TomGrundyTipCalc
//
//  Created by Tom Grundy on 8/5/17.
//  Copyright © 2017 Tom Grundy. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var defaultTipSegmentedControl: UISegmentedControl!
    @IBOutlet weak var defaultCurrencySegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDefaults()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadDefaults()
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onDefaultChosen(_ sender: UISegmentedControl) {
        
        let defaults = UserDefaults.standard
        
        switch sender.selectedSegmentIndex {
            case 0:
                defaults.set("15%", forKey: "default_percentage")
            case 1:
                defaults.set("18%", forKey: "default_percentage")
            case 2:
                defaults.set("20%", forKey: "default_percentage")
            default:
                break;
        }
        defaults.synchronize()
    }
    
    @IBAction func onDefaultCurrencyChosen(_ sender: UISegmentedControl) {
        let defaults = UserDefaults.standard
        
        switch sender.selectedSegmentIndex {
            case 0:
                defaults.set("$", forKey: "default_currency")
            case 1:
                defaults.set("£", forKey: "default_currency")
            case 2:
                defaults.set("€", forKey: "default_currency")
            default:
                break;
        }
        defaults.synchronize()
    }
    
    
    func loadDefaults() {
        let defaults = UserDefaults.standard
        let percentage = defaults.string(forKey: "default_percentage") ?? "15%"
        let currency = defaults.string(forKey: "default_currency") ?? "$"
        
        switch percentage {
            case "15%":
                defaultTipSegmentedControl.selectedSegmentIndex = 0
            case "18%":
                defaultTipSegmentedControl.selectedSegmentIndex = 1
            case "20%":
                defaultTipSegmentedControl.selectedSegmentIndex = 2
            default:
                defaultTipSegmentedControl.selectedSegmentIndex = -1
        }
        
        switch currency {
            case "$":
                defaultCurrencySegmentedControl.selectedSegmentIndex = 0
            case "£":
                defaultCurrencySegmentedControl.selectedSegmentIndex = 1
            case "€":
                defaultCurrencySegmentedControl.selectedSegmentIndex = 2
            default:
                defaultCurrencySegmentedControl.selectedSegmentIndex = -1
        }
        
        defaultTipSegmentedControl.sendActions(for: UIControlEvents.valueChanged)
        defaultCurrencySegmentedControl.sendActions(for: UIControlEvents.valueChanged)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
