//
//  DatePicker.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/8.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import UIKit


class DatePickerView: UIView {

    typealias datePickerDidChange = (String) -> ()
    var viewH:CGFloat = 0
    var datePicker:UIDatePicker?
    var didChange:datePickerDidChange?
  
    init(frame:CGRect,onView:UIView) {
        super.init(frame: frame)
        viewH = frame.size.height/3
        self.frame = CGRect(x: 0, y: onView.frame.size.height, width: onView.frame.size.width, height: viewH)
        self.backgroundColor = UIColor.white
        onView.addSubview(self)
        
        let toolView:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: onView.frame.size.width, height: 40))
        self.addSubview(toolView)
        
        
        let leftButton:UIButton = UIButton.init(type: UIButtonType.system)
        leftButton.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        leftButton.setTitle("Cancel", for: UIControlState.normal)
        leftButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        leftButton.addTarget(self, action: #selector(cancelAction), for: UIControlEvents.touchUpInside)
        self.addSubview(leftButton)
        
        
        let rightButton:UIButton = UIButton.init(type: UIButtonType.system)
        rightButton.frame = CGRect(x: onView.frame.size.width-80, y:0 , width: 80, height: 40)
        rightButton.setTitle("Confirm", for: UIControlState.normal)
        rightButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        rightButton.addTarget(self, action:#selector(sureAction), for: UIControlEvents.touchUpInside)
        self.addSubview(rightButton)
        
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 40, width: onView.frame.size.width, height: viewH-40))
        datePicker?.backgroundColor = UIColor.lightGray
        datePicker?.datePickerMode = .date
        // 设置该UIDatePicker为简体中文
        // 设置该UIDatePicker支持的最大时间和最小时间
        datePicker?.maximumDate = Date(timeIntervalSinceNow:365 * 24 * 3600)
        datePicker?.minimumDate = Date(timeIntervalSinceNow:-365 * 24 * 3600)
        
        self.addSubview(datePicker!)
        datePicker?.addTarget(self, action:#selector(pickChange(picker:)), for: UIControlEvents.valueChanged)
        
        
    }
    
  
    private func backgroundButtonAction(button:UIButton){
       
    }
    
    func pickChange(picker:UIDatePicker){
   
        let format:DateFormatter = DateFormatter.init()
        format.dateFormat = "yyyy.MM.dd"
       
        let dateString = format.string(from: picker.date)
        self.didChange!(dateString)
        
    }
    
    func cancelAction(){
        self.hideView()
    }
    
    func sureAction(){
        let format:DateFormatter = DateFormatter.init()
        format.dateFormat = "yyyy.MM.dd hh:mm:ss"
        
        let dateString = format.string(from: (datePicker?.date)!)
        self.didChange!(dateString)
        self.hideView()
    }
    
    
    func showView(){
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform.init(translationX: 0, y: -self.viewH)
        }
    }
    func hideView(){
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform.init(translationX: 0, y: self.viewH)
        }
    }
    
    func pickerDidChange(change:@escaping ((String) -> ())){
        self.didChange = change;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

   }
