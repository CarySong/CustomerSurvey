//
//  ReportSearchCriteriaModel.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/6.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import Foundation

import HandyJSON

class ReportSearchCriteriaModel : HandyJSON{
    var DealerId: String?
    var DealerName: String?
    var DurationFrom: Date?
    var DurationTo: Date?
    
    required init()
    {    }
}
