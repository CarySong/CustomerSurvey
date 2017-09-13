//
//  DealerModel.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/13.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import Foundation
import HandyJSON

class DealerModel : HandyJSON{
    var DealerId: String?
    var Name: String?
    var ContactNumber: String?
    var Email: String?
    var Password: String?
    var Address: String?
    required init() {}
}
