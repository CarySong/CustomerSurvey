//
//  ReportsViewController.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/6.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import DLRadioButton


class ReportsViewController: UIViewController {

    @IBOutlet weak var txtDealerId: UITextField!
    @IBOutlet weak var txtDurationFrom: UITextField!
    @IBOutlet weak var txtDurationTo: UITextField!
    
    @IBOutlet weak var btnGenerate: UIButton!
    
    @IBOutlet weak var serviceRadioBtn: DLRadioButton!
   
    @IBOutlet weak var partRadioBtn: DLRadioButton!
    
    var dateChoseView:DatePickerView?
    var pickerView:PickerView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partRadioBtn.titleLabel!.font = UIFont.systemFont(ofSize: 16);
        partRadioBtn.setTitle("Part", for: UIControlState());
        partRadioBtn.setTitleColor(UIColor.lightGray, for: UIControlState());
        partRadioBtn.iconColor = UIColor.lightGray;
        partRadioBtn.indicatorColor = UIColor.red;
        
        serviceRadioBtn.titleLabel!.font = UIFont.systemFont(ofSize: 16);
        serviceRadioBtn.setTitle("Service", for: UIControlState());
        serviceRadioBtn.setTitleColor(UIColor.lightGray, for: UIControlState());
        serviceRadioBtn.iconColor = UIColor.lightGray;
        serviceRadioBtn.indicatorColor = UIColor.red;

        partRadioBtn.otherButtons.append(serviceRadioBtn)
        
        dateChoseView = DatePickerView.init(frame:CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.height), onView: self.view)
        self.view.addSubview(dateChoseView!)
        
        pickerView = PickerView.init(frame:CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.height), onView: self.view)
        //传入要选择的数据
        pickerView?.dealerIds = ["张三","李四","王五","李峰","欧阳远"]
        self.view.addSubview(pickerView!)
        
    }
    
   
    @IBAction func dealerIdBtnClick(_ sender: UIButton) {
        pickerView?.showView()
        pickerView?.pickerDidChange {
            (dealerId :String )  in
            self.txtDealerId.text = dealerId
    }
}
    
    @IBAction func dateFromBtnClick(_ sender: UIButton) {
        dateChoseView?.showView()
        dateChoseView?.pickerDidChange{
            (String) in
            self.txtDurationFrom.text = String
        }

    }
    @IBAction func dateToBtnClick(_ sender: UIButton) {
        dateChoseView?.showView()
        dateChoseView?.pickerDidChange{
            (String) in
            self.txtDurationTo.text = String
    }
   
    }
    @IBAction func generateBtnClick(_ sender: Any) {
         self.performSegue(withIdentifier: "2Generate", sender: nil);
    }
        
    
}
