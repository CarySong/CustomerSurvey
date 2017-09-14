//
//  PartsModel.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/14.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import Foundation
import HandyJSON

class PartsModel : HandyJSON{
    var DealerId: String?
    var RateOfWaitingTime: Int?
    var IsPartAvailable: Bool?
    var RateOfExperience : Float?
    var Feedback : String?
    var Customer: CustomerModel?
    required init() {}
}
