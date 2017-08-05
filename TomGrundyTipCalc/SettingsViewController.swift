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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let percentage = defaults.string(forKey: "default_percentage") ?? "15%"
        
        switch percentage {
            case "15%":
                defaultTipSegmentedControl.setEnabled(true, forSegmentAt: 0)
            case "18%":
                defaultTipSegmentedControl.setEnabled(true, forSegmentAt: 1)
            case "20%":
                defaultTipSegmentedControl.setEnabled(true, forSegmentAt: 2)
            default:
                defaultTipSegmentedControl.setEnabled(true, forSegmentAt: 0)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
