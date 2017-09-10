//
//  PartSurveyViewController.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/3.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import UIKit
import DLRadioButton
class PartSurveyViewController: UIViewController {

    @IBOutlet weak var happyBtn: DLRadioButton!

    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var yesBtn: DLRadioButton!
    
    @IBOutlet weak var ratingControl: RatingControlView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        let message = happyBtn.selected()?.titleLabel?.text!
        let message2 = yesBtn.selected()?.titleLabel?.text
        let message3 = ratingControl.rating
        print(String(format: "%@ is selected.\n",message!))
        print(String(format: "%@ is selected.\n",message2!))
        print(String(format: "%@ is selected.\n",String(message3)))
        
    }

   

}
