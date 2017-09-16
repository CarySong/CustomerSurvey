//
//  LoginViewController.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/3.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import UIKit
import SnapKit
import DLRadioButton
import os.log

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var txtUser: UITextField!
    var txtPwd: UITextField!
    var formView: UIView!
    var horizontalLine1: UIView!
    var horizontalLine2: UIView!
    var confirmButton:UIButton!
    var registerButton: UIButton!
    var titleLabel: UILabel!
    var partRadioButton: DLRadioButton!
    var serviceRadioButton: DLRadioButton!
    var dealerId : String?
    
    var topConstraint: Constraint? //登录框距顶部距离约束
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"backgroud.jpeg")!)

        //登录框高度
        let formViewHeight = 150
        //登录框背景
        self.formView = UIView()
        self.formView.layer.borderWidth = 0.5
        self.formView.layer.borderColor = UIColor.lightGray.cgColor
        self.formView.backgroundColor = UIColor.white
        self.formView.layer.cornerRadius = 5
        self.view.addSubview(self.formView)
        //最常规的设置模式
        self.formView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            //存储top属性
            self.topConstraint = make.centerY.equalTo(self.view).constraint
            make.height.equalTo(formViewHeight)
        }
        
        //分隔线1
        self.horizontalLine1 =  UIView()
        self.horizontalLine1.backgroundColor = UIColor.lightGray
        self.formView.addSubview(self.horizontalLine1)
        self.horizontalLine1.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.centerY.equalTo(self.formView).offset(-formViewHeight/6)
        }
        //分隔线2
        self.horizontalLine2 =  UIView()
        self.horizontalLine2.backgroundColor = UIColor.lightGray
        self.formView.addSubview(self.horizontalLine2)
        self.horizontalLine2.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.centerY.equalTo(self.formView).offset(formViewHeight/6)
        }

        
        //用户名图标
        let imgLock1 =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock1.image = UIImage(named:"icon-person")
        
        //密码图标
        let imgLock2 =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock2.image = UIImage(named:"icon-key")
        
        //密码图标
        let imgLock3 =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock3.image = UIImage(named:"icon-setting")
        
        
        //用户名输入框
        self.txtUser = UITextField()
        self.txtUser.delegate = self
        self.txtUser.placeholder = "DealerId"
        self.txtUser.tag = 100
        self.txtUser.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 49))
        self.txtUser.leftViewMode = UITextFieldViewMode.always
        self.txtUser.returnKeyType = UIReturnKeyType.next
        
        //用户名输入框左侧图标
        self.txtUser.leftView!.addSubview(imgLock1)
        self.formView.addSubview(self.txtUser)
        
        //布局
        self.txtUser.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(49)
            make.centerY.equalTo(self.formView).offset(-formViewHeight/3)
        }
        
        //密码输入框
        self.txtPwd = UITextField()
        self.txtPwd.delegate = self
        self.txtPwd.placeholder = "Password"
        self.txtPwd.tag = 101
        self.txtPwd.isSecureTextEntry = true
        self.txtPwd.isSecureTextEntry = true
        self.txtPwd.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 49))
        self.txtPwd.leftViewMode = UITextFieldViewMode.always
        self.txtPwd.returnKeyType = UIReturnKeyType.next
        
        //密码输入框左侧图标
        self.txtPwd.leftView!.addSubview(imgLock2)
        self.formView.addSubview(self.txtPwd)
        
        //布局
        self.txtPwd.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(49)
            make.centerY.equalTo(self.formView)
        }
        
        self.formView.addSubview(imgLock3)
        //布局
        imgLock3.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(24.5)
            make.width.equalTo(22)
            make.height.equalTo(22)
            make.centerY.equalTo(self.formView).offset(formViewHeight/3)
            
        }

        partRadioButton = DLRadioButton(frame:CGRect(x: 0, y: 0, width: 100, height: 49));
        partRadioButton.titleLabel!.font = UIFont.systemFont(ofSize: 16);
        partRadioButton.setTitle("Part", for: UIControlState());
        partRadioButton.setTitleColor(UIColor.lightGray, for: UIControlState());
        partRadioButton.iconColor = UIColor.lightGray;
        partRadioButton.indicatorColor = UIColor.red;
        partRadioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left;
        partRadioButton.isSelected = true
        self.formView.addSubview(partRadioButton);
        
        partRadioButton.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(imgLock3.snp.right).offset(25)
            make.width.equalTo(100)
            make.height.equalTo(49)
            make.centerY.equalTo(self.formView).offset(formViewHeight/3)
        }

        
        serviceRadioButton = DLRadioButton(frame:CGRect(x: 0, y: 0, width: 100, height: 49));
        serviceRadioButton.titleLabel!.font = UIFont.systemFont(ofSize: 16);
        serviceRadioButton.setTitle("Service", for: UIControlState());
        serviceRadioButton.setTitleColor(UIColor.lightGray, for: UIControlState());
        serviceRadioButton.iconColor = UIColor.lightGray;
        serviceRadioButton.indicatorColor = UIColor.red;
        serviceRadioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left;
        self.formView.addSubview(serviceRadioButton);
        partRadioButton.otherButtons.append(serviceRadioButton)
        
        serviceRadioButton.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(partRadioButton)
            make.left.equalTo(partRadioButton.snp.right).offset(25)
            make.height.equalTo(49)
            make.centerY.equalTo(self.formView).offset(formViewHeight/3)
        }

        
        //登录按钮
        self.confirmButton = UIButton()
        self.confirmButton.setTitle("Sign in", for: UIControlState())
        self.confirmButton.setTitleColor(UIColor.black,
                                         for: UIControlState())
        self.confirmButton.layer.cornerRadius = 5
        self.confirmButton.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1,
                                                     alpha: 0.5)
        self.confirmButton.addTarget(self, action: #selector(loginConfrim),
                                     for: .touchUpInside)
        self.view.addSubview(self.confirmButton)
        self.confirmButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(25)
            make.top.equalTo(self.formView.snp.bottom).offset(20)
            make.width.equalTo(self.formView).multipliedBy(0.3)
            make.height.equalTo(40)
            
        }
        
        //Register button
        self.registerButton = UIButton()
        self.registerButton.setTitle("Sign Up", for: UIControlState())
        self.registerButton.setTitleColor(UIColor.black,
                                         for: UIControlState())
        self.registerButton.layer.cornerRadius = 5
        self.registerButton.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1,
                                                     alpha: 0.5)
        self.registerButton.addTarget(self, action: #selector(registerClick),
                                     for: .touchUpInside)
        self.view.addSubview(self.registerButton)
        self.registerButton.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(self.confirmButton)
            make.top.equalTo(self.formView.snp.bottom).offset(20)
            make.right.equalTo(-25)
            make.height.equalTo(40)
        }

        //标题label
        self.titleLabel = UILabel()
        self.titleLabel.text = "CustomerSurvey"
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 48)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.formView.snp.top).offset(-20)
            make.centerX.equalTo(self.view)
            make.height.equalTo(59)
        }
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for:segue, sender: sender)
        
        switch(segue.identifier ?? ""){
            
        case "Login2Report":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "Login2Register":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
         
        case "Login2PartSurveys":
            guard let partSurveyViewController = segue.destination as? PartSurveyViewController else{
                fatalError("Unexpected destination:\(segue.destination)")
            }
            partSurveyViewController.dealerId = self.dealerId
            
        case "Login2ServiceSurveys":
            guard let serviceSurveyViewController = segue.destination as? ServiceSurVeyViewController else{
                                fatalError("Unexpected destination:\(segue.destination)")
            }
            
            serviceSurveyViewController.dealerId = self.dealerId

        default:
            fatalError("Unexpected segue Identifier;\(segue.identifier!)")
        }
    }

    
    
    @IBAction func unwindToLogin(sender: UIStoryboardSegue) {
      
        if let sourceViewController = sender.source as? RegisterViewController  {
            txtUser.text = sourceViewController.dealerId
        }
        
    }
    
    //输入框获取焦点开始编辑
    func textFieldDidBeginEditing(_ textField:UITextField)
    {
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: -125)
            self.view.layoutIfNeeded()
        })
    }
    
    //输入框返回时操作
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        let tag = textField.tag
        switch tag {
        case 100:
            self.txtPwd.becomeFirstResponder()
        case 101:
            loginConfrim()
        default:
            print(textField.text!)
        }
        return true
    }
    
    //登录按钮点击
    func loginConfrim(){
        //收起键盘
        self.view.endEditing(true)
        //视图约束恢复初始设置
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
        })
        
        self.dealerId = txtUser.text ?? ""
        
        let password = txtPwd.text ?? ""
        
        guard !((dealerId?.isEmpty)!) else {
           AlertView_show("Error", message: "The Dealer Id is invalid!")
           txtUser.becomeFirstResponder()
           return
        }
        
        guard !password.isEmpty else {
            AlertView_show("Error", message: "The Password is invalid!")
            txtPwd.becomeFirstResponder()
            return
        }
        
        AFWrapper.Login(Login_URL,userId: dealerId!,password: password,success: {(model) -> Void in
            
            guard model != nil  else{
            AlertView_show("Error", message: "Please contact support")
            self.txtUser.becomeFirstResponder()
            return
            }
            
            guard (model?.StatusCode != "10003" ) else {
                let defaults = UserDefaults.standard
                defaults.setValue(model?.Authorization, forKey: TOKEN)
                defaults.synchronize()
                if (self.partRadioButton.isSelected)
                {
                    self.performSegue(withIdentifier: "Login2PartSurveys", sender: self)
                }
                else
                {
                    self.performSegue(withIdentifier: "Login2ServiceSurveys", sender: self)
                }
                return
            }
            
            guard (model?.StatusCode != "10004" ) else {
                //Navigate to Report
                let defaults = UserDefaults.standard
                defaults.setValue(model?.Authorization, forKey: TOKEN)
                defaults.synchronize()
                self.performSegue(withIdentifier: "Login2Report", sender: self)
                return
            }
            
            guard (model?.StatusCode != "10001" ) else {
            //DealerId is Invalid  Alert
            AlertView_show("Error", message: "The Dealer Id is invalid!")
            self.txtUser.becomeFirstResponder()
            return
            }
            
            guard (model?.StatusCode != "10002" ) else {
                AlertView_show("Error", message: "The Password is invalid!")
                self.txtPwd.becomeFirstResponder()
                return
            }
           
            }) {
            (error) -> Void in
            AlertView_show("Error", message: "Network error, please try again")

            NSLog(error as! String)
        }
    }
    
    func registerClick(){
        self.performSegue(withIdentifier: "Login2Register", sender: self);
    }

 }
