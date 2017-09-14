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
import ActionSheetPicker_3_0


class ReportsViewController: UIViewController {

    @IBOutlet weak var txtDealerId: UITextField!
    @IBOutlet weak var txtDurationFrom: UITextField!
    @IBOutlet weak var txtDurationTo: UITextField!
    
    @IBOutlet weak var btnGenerate: UIButton!
    
    @IBOutlet weak var serviceRadioBtn: DLRadioButton!
   
    @IBOutlet weak var partRadioBtn: DLRadioButton!
    
    var dateChoseView:DatePickerView?
    var pickerView:PickerView?
    var dealerIdArray:[String] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getDealerIds();
        getDealerIds();
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
        pickerView?.dealerIds = dealerIdArray
        self.view.addSubview(pickerView!)
        
    }
    
   
    @IBAction func dealerIdBtnClick(_ sender: UIButton) {
//        pickerView?.showView()
//        pickerView?.pickerDidChange {
//            (dealerId :String )  in
//            self.txtDealerId.text = dealerId
//    }
        
        ActionSheetStringPicker.show(withTitle: "Nav Bar From Picker", rows: ["633100", "633101", "633200"], initialSelection: 1, doneBlock: {
            picker, value, index in
            
            print("value = \(value)")
            print("index = \(String(describing: index))")
            print("picker = \(String(describing: picker))")
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
}
    
    @IBAction func dateFromBtnClick(_ sender: UIButton) {
//        dateChoseView?.showView()
//        dateChoseView?.pickerDidChange{
//            (String) in
//            self.txtDurationFrom.text = String
//        }
        
        let datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date!, doneBlock: {
                        picker, value, index in
            
                        print("value = \(String(describing: value))")
                        print("index = \(String(describing: index))")
                        print("picker = \(String(describing: picker))")
                        return
                    }, cancel: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
                    let secondsInyear: TimeInterval = 365 * 24 * 60 * 60*5;
                    datePicker?.minimumDate = NSDate(timeInterval: -secondsInyear, since: NSDate() as Date) as Date!
                    datePicker?.maximumDate = NSDate(timeInterval: secondsInyear, since: NSDate() as Date) as Date!
                    
                    datePicker?.show()


    }
    @IBAction func dateToBtnClick(_ sender: UIButton) {
//        dateChoseView?.showView()
//        dateChoseView?.pickerDidChange{
//            (String) in
//            self.txtDurationTo.text = String
//    }
        let datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date!, doneBlock: {
            picker, value, index in
            
            print("value = \(String(describing: value))")
            print("index = \(String(describing: index))")
            print("picker = \(String(describing: picker))")
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
        let secondsInyear: TimeInterval = 365 * 24 * 60 * 60*5;
        datePicker?.minimumDate = NSDate(timeInterval: -secondsInyear, since: NSDate() as Date) as Date!
        datePicker?.maximumDate = NSDate(timeInterval: secondsInyear, since: NSDate() as Date) as Date!
        
        datePicker?.show()
        

    }
    @IBAction func generateBtnClick(_ sender: Any) {
         self.performSegue(withIdentifier: "Login2Generate", sender: nil);
    }
    
    private func getDealerIds(){
        let parameters : Parameters = ["marketId": 1]
        let token = UserDefaults.standard.string(forKey: TOKEN)
        
        AFWrapper.getDealerByMartketId(GetDealerIdByMarketId_URL,params: parameters,token: token!,success: {(dealerIds) -> Void in
            guard dealerIds != nil  else{
                //Alert exception
                return
            }

            guard ((dealerIds?.count)! > 0) else {
               //Todo: dealerIds is empty, need to show alert
                return
            }
            
            for dealer in dealerIds!{
                self.dealerIdArray.append(dealer.DealerId!)
            }
            self.pickerView?.dealerIds = self.dealerIdArray

        }) {
            (error) -> Void in
            print(error)
        }

    }
}
