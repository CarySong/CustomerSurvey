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



class ToGenerareReportsViewController: UIViewController {

    @IBOutlet weak var txtDealerId: UITextField!
    @IBOutlet weak var txtDurationFrom: UITextField!
    @IBOutlet weak var txtDurationTo: UITextField!
    
    @IBOutlet weak var btnGenerate: UIButton!
    
    @IBOutlet weak var serviceRadioBtn: DLRadioButton!
   
    @IBOutlet weak var partRadioBtn: DLRadioButton!
    
    var dateChoseView:DatePickerView?
    var pickerView:PickerView?
    var dealerIdArray:[String] = []
    var searchCritera : ReportSearchCriteriaModel?
   
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getDealerIds();
        searchCritera = ReportSearchCriteriaModel()

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
        
//        dateChoseView = DatePickerView.init(frame:CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.height), onView: self.view)
//        self.view.addSubview(dateChoseView!)
//        
//        pickerView = PickerView.init(frame:CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.height), onView: self.view)
//        //传入要选择的数据
//        pickerView?.dealerIds = dealerIdArray
//        self.view.addSubview(pickerView!)
        
    }
    
   
    @IBAction func dealerIdBtnClick(_ sender: UIButton) {
//        pickerView?.showView()
//        pickerView?.pickerDidChange {
//            (dealerId :String )  in
//            self.txtDealerId.text = dealerId
//    }
        
        ActionSheetStringPicker.show(withTitle: "DealerId", rows: dealerIdArray, initialSelection: 1, doneBlock: {
            picker, value, index in
            
            print("value = \(value)")
            print("index = \(String(describing: index))")
            print("picker = \(String(describing: picker))")
            self.txtDealerId.text = self.dealerIdArray[value]
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
}
    
    @IBAction func dateFromBtnClick(_ sender: UIButton) {
        
        let datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date!, doneBlock: {
                        picker, value, index in
            
                        print("value = \(String(describing: value))")
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
                        let from = dateFormatter.string(from: value as! Date)
                        self.txtDurationFrom.text = from;
            
                        return
                    }, cancel: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
                    let secondsInyear: TimeInterval = 365 * 24 * 60 * 60*5;
                    datePicker?.minimumDate = NSDate(timeInterval: -secondsInyear, since: NSDate() as Date) as Date!
                    datePicker?.maximumDate = NSDate(timeInterval: secondsInyear, since: NSDate() as Date) as Date!
                    
                    datePicker?.show()


    }
    @IBAction func dateToBtnClick(_ sender: UIButton) {
        let datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date!, doneBlock: {
            picker, value, index in
            print("value = \(String(describing: value))")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
            let to = dateFormatter.string(from: value as! Date)
            self.txtDurationTo.text = to
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
        let secondsInyear: TimeInterval = 365 * 24 * 60 * 60*5;
        datePicker?.minimumDate = NSDate(timeInterval: -secondsInyear, since: NSDate() as Date) as Date!
        datePicker?.maximumDate = NSDate(timeInterval: secondsInyear, since: NSDate() as Date) as Date!
        datePicker?.show()
        
    }
    @IBAction func generateBtnClick(_ sender: Any) {
        let id = txtDealerId.text ?? ""
        let from = txtDurationFrom.text ?? ""
        let to = txtDurationTo.text ?? ""
        guard !id.isEmpty else {
            AlertView_show("Error", message: "Please select a DealerId")
            txtDealerId.becomeFirstResponder()
            return
        }
        guard !from.isEmpty else {
            AlertView_show("Error", message: "Please select from date")
            txtDurationFrom.becomeFirstResponder()
            return
        }
        guard !to.isEmpty else {
            AlertView_show("Error", message: "Please select to date")
            txtDurationTo.becomeFirstResponder()
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm:ss"


        searchCritera?.DealerId = id
        searchCritera?.DealerName = ""
        searchCritera?.DurationFrom = from
        searchCritera?.durationTo  = to
            
        self.performSegue(withIdentifier: "ToGenerate2Report", sender: nil);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for:segue, sender: sender)
        guard let reportViewController = segue.destination as? ReportsViewController else{
            fatalError("Unexpected destination:\(segue.destination)")
        }

        reportViewController.searchCriteria = self.searchCritera!
    }

    
    private func getDealerIds(){
        let parameters : Parameters = ["marketId": 1]
        let token = UserDefaults.standard.string(forKey: TOKEN)
        
        AFWrapper.getDealerByMartketId(GetDealerIdByMarketId_URL,params: parameters,token: token!,success: {(dealerIds) -> Void in
            guard dealerIds != nil  else{
                AlertView_show("Error", message: "System erro, Please contact support")
                return
            }

            guard ((dealerIds?.count)! > 0) else {
                AlertView_show("Error", message: "System error, Please contact support")
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
