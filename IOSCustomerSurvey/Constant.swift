//
//  Constant.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/4.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

let BASE_URL = "Https://www.gtacustomersurvey.com:443/api/";
let Login_URL = BASE_URL+"Login";
let ReportStatistic_URL = BASE_URL + "CustomerSurvey/ServiceReportStatistic"
let GetDealerIdByMarketId_URL = BASE_URL + "Dealer/List";
let Registration_URL = BASE_URL + "Dealer"
let GetDealerIdValidtion = BASE_URL + "Dealer/DealerExist"
let PostUpdatePartsSurvey = BASE_URL + "CustomerSurvey/Parts"
let PostUpdateServiceSurvey = BASE_URL + "CustomerSurvey/Service"



let TOKEN = "Authorization"


var screenWidth:CGFloat {
    return UIScreen.main.bounds.width
}

var screenHeight:CGFloat {
    return UIScreen.main.bounds.height
}



let mylableSize = 15//设置常用字体大小为16
let mycommonEdge:CGFloat = 13//lable上下左右编剧
let bordertopbottom:CGFloat = 4 //borderview的上下编剧
let commonCellHeight = CGFloat(37.0 + 6)//常用tableCell的高度

let popViewH = CGFloat(23)//底部弹窗view的高度
let listlitalImgW:CGFloat = 18//列表小图标的宽度
let commontextViewHeight = commonCellHeight  - bordertopbottom*2 //通用textView的高度
let listimglablegap:CGFloat = 5//列表小图标的宽度

