//
//  ViewController.swift
//  ConvertAnything
//
//  Created by Guest User on 3/4/17.
//  Copyright © 2017 Dung Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputVol: UITextField!
    @IBOutlet weak var inputUnit: UITextField!
    @IBOutlet weak var inputUnitChoice: UIPickerView!
    @IBOutlet weak var firstVol: UILabel!
    @IBOutlet weak var secondVol: UILabel!
    @IBOutlet weak var thirdVol: UILabel!
    @IBOutlet weak var fourthVol: UILabel!
    @IBOutlet weak var fifthVol: UILabel!
    @IBOutlet weak var firstUnit: UILabel!
    @IBOutlet weak var secondUnit: UILabel!
    @IBOutlet weak var thirdUnit: UILabel!
    @IBOutlet weak var fourthUnit: UILabel!
    @IBOutlet weak var fifthUnit: UILabel!
    
    @IBOutlet weak var inputValueSlider: UISlider!
    @IBOutlet weak var convertBtn: UIButton!
    
    var listOfUnitChoice = ["m3", "l/dm3", "US gallons", "mL", "US ounce", "US quart"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        checkInputUnit()
        if (inputUnit.text == listOfUnitChoice[0]) {
            convertFromCubicMeter()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Conversion
    func checkInputUnit() {
        inputUnit.text = listOfUnitChoice[0]
        firstUnit.text = listOfUnitChoice[1]
        secondUnit.text = listOfUnitChoice[2]
        thirdUnit.text = listOfUnitChoice[3]
        fourthUnit.text = listOfUnitChoice[4]
        fifthUnit.text = listOfUnitChoice[5]
        
        switch inputUnit.text! {
        case listOfUnitChoice[1]:
            firstUnit.text = listOfUnitChoice[0]
        case listOfUnitChoice[2]:
            secondUnit.text = listOfUnitChoice[0]
        case listOfUnitChoice[3]:
            thirdUnit.text = listOfUnitChoice[0]
        case listOfUnitChoice[4]:
            fourthUnit.text = listOfUnitChoice[0]
        case listOfUnitChoice[5]:
            fifthUnit.text = listOfUnitChoice[0]
        default:
            //do nothing
            break
        }
    }
    
    func convertFromCubicMeter() {
        var dm3 = Double(inputVol.text!)! * 1000;
        var gal = Double(inputVol.text!)! * 264.172;
        var mL = Double(inputVol.text!)! * 1000000;
        var oz = Double(inputVol.text!)! * 33184;
        var quart = Double(inputVol.text!)! * 1056.69;
        firstVol.text = String(dm3)
        secondVol.text = String(gal)
        thirdVol.text = String(mL)
        fourthVol.text = String(oz)
        fifthVol.text = String(quart)
    }
    
    // Choosing volume units
    func numberOfComponentsInViewPicker(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfUnitChoice.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        self.view.endEditing(true)
        return listOfUnitChoice[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.inputUnit.text = self.listOfUnitChoice[row]
        self.inputUnitChoice.isHidden = true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.inputUnit {
            self.inputUnitChoice.isHidden = false
            textField.endEditing(true)
        }
    }

}

