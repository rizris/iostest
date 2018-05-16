//
//  RZPostModel.swift
//  RZApps
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/15/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit

class RZPostModel: NSObject {

    var post_id: Int!
    var post_userid: Int!
    var post_title: String!
    var post_body: String!
    
    
    class func GetPostInfo( ePost : [AnyHashable: Any]) -> RZPostModel{
        
        let postRZ  = RZPostModel()
        
        if let postid = ePost["id"] as? Int{
            postRZ.post_id = postid
        }
        if let postuserid = ePost["userId"] as? Int{
            postRZ.post_userid = postuserid
        }
        if let posttitle = ePost["title"] as? String{
            postRZ.post_title = posttitle
        }
        if let postbody = ePost["body"] as? String{
            postRZ.post_body = postbody
        }
        return postRZ
    }
    
    
}
