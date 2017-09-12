//
//  RegisterViewController.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/3.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let parameters: Parameters = [
            "DealerId": "633100",
            "Name": "DealerName",
            "ContactNumber": "1522208",
            "Email": "1@3.com",
            "Password":"123456",
            "Address": "address"
        ]
        AFWrapper.dealerRegistration(Registration_URL,params: parameters,success: {(model) -> Void in
            print(model)
            
        }) {
            (error) -> Void in
            print(error)
        }

    }

   
}
