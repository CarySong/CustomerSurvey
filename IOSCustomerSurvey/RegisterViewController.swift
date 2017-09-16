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

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDealerName: UITextField!
    @IBOutlet weak var txtContactNo: UITextField!
    @IBOutlet weak var txtDealerId: UITextField!
    var dealerModel: DealerModel?
    var dealerId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"backgroud.jpeg")!)
        self.dealerModel = DealerModel()
    }
    
    @IBAction func ValidateDealerId(_ sender: Any) {
        self.dealerId = self.txtDealerId.text?.trimmingCharacters(in: .whitespaces)
        guard  !(dealerId!.isEmpty)  else {
            self.txtDealerId.becomeFirstResponder()
            return
        }
        let parameters : Parameters = ["dealerId": dealerId!]
        let token = UserDefaults.standard.string(forKey: TOKEN)
        AFWrapper.getDealerValidation(GetDealerIdValidtion,params: parameters, token: token!,success: {(returnModel) -> Void in
            guard returnModel != nil  else{
                AlertView_show("Error", message: "Please try again!")
                self.txtDealerId.becomeFirstResponder()
                return
            }
            guard returnModel!.StatusCode != "11003" else{
                AlertView_show("Error", message: "This DealerId is regested!")
                self.txtDealerId.becomeFirstResponder()
                return
            }
            self.txtDealerName.becomeFirstResponder()
        }) {
            (error) -> Void in
            print(error)
        }

    }
    
    @IBAction func dealerNameFinishEdit(_ sender: UITextField) {
        self.txtContactNo.becomeFirstResponder()
    }
    @IBAction func contactFinishEdit(_ sender: UITextField) {
        self.txtEmail.becomeFirstResponder()
    }
    
    
    @IBAction func emailFinishEditting(_ sender: UITextField) {
        guard validateEmail(email: txtEmail.text!) else{
            alert(error: "wrong email address", message: "please input correct email")
            txtEmail.becomeFirstResponder()
            return
        }
        txtPassword.becomeFirstResponder()
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func passwordFinishEditing(_ sender: UITextField) {
        txtPassword.resignFirstResponder()
        txtAddress.becomeFirstResponder()
    }

    @IBAction func addressFinishEditing(_ sender: UITextField) {
        txtAddress.resignFirstResponder()

    }
    @IBAction func saveRegisterationInfo(_ sender: Any) {
        validateFields()
        dealerModel?.DealerId = txtDealerId.text
        dealerModel?.Name = txtDealerName.text
        dealerModel?.ContactNumber = txtContactNo.text
        dealerModel?.Email = txtEmail.text
        dealerModel?.Password = txtPassword.text
        dealerModel?.Address = txtAddress.text
        
        let para: Parameters = (dealerModel?.toJSON())!
        AFWrapper.dealerRegistration(Registration_URL,params: para,success: {(model) -> Void in
            guard model != nil  else{
                AlertView_show("Error", message: "Please try again!")
                self.txtDealerId.becomeFirstResponder()
                return
            }
            let statusCode = model?.StatusCode
            switch(statusCode!){
            case "11000":
                self.performSegue(withIdentifier: "ToLogin", sender: self)
            case "11002":
                AlertView_show("Error", message: "Invalid DealerId")
                
            case "11003":
                AlertView_show("Error", message: "Register Faild")
                
            default:
                AlertView_show("Error", message: "Failure, Please try again, or contact support team!")
            }
            
        }) {
            (error) -> Void in
            print(error)
        }

    }
    
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button != saveBtn else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        dealerId = self.txtDealerId.text ?? "0000"

    }
    
   
    func validateFields(){
        guard !(txtDealerId.text!.isEmpty) else{
            alert(error: "Information", message: "Please input Dealer ID!")
            self.txtDealerId.becomeFirstResponder()
            return
        }
        
        guard  !txtDealerName.text!.isEmpty else{
            alert(error: "Information", message: "Please input Dealer Name!")
            txtDealerName.becomeFirstResponder()
            return
        }
        
        guard !txtContactNo.text!.isEmpty else{
            alert(error: "Information", message: "Please input Contact Number!")
            txtContactNo.becomeFirstResponder()
            return
        }
        
        guard validateEmail(email: txtEmail.text!) else{
            alert(error: "wrong email address", message: "please input correct email")
            txtEmail.becomeFirstResponder()
            return
        }
        
        guard !txtPassword.text!.isEmpty else{
            alert(error: "Information", message: "Please input Password!")
            txtPassword.becomeFirstResponder()
            return
            
        }
        guard !txtAddress.text!.isEmpty else{
            alert(error: "Information", message: "Please input Address!")
            txtAddress.becomeFirstResponder()
        return
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
