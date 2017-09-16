//
//  ServiceVeyViewController.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/3.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import UIKit
import Alamofire

class ServiceSurVeyViewController: UIViewController {
    var dealerId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func submitClick(){
        let customer = CustomerModel()
        customer.ContactNo = "15222081197"
        customer.CustomerName = "Song"
        customer.Email = "Cary.song@volvo.com"
        let service = ServiceModel();
        service.Customer = customer
        service.DealerId = dealerId
        service.Feedback = "feedback"
        service.IsDeliveryOnTime = true
        service.RateOfExperience = 4.0
        service.RateOfProcess = 3
        
        let para : Parameters = service.toJSON()!
        
        let token = UserDefaults.standard.string(forKey: TOKEN)
        
        AFWrapper.postUpdateSurvey(PostUpdateServiceSurvey,params: para,token: token!,success: {(model) -> Void in
            guard model != nil  else{
                AlertView_show("Error", message: "Please contact support")
                return
            }
            
            let statusCode = model?.StatusCode
            switch(statusCode!){
            case "12000":
                AlertView_show("Info", message: "Thanks for your feedback!")
                break;
            case "12001":
                AlertView_show("Error", message: "Submit faild")
                break;
            default:
                AlertView_show("Error", message: "Failure, Please try again, or contact support team!")
            }
            
            
        }) {
            (error) -> Void in
            AlertView_show("Error", message: "Network error, please try again")
            NSLog(error as! String)
        }
    }
    

}
