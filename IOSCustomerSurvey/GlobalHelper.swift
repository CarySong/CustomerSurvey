//
//  GlobalHelper.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/15.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import Foundation
import UIKit

func AlertView_show(_ title: String, message: String? = nil) {
    var theMessage = ""
    if message != nil {
        theMessage = message!
    }
    
    let alertView = UIAlertView(title: title , message: theMessage, delegate: nil, cancelButtonTitle: "OK")
    alertView.show()
}
