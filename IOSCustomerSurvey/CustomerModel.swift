//
//  CustomerModel.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/14.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import Foundation
import HandyJSON

class CustomerModel : HandyJSON{
    var CustomerName: String?
    var Email: String?
    var ContactNo: String?
    required init() {}
}
