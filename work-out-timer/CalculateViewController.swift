//
//  CalculateViewController.swift
//  work-out-timer
//
//  Created by 최은성 on 2022/02/16.
//

import Foundation
import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var showPick: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var kgResultLabel: UILabel!
    
    let countList:[String] = ["1","2","3","4","5","6","7","8","9","10"]
    
    var weight:Double = 0
    var count:Double = 0
    var result:Double = 0
    
    override func viewDidLoad() {
    
        showPick.delegate = self
        showPick.dataSource = self
        showPick.layer.cornerRadius = 20
        weightTextField.layer.cornerRadius = 20
        resultLabel.clipsToBounds = true
        resultLabel.layer.cornerRadius = 25
        
//        resultLabel.layer.isHidden = true
//        kgResultLabel.layer.isHidden = true
        
    }
    
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        weight = Double(weightTextField.text!) ?? 0.0
        result = weight*(1+count/30)    // 추정방식 Epley
        print(result)
        resultLabel.text = "\(round(result*10)/10)"
//        resultLabel.layer.isHidden = false
//        kgResultLabel.layer.isHidden = false
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }

    }

extension CalculateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countList.count
    }
    
    // Delegate method that returns the value to be displayed in the picker.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countList[row]
        
    }
    
    // A method called when the picker is selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(countList[row])")
        count = Double(countList[row]) ?? 0.0
        
    }



    }
