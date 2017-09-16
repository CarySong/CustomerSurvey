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
    
    class func Login(_ strURL : String, userId: String, password: String, success:@escaping (PostReturnModel?) -> Void, failure:@escaping (Error) -> Void){
        
        let credentialData = "\(userId):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        Alamofire.request(strURL, method: .post, parameters: nil,  headers: headers).responseString { (response) -> Void in
            
            switch(response.result) {
            case .success(_):
                let model = PostReturnModel.deserialize(from: response.value)
                success(model)
            case .failure(_):
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }

    class func postReportGeneration(_ strURL : String, params : Parameters?,token: String, success:@escaping (ReportResultModel) -> Void, failure:@escaping (Error) -> Void){
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

    
    class func getDealerByMartketId(_ strURL: String,params : Parameters?,token: String, success:@escaping ([DealerIdModel]?) -> Void, failure:@escaping (Error) -> Void) {
        
         let header : HTTPHeaders = [ "Authorization" : token]
        
         Alamofire.request(strURL, method:.get, parameters: params,encoding: URLEncoding.default,headers:header).responseString{ (response) -> Void in
            switch response.result {
            case .success:
                let dealerIds = [DealerIdModel].deserialize(from: response.value)
                success(dealerIds as? [DealerIdModel])
            case .failure:
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }

    class func getDealerValidation(_ strURL: String,params : Parameters?,token: String, success:@escaping (PostReturnModel?) -> Void, failure:@escaping (Error) -> Void) {
        
        let header : HTTPHeaders = [ "Authorization" : token]
        
        Alamofire.request(strURL, method:.get, parameters: params,encoding: URLEncoding.default,headers:header).responseString{ (response) -> Void in
            switch response.result {
            case .success:
                let returnModel = PostReturnModel.deserialize(from: response.value)
                success(returnModel)
            case .failure:
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }

    class func postUpdateSurvey(_ strURL : String, params : Parameters?,token: String, success:@escaping (PostReturnModel?) -> Void, failure:@escaping (Error) -> Void){
        let header : HTTPHeaders = [ "Authorization" : token]
        
        Alamofire.request(strURL, method:.post, parameters: params,encoding: JSONEncoding.default,headers:header).responseString{ (response) -> Void in
            
            switch(response.result) {
            case .success(_):
                let model = PostReturnModel.deserialize(from: response.value)
                success(model)
            case .failure(_):
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }
    

}
