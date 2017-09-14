//
//  PartSurveyViewController.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/3.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import UIKit
import DLRadioButton
import Alamofire
class PartSurveyViewController: UIViewController {

    @IBOutlet weak var happyBtn: DLRadioButton!

    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var yesBtn: DLRadioButton!
    
    @IBOutlet weak var ratingControl: RatingControlView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitClick();
        
    }
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        let message = happyBtn.selected()?.titleLabel?.text!
        let message2 = yesBtn.selected()?.titleLabel?.text
        let message3 = ratingControl.rating
        print(String(format: "%@ is selected.\n",message!))
        print(String(format: "%@ is selected.\n",message2!))
        print(String(format: "%@ is selected.\n",String(message3)))
        
    }

    func submitClick(){
        let customer = CustomerModel()
        customer.ContactNo = "15222081197"
        customer.CustomerName = "Song"
        customer.Email = "Cary.song@volvo.com"
        let part = PartsModel();
        part.Customer = customer
        part.DealerId = "633201"
        part.Feedback = "feedback"
        part.IsPartAvailable = true
        part.RateOfExperience = 4.0
        part.RateOfWaitingTime = 3
        
        let para : Parameters = part.toJSON()!
        
        let token = UserDefaults.standard.string(forKey: TOKEN)
        
        AFWrapper.postUpdateParts(PostUpdatePartsSurvey,params: para,token: token!,success: {(model) -> Void in
            guard model != nil  else{
                //Alert exception
                return
            }
            
            guard model?.StatusCode != "11003" else{
                //Alert this dealerId is regesterd
                return
            }

            
        }) {
            (error) -> Void in
            print(error)
        }
    }


}
