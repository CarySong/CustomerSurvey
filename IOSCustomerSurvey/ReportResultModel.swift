//
//  ReportResultModel.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/6.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import Foundation
import HandyJSON

class ReportResultModel : HandyJSON{
    var PartsWaitng: [Int]?
    var PartsAvailability: [Int]?
    var PartsOverall: [Int]?
    var ServiceCheckIn: [Int]?
    var ServiceDeliveryOnTim: [Int]?
    var ServiceOverall: [Int]?
    required init() {}
}
