//
//  AFWrapper.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/4.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AFWrapper: NSObject {
    
    class func Login(_ strURL : String, userId: String, password: String, success:@escaping (PostReturnModel) -> Void, failure:@escaping (Error) -> Void){
        
        let credentialData = "\(userId):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        Alamofire.request(strURL, method: .post, parameters: nil,  headers: headers).responseString { (response) -> Void in
            
            switch(response.result) {
            case .success(_):
                let model = PostReturnModel.deserialize(from: response.value)
                success(model!)
            case .failure(_):
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }

    
    
    class func PostWithToken(_ strURL : String, params : Parameters?,token: String, success:@escaping (ReportResultModel) -> Void, failure:@escaping (Error) -> Void){
        let header : HTTPHeaders = [ "Authorization" : token]
                                     
        Alamofire.request(strURL, method:.post, parameters: params,encoding: JSONEncoding.default,headers:header).responseString{ (response) -> Void in
            
        switch(response.result) {
        case .success(_):
           let model = ReportResultModel.deserialize(from: response.value)
           success(model!)
        case .failure(_):
            let error : Error = response.result.error!
            failure(error)
            }
        }
    }
    
    class func dealerRegistration(_ strURL : String, params : Parameters?, success:@escaping (PostReturnModel) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params).responseString{ (response) -> Void in
            
            switch(response.result) {
            case .success(_):
                let model = PostReturnModel.deserialize(from: response.value)
                success(model!)
            case .failure(_):
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }

    
    
    
    class func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        Alamofire.request(strURL).validate().responseJSON { (responseObject) -> Void in
            
            switch responseObject.result {
            case .success:
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            case .failure:
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }

}
