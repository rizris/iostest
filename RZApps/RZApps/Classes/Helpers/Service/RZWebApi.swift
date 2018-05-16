//
//  RZWebApi.swift
//  RZApps
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/15/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit
import Alamofire

class RZWebApi: NSObject {
    
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    //Post section
    
    class func GetAllPosts(withData postDict: [AnyHashable: Any], withCallback callback: @escaping (_ success : Bool, _ message: String, _ ResponseDict: Array<Any>) -> Void) {
        if !isConnectedToInternet(){
            let anArray = Array<Any>()
            callback(false, RZ_Message.RZGeneral.NO_INTERNET_CONNECTION, anArray)
            return;
        }
        
        let aURL = "\(RZ_Constant.AZ_App.BASE_URL)posts"
        
        Alamofire.request(aURL, method: HTTPMethod.get, parameters: postDict as? Parameters).responseJSON { response in
            let anArray = Array<Any>()
            //print(response.result.value!)
            if response.response?.statusCode  == 200 {
                var postModel = [RZPostModel]()
                if let jsonDict = response.result.value as? Array<Any>  {
                    for ePost in jsonDict as [AnyObject] {
                        let postInfo = RZPostModel.GetPostInfo(ePost: ePost as! [AnyHashable: Any])
                        postModel.append(postInfo)
                    }
                    callback(true, "", postModel)
                }else{
                    callback(false, RZ_Message.RZGeneral.PLEASE_TRY_AGAIN, anArray)
                }
            }else{
                callback(false, RZ_Message.RZGeneral.PLEASE_TRY_AGAIN, anArray)
            }
        }
    }
    
    //User section
    
    class func GetAllUsers(withData userDict: [AnyHashable: Any], withCallback callback: @escaping (_ success : Bool, _ message: String, _ ResponseDict: Array<Any>) -> Void) {
        if !isConnectedToInternet(){
            let anArray = Array<Any>()
            callback(false, RZ_Message.RZGeneral.NO_INTERNET_CONNECTION, anArray)
            return;
        }
        let aURL = "\(RZ_Constant.AZ_App.BASE_URL)users"
        
        Alamofire.request(aURL, method: HTTPMethod.get, parameters: userDict as? Parameters).responseJSON { response in
            let anArray = Array<Any>()
            //print(response.result.value!)
            if response.response?.statusCode  == 200 {
                var userModel = [RZUserModel]()
                if let jsonDict = response.result.value as? Array<Any>  {
                    for eUser in jsonDict as [AnyObject] {
                        let postInfo = RZUserModel.GetUserInfo(eUser: eUser as! [AnyHashable: Any])
                        userModel.append(postInfo)
                    }
                    callback(true, "", userModel)
                }else{
                    callback(false, RZ_Message.RZGeneral.PLEASE_TRY_AGAIN, anArray)
                }
            }else{
                callback(false, RZ_Message.RZGeneral.PLEASE_TRY_AGAIN, anArray)
            }
        }
    }
    
    //Comment section

    class func GetAllComments(withData commentDict: [AnyHashable: Any], withCallback callback: @escaping (_ success : Bool, _ message: String, _ ResponseDict: Array<Any>) -> Void) {
        if !isConnectedToInternet(){
            let anArray = Array<Any>()
            callback(false, RZ_Message.RZGeneral.NO_INTERNET_CONNECTION, anArray)
            return;
        }
        let aURL = "\(RZ_Constant.AZ_App.BASE_URL)comments"
        
        Alamofire.request(aURL, method: HTTPMethod.get, parameters: commentDict as? Parameters).responseJSON { response in
            let anArray = Array<Any>()
            //print(response.result.value!)
            if response.response?.statusCode  == 200 {
                var commentModel = [RZCommentModel]()
                if let jsonDict = response.result.value as? Array<Any>  {
                    for eComment in jsonDict as [AnyObject] {
                        let commentInfo = RZCommentModel.GetCommentInfo(eComment: eComment as! [AnyHashable: Any])
                        commentModel.append(commentInfo)
                    }
                    callback(true, "", commentModel)
                }else{
                    callback(false, RZ_Message.RZGeneral.PLEASE_TRY_AGAIN, anArray)
                }
            }else{
                callback(false, RZ_Message.RZGeneral.PLEASE_TRY_AGAIN, anArray)
            }
        }
    }
}
