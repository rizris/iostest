//
//  RZBaseView.swift
//  RZApps
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/15/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit
import CoreData
import HexColors
import NVActivityIndicatorView

class RZBaseView: UIViewController, NVActivityIndicatorViewable {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    func StartActivityAnimating () {
        let size = CGSize(width: 30, height: 30)
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: 32)!)
    }
    
    func StopActicityAnimating () {
        self.stopAnimating()
    }

    func saveContext () {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.saveContext()
    }
    
    func SavePostData(rzPostModel: RZPostModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let aPostObject = NSEntityDescription.insertNewObject(forEntityName: "RZPosts", into: managedObjectContext) as! RZPosts
        
        aPostObject.postid = Int32(rzPostModel.post_id)
        aPostObject.postuserid = Int32(rzPostModel.post_userid)
        aPostObject.posttitle = rzPostModel.post_title
        aPostObject.postbody = rzPostModel.post_body
        
        self.saveContext()
    }
    
    func SaveUserData(rzUserModel: RZUserModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let aUserObject = NSEntityDescription.insertNewObject(forEntityName: "RZUsers", into: managedObjectContext) as! RZUsers
        
        aUserObject.user_id = Int32(rzUserModel.user_id)
        aUserObject.user_name = rzUserModel.user_name
        aUserObject.user_username = rzUserModel.user_username
        aUserObject.user_email = rzUserModel.user_email
        aUserObject.user_street = rzUserModel.user_street
        aUserObject.user_suite = rzUserModel.user_suite
        aUserObject.user_city = rzUserModel.user_city
        aUserObject.user_zipcode = rzUserModel.user_zipcode
        aUserObject.user_lat = rzUserModel.user_lat
        aUserObject.user_lng = rzUserModel.user_lng
        aUserObject.user_phone = rzUserModel.user_phone
        aUserObject.user_web = rzUserModel.user_website
        aUserObject.user_companyname = rzUserModel.user_companyname
        aUserObject.user_catchphrase = rzUserModel.user_catchPhrase
        aUserObject.user_bs = rzUserModel.user_bs
        
        self.saveContext()
    }
    
    func SaveCommentData(rzCommentModel: RZCommentModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let aCommentbject = NSEntityDescription.insertNewObject(forEntityName: "RZComments", into: managedObjectContext) as! RZComments
        
        aCommentbject.commid = Int32(rzCommentModel.comm_id)
        aCommentbject.commpostid = Int32(rzCommentModel.comm_postid)
        aCommentbject.commname = rzCommentModel.comm_name
        aCommentbject.commemail = rzCommentModel.comm_email
        aCommentbject.commbody = rzCommentModel.comm_body
        
        self.saveContext()
    }
    
    func GetSinglePostObject (postid : Int32) -> [RZPosts] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RZPosts")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "postid == %d", postid)
        do{
            let results = try appDelegate.managedObjectContext.fetch(fetchRequest)
            var dataArray = [RZPosts]()
            dataArray = results as! [RZPosts]
            return dataArray
        }catch{
            return [RZPosts]()
        }
    }
    
    func FindUserByUserid (userid : Int32) -> [RZUsers] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RZUsers")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "user_id == %d", userid)
        do{
            let results = try appDelegate.managedObjectContext.fetch(fetchRequest)
            var dataArray = [RZUsers]()
            dataArray = results as! [RZUsers]
            return dataArray
        }catch{
            return [RZUsers]()
        }
    }
    func FindCommentByCommentid (commentid : Int32) -> [RZComments] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RZComments")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "commid == %d", commentid)
        do{
            let results = try appDelegate.managedObjectContext.fetch(fetchRequest)
            var dataArray = [RZComments]()
            dataArray = results as! [RZComments]
            return dataArray
        }catch{
            return [RZComments]()
        }
    }
    
    func FetchAllPostObjects() -> [RZPosts] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RZPosts")
        do{
            let results = try appDelegate.managedObjectContext.fetch(fetchRequest)
            let datyaArray = results as! [RZPosts]
            var lyDownloadDatyaArray = [RZPosts]()
            for aDwnld in datyaArray {
                
                lyDownloadDatyaArray.append(aDwnld)
            }
            return lyDownloadDatyaArray
        }catch{
            print("Error with request: \(error)")
            return [RZPosts]()
        }
    }
    
    func FindCommentByPostid (postid : Int32) -> [RZComments] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RZComments")
        fetchRequest.predicate = NSPredicate(format: "commpostid == %d", postid)
        do{
            let results = try appDelegate.managedObjectContext.fetch(fetchRequest)
            var dataArray = [RZComments]()
            dataArray = results as! [RZComments]
            return dataArray
        }catch{
            return [RZComments]()
        }
    }
    
}
