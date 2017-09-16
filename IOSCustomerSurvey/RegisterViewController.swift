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
    
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDealerName: UITextField!
    @IBOutlet weak var txtContactNo: UITextField!
    @IBOutlet weak var txtDealerId: UITextField!
    var dealerModel: DealerModel?
    var dealerId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"backgroud.jpeg")!)
        
      //  dealerIdValidation()
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func saveDealerInfo()
    {
        dealerId = "6331111"
       
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
       // saveDealerInfo()
        dealerIdValidation()
        validateFields()
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

    func validateFields(){
        if txtDealerId.text!.isEmpty{
            alert(error: "Information", message: "Please input Dealer ID!")
            
        }
        else{
            //TODO:
            // Validate the user name exist.
        }
        
        if txtDealerName.text!.isEmpty{
            alert(error: "Information", message: "Please input Dealer Name!")
        }
        
        if txtContactNo.text!.isEmpty{
            alert(error: "Information", message: "Please input Contact Number!")
        }
        
        if !validateEmail(email: txtEmail.text!){
            alert(error: "wrong email address", message: "please input correct email")
            
        }
        
        if txtPassword.text!.isEmpty{
            alert(error: "Information", message: "Please input Password!")
        }
        if txtAddress.text!.isEmpty{
            alert(error: "Information", message: "Please input Address!")
        }
        
    }
    
    //validate Email
    func validateEmail (email: String) -> Bool {
        let regex = "\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}"
        let range = email.range(of: regex, options: .regularExpression)
        let result = range != nil ? true: false
        return result
    }
    func alert(error: String, message: String){
        let alert = UIAlertController(title: error, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        // return
    }
}
