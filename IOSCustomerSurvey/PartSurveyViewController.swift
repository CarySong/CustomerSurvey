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
class PartSurveyViewController: UIViewController{

    @IBOutlet weak var waitingBtn: DLRadioButton!
    
    @IBOutlet weak var partAvailableBtn: DLRadioButton!
    
    @IBOutlet weak var ratingContrl: RatingControlView!
    
    @IBOutlet weak var txtFeedback: UITextView!
    
    @IBOutlet weak var txtCustomerName: UITextField!
    
    @IBOutlet weak var txtCustomerEmail: UITextField!
    
    @IBOutlet weak var txtCustomerContact: UITextField!
    
    
    
    var dealerId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFeedbackView()
    }
    
    
    @IBAction func customerNameFinishEdit(_ sender: UITextField) {
        self.txtCustomerName.resignFirstResponder()
    }
    
    
    @IBAction func customerEmailFinishEdit(_ sender: UITextField) {
        self.txtCustomerEmail.resignFirstResponder()
    }
    
    @IBAction func contactNoFinishEdit(_ sender: UITextField) {
        self.txtCustomerContact.resignFirstResponder()
    }

    
    func initFeedbackView()
    {
        let topView = UIToolbar(frame: CGRect(x: 0, y: 0,width: 350, height: 25))
        // 设置工具条风格
        topView.barStyle = .default
        // 该按钮只是一块可伸缩的空白区
        let spaceBn = UIBarButtonItem(barButtonSystemItem:.flexibleSpace,
                                      target:self, action:nil)
        // 为工具条创建第2个“按钮”，单击该按钮会激发editFinish方法
        let doneBn = UIBarButtonItem(title:"Done", style:.done,
                                     target:self, action:#selector(PartSurveyViewController.editFinish))
        // 以三个按钮创建Array集合
        let buttonsArray = [spaceBn, doneBn]
        // 为UIToolBar设置按钮
        topView.items = buttonsArray
        // 为textView关联的虚拟键盘设置附件
        self.txtFeedback.inputAccessoryView = topView

    }
    func editFinish() {
        self.txtFeedback.resignFirstResponder()
    }


    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        
        let waitingTime = waitingBtn.selected()?.titleLabel?.text ?? ""
        let partAvailable = partAvailableBtn.selected()?.titleLabel?.text ?? ""
        let rating = ratingContrl.rating
        let feedback = txtFeedback.text ?? ""
        let customerName = txtCustomerName.text ?? ""
        let customerEmail = txtCustomerEmail.text ?? ""
        let customerContact = txtCustomerContact.text ?? ""
        
        guard  waitingTime !=  "> 10 mins"  else {
            AlertView_show("Info", message: "Please select the first item!")
            return
        }
        
        guard !(partAvailable.isEmpty) else {
            AlertView_show("Info", message: "Please select the second item")
            return
        }
        
        guard rating != 0 else {
            AlertView_show("Info", message: "Please select the third item")
            return
        }
        guard !(feedback.isEmpty) else {
            if (waitingTime == "> 10 mins" || rating < 5 || partAvailable == "No")
            {
            AlertView_show("Info", message: "Please fill in the feedback")
            }
            return
        }
        
        guard !(customerName.isEmpty) else {
            if (waitingTime == "> 10 mins" || rating < 5 || partAvailable == "No")
            {
                AlertView_show("Info", message: "Please fill in the customer name")
            }
            return
        }
        
        guard !(customerEmail.isEmpty) else {
            if (waitingTime == "> 10 mins" || rating < 5 || partAvailable == "No")
            {
                AlertView_show("Info", message: "Please fill in the customer Eamil Adress")
            }
            return
        }

        guard !(customerContact.isEmpty) else {
            if (waitingTime == "> 10 mins" || rating < 5 || partAvailable == "No")
            {
                AlertView_show("Info", message: "Please fill in the customer contact number")
            }
            return
        }
        
        
        
        let customer = CustomerModel()
        customer.ContactNo = customerContact
        customer.CustomerName = customerName
        customer.Email = customerEmail
        let part = PartsModel();
        part.Customer = customer
        part.DealerId = dealerId
        part.Feedback = feedback
        
        if partAvailable == "Yes" {
            part.IsPartAvailable = true
        }else
        {
            part.IsPartAvailable = false
        }
        part.RateOfExperience = Float(rating)
        if (waitingTime == "> 10 mins"){
        part.RateOfWaitingTime = 2
        } else if (waitingTime == " 5 - 10 mins"){
            part.RateOfWaitingTime = 1
        }else{
        part.RateOfWaitingTime = 0
        }
        
        let para : Parameters = part.toJSON()!
        
        let token = UserDefaults.standard.string(forKey: TOKEN)
        
        AFWrapper.postUpdateSurvey(PostUpdatePartsSurvey,params: para,token: token!,success: {(model) -> Void in
            guard model != nil  else{
            AlertView_show("Error", message: "Please contact support")
            return
            }
            
            let statusCode = model?.StatusCode
            switch(statusCode!){
            case "12002":
                AlertView_show("Info", message: "Thanks for your feedback!")
                break;
            case "12003":
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
