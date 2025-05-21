//
//  ViewController.swift
//  BMI01-GSM
//
//  Created by SS on 12/8/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblReult: UILabel!
    
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    
    @IBAction func calcBmi(_ sender: UIButton) {
        if txtHeight.text == "" || txtWeight.text == "" {
            lblReult.textColor = .red
            lblReult.text = "키와 체중을 입력하세요!"
            return
        } else {
            let weight = 60.0
            let height = 170.0
            
            let bmi = weight / (height * height * 0.0001) // kg/m²
            let shortenedBmi = String(format: "%.1f", bmi)
            var body = ""
            var color = UIColor.white
            if bmi >= 40 {
                color = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
                body = "3단계 비만"
            } else if bmi >= 30 && bmi < 40 {
                color = UIColor(displayP3Red: 0.7, green: 0.0, blue: 0.0, alpha: 1.0)
                body = "2단계 비만"
            } else if bmi >= 25 && bmi < 30 {
                color = UIColor(displayP3Red: 0.4, green: 0.0, blue: 0.0, alpha: 1.0)
                body = "1단계 비만"
            } else if bmi >= 18.5 && bmi < 25 {
                color = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
                body = "정상"
            } else {
                color = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
                body = "저체중"
            }
            lblReult.backgroundColor = color
            lblReult.layer.cornerRadius = 10
            lblReult.clipsToBounds = true
            lblReult.text = "BMI: \(shortenedBmi), 판정: \(body)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

