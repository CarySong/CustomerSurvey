//
//  PickerView.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/8.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import UIKit

class PickerView: UIView,UIPickerViewDataSource, UIPickerViewDelegate{
    
    //定义一个闭包
    typealias dataPickerDidChange = (String) -> ()
    var picker : UIPickerView!
    var dealerIds : [String]!
    var viewH:CGFloat = 300.00
    var didChange:dataPickerDidChange?
    
    init(frame: CGRect,onView:UIView) {
        super.init(frame: frame)
        viewH = frame.size.height/3
        self.frame = CGRect(x: 0, y: onView.frame.size.height, width: onView.frame.size.width, height: viewH)
        self.backgroundColor = UIColor.gray
        self.alpha = 0.5
    
        let bottomView = UIView(frame: CGRect(x: 0, y: 0, width: onView.frame.size.width, height: 40))
        bottomView.backgroundColor = UIColor.white
        self.addSubview(bottomView)
        
        let leftButton:UIButton = UIButton.init(type: UIButtonType.system)
        leftButton.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        leftButton.setTitle("Cancel", for: UIControlState.normal)
        leftButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        leftButton.tag = 0
        leftButton.addTarget(self, action: #selector(btnClick(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(leftButton)
        
        let rightButton:UIButton = UIButton.init(type: UIButtonType.system)
        rightButton.frame = CGRect(x: onView.frame.size.width-80, y:0 , width: 80, height: 40)
        rightButton.setTitle("Confirm", for: UIControlState.normal)
        rightButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        rightButton.tag = 1
        rightButton.addTarget(self, action:#selector(btnClick(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(rightButton)

        picker = UIPickerView()
        picker.frame = CGRect(x: 0, y: 40, width: onView.frame.size.width, height: viewH-40)
        picker.backgroundColor = UIColor.white
        picker.dataSource = self
        picker.delegate = self
        self.addSubview(picker)
    }
    func btnClick(sender : UIButton){
        if sender.tag == 1 {
            let index = picker.selectedRow(inComponent: 0)
            print(dealerIds[index])
            didChange?(String(describing: dealerIds[index]))
        }
        self.hideView()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dealerIds.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dealerIds[row]
    }
    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int, inComponent component: Int) {
       
        didChange?(String(describing: dealerIds[row]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

}

