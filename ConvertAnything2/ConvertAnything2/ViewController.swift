//
//  ViewController.swift
//  ConvertAnything2
//
//  Created by Le, Dung Tien on 3/5/17.
//  Copyright © 2017 Dung Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var unitChoice1: UIButton!
    @IBOutlet weak var secondUnitChoice1: UIButton!
    @IBOutlet weak var thirdUnitChoice1: UIButton!
    @IBOutlet weak var fourthUnitChoice1: UIButton!
    @IBOutlet weak var fifthUnitChoice1: UIButton!
    
    @IBOutlet var unitConvertFrom: [UIView]! {
        didSet {
            unitConvertFrom.forEach {
                $0.isHidden = true
            }
        }
    }

    @IBOutlet weak var unitChoice2: UIButton!
    @IBOutlet weak var secondUnitChoice2: UIButton!
    @IBOutlet weak var thirdUnitChoice2: UIButton!
    @IBOutlet weak var fourthUnitChoice2: UIButton!
    @IBOutlet weak var fifthUnitChoice2: UIButton!
    @IBOutlet var unitConvertTo: [UIView]! {
        didSet {
            unitConvertTo.forEach {
                $0.isHidden = true
            }
        }
    }
    
    @IBOutlet weak var volumeEntered: UITextField!
    
    @IBOutlet weak var volumeConverted: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if unitChoice1.currentTitle == "m3" {
            convertFromCubicMeter();
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onUnitChoicePressed(_ sender: Any) {
        hideUnitChoices1()
    }
    
    @IBAction func on2UnitChoice1Pressed(_ sender: UIButton) {
        let unitChoice1Label = unitChoice1.currentTitle
        unitChoice1.setTitle(secondUnitChoice1.currentTitle, for: UIControlState.normal)
        secondUnitChoice1.setTitle(unitChoice1Label, for: UIControlState.normal)
        hideUnitChoices1()
    } 
    
    @IBAction func on3UnitChoice1Pressed(_ sender: UIButton) {
        let unitChoice1Label = unitChoice1.currentTitle
        unitChoice1.setTitle(thirdUnitChoice1.currentTitle, for: UIControlState.normal)
        thirdUnitChoice1.setTitle(unitChoice1Label, for: UIControlState.normal)
        hideUnitChoices1()
    }
    
    @IBAction func on4UnitChoice1Pressed(_ sender: UIButton) {
        let unitChoice1Label = unitChoice1.currentTitle
        unitChoice1.setTitle(fourthUnitChoice1.currentTitle, for: UIControlState.normal)
        fourthUnitChoice1.setTitle(unitChoice1Label, for: UIControlState.normal)
        hideUnitChoices1()
    }
    
    @IBAction func on5UnitChoice1Pressed(_ sender: UIButton) {
        let unitChoice1Label = unitChoice1.currentTitle
        unitChoice1.setTitle(fifthUnitChoice1.currentTitle, for: UIControlState.normal)
        fifthUnitChoice1.setTitle(unitChoice1Label, for: UIControlState.normal)
        hideUnitChoices1()
    }


    @IBAction func onUnitConvertPressed(_ sender: Any) {
        hideUnitChoices2()
    }
    
    @IBAction func on2UnitConvertPressed(_ sender: UIButton) {
        let unitChoice2Label = unitChoice2.currentTitle
        unitChoice2.setTitle(secondUnitChoice2.currentTitle, for: UIControlState.normal)
        secondUnitChoice2.setTitle(unitChoice2Label, for: UIControlState.normal)
        hideUnitChoices2()
    }
    
    @IBAction func on3UnitConvertPressed(_ sender: UIButton) {
        let unitChoice2Label = unitChoice2.currentTitle
        unitChoice2.setTitle(thirdUnitChoice2.currentTitle, for: UIControlState.normal)
        thirdUnitChoice2.setTitle(unitChoice2Label, for: UIControlState.normal)
        hideUnitChoices2()
    }
    
    @IBAction func on4UnitConvertPressed(_ sender: UIButton) {
        let unitChoice2Label = unitChoice2.currentTitle
        unitChoice2.setTitle(fourthUnitChoice2.currentTitle, for: UIControlState.normal)
        fourthUnitChoice2.setTitle(unitChoice2Label, for: UIControlState.normal)
        hideUnitChoices2()
    }
    
    @IBAction func on5UnitConvertPressed(_ sender: UIButton) {
        let unitChoice2Label = unitChoice2.currentTitle
        unitChoice2.setTitle(fifthUnitChoice2.currentTitle, for: UIControlState.normal)
        fifthUnitChoice2.setTitle(unitChoice2Label, for: UIControlState.normal)
        hideUnitChoices2()
    }
    
    func hideUnitChoices1() {
        UIView.animate(withDuration: 0.3) {
            self.unitConvertFrom.forEach {
                $0.isHidden = !$0.isHidden
            }
        }
    }
    
    func hideUnitChoices2() {
        UIView.animate(withDuration: 0.3) {
            self.unitConvertTo.forEach {
                $0.isHidden = !$0.isHidden
            }
        }
    }
    
    func convertFromCubicMeter() {
        let dm3 = Double(volumeEntered.text!)! * 1000;
        let gal = Double(volumeEntered.text!)! * 264.172;
        let mL = Double(volumeEntered.text!)! * 1000000;
        let quart = Double(volumeEntered.text!)! * 1056.69;
        
        switch (unitChoice2.currentTitle)! {
        case "l/dm3":
            volumeConverted.text = String(dm3)
        case "US gallon":
            volumeConverted.text = String(gal)
        case "mL":
            volumeConverted.text = String(mL)
        case "US quart":
            volumeConverted.text = String(quart)
        default:
            volumeConverted.text = volumeEntered.text
        }
    }
    
}

