//
//  RegisterViewController.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/3.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import UIKit
import Alamofire
import os.log

class RegisterViewController: UIViewController {

    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var txtDealerId: UITextField!
    var dealerModel: DealerModel?
    var dealerId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dealerIdValidation()
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func saveDealerInfo()
    {
        dealerId = txtDealerId.text
       
//        let parameters: Parameters = [
//            "DealerId": dealerId ?? "",
//            "Name": "DealerName",
//            "ContactNumber": "1522208",
//            "Email": "cary.song@volvo.com",
//            "Password":"123456",
//            "Address": "address"
//        ]
//        AFWrapper.dealerRegistration(Registration_URL,params: parameters,success: {(model) -> Void in
//            print(model)
//            
//        }) {
//            (error) -> Void in
//            print(error)
//        }

    }
    @IBAction func saveRegisterationInfo(_ sender: Any) {
        saveDealerInfo()
        self.performSegue(withIdentifier: "ToLogin", sender: self)
    }
    
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveBtn else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        dealerId = txtDealerId.text ?? ""

    }
    
    private func dealerIdValidation(){
        let parameters : Parameters = ["dealerId": "633100"]
        let token = UserDefaults.standard.string(forKey: TOKEN)
        
        AFWrapper.getDealerValidation(GetDealerIdValidtion,params: parameters,token: token!,success: {(returnModel) -> Void in
            guard returnModel != nil  else{
                //Alert exception
                return
            }
            
            guard returnModel!.StatusCode != "11003" else{
                //Alert this dealerId is regesterd
                return
            }
            
        }) {
            (error) -> Void in
            print(error)
        }
        
    }

   
}
