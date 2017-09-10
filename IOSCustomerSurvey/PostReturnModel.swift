//
//  PostReturnModel.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/4.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import Foundation
import HandyJSON

class PostReturnModel : HandyJSON{
    var StatusCode: String?
    var Message: String?
    var LanguageCode: String?
    var Authorization: String?
    required init() {}
}

