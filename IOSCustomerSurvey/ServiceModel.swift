//
//  ServiceModel.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/15.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import Foundation

import HandyJSON

class ServiceModel : HandyJSON{
    var DealerId: String?
    var RateOfProcess: Int?
    var IsDeliveryOnTime: Bool?
    var RateOfExperience : Float?
    var Feedback : String?
    var Customer: CustomerModel?
    required init() {}
}
