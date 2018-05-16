//
//  RZCommentModel.swift
//  RZApps
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/16/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit

class RZCommentModel: NSObject {

    var comm_id: Int!
    var comm_postid: Int!
    var comm_name: String!
    var comm_email: String!
    var comm_body: String!
    
    class func GetCommentInfo( eComment : [AnyHashable: Any]) -> RZCommentModel{
        
        let commentRZ  = RZCommentModel()
        
        if let commid = eComment["id"] as? Int{
            commentRZ.comm_id = commid
        }
        if let commmpostid = eComment["postId"] as? Int{
            commentRZ.comm_postid = commmpostid
        }
        if let commname = eComment["name"] as? String{
            commentRZ.comm_name = commname
        }
        if let commemail = eComment["email"] as? String{
            commentRZ.comm_email = commemail
        }
        if let commbody = eComment["body"] as? String{
            commentRZ.comm_body = commbody
        }
        return commentRZ
    }
    
}
