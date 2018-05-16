//
//  RZHomeView.swift
//  RZApps
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/15/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit
import CoreData
import SwiftMessages
import HexColors

class RZHomeView: RZBaseView, UINavigationControllerDelegate {
    
    @IBOutlet weak var postTableView: UITableView!
    
    var rzPostModel = [RZPostModel]()
    var rzUserModel = [RZUserModel]()
    var rzCommentModel = [RZCommentModel]()
    
    var rzCorePost = [RZPosts]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.title = RZ_Constant.AZ_App.APPLICATION_NAME
        
        self.InitialLoadings()
        self.LoadUserList()
        self.LoadCommentList()
    }

    func InitialLoadings () {
        self.postTableView.delegate = self
        self.postTableView.dataSource = self
        self.postTableView.rowHeight = UITableViewAutomaticDimension
        self.postTableView.estimatedRowHeight = 100
        
        self.LoadPostsList()
        self.rzCorePost = self.FetchAllPostObjects()
        self.postTableView.reloadData()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool){
        self.navigationController?.isNavigationBarHidden = false
        navigationController.setNeedsStatusBarAppearanceUpdate()
        navigationController.navigationBar.barTintColor = UIColor(RZ_Constant.RZ_AppColors.APP_BACKGROUND_COLOR)
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor(RZ_Constant.RZ_AppColors.HIGHLIGHT_BLUE) as Any]
        navigationController.navigationBar.tintColor = UIColor(RZ_Constant.RZ_AppColors.HIGHLIGHT_BLUE)
    }
    
    //Insert to coredata if any new POst exist
    func LoadPostsList () {
        self.StartActivityAnimating()
        let paramDict:[AnyHashable: Any] = [:]
        RZWebApi.GetAllPosts(withData: paramDict, withCallback:{(_ success : Bool, _ message: String, _ ResponseDict: Array) -> Void in
            self.StopActicityAnimating()
            if success {
                self.rzPostModel = ResponseDict as! [RZPostModel]
                for currentPost in self.rzPostModel {
                    var foundPostObject = [RZPosts]()
                    let newpostid = Int32(currentPost.post_id)
                    foundPostObject = self.GetSinglePostObject(postid: newpostid)
                    if foundPostObject.count == 0 {
                        self.SavePostData(rzPostModel: currentPost)
                        self.rzCorePost = self.FetchAllPostObjects()
                        self.postTableView.reloadData()
                    }
                }
            }else{
                RZ_Utility.RZAlertMessages.DisplayAlertOnNavigationBar(message, Theme.error)
            }
        })
    }
    //Insert to coredata if any new user exist
    func LoadUserList () {
        let paramDict:[AnyHashable: Any] = [:]
        RZWebApi.GetAllUsers(withData: paramDict, withCallback:{(_ success : Bool, _ message: String, _ ResponseDict: Array) -> Void in
            if success {
                self.rzUserModel = ResponseDict as! [RZUserModel]
                for currentUser in self.rzUserModel {
                    var foundUserObject = [RZUsers]()
                    let newuserid = Int32(currentUser.user_id)
                    foundUserObject = self.FindUserByUserid(userid: newuserid)
                    if foundUserObject.count == 0 {
                        self.SaveUserData(rzUserModel: currentUser)
                    }
                }
            }
        })
    }
    //Insert to coredata if any new comment exist
    func LoadCommentList () {
        let paramDict:[AnyHashable: Any] = [:]
        RZWebApi.GetAllComments(withData: paramDict, withCallback:{(_ success : Bool, _ message: String, _ ResponseDict: Array) -> Void in
            if success {
                self.rzCommentModel = ResponseDict as! [RZCommentModel]
                for currentComment in self.rzCommentModel {
                    var foundCommentObject = [RZComments]()
                    let newcommentid = Int32(currentComment.comm_id)
                    foundCommentObject = self.FindCommentByCommentid(commentid: newcommentid)
                    if foundCommentObject.count == 0 {
                        self.SaveCommentData(rzCommentModel: currentComment)
                    }
                }
            }
        })
    }
    
    
    
}

extension RZHomeView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rzCorePost.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.postTableView.register(UINib(nibName: "RZPostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! RZPostCell
        let singlePost = self.rzCorePost[indexPath.row] as RZPosts
        cell.ConfigurePostCell(rzCorePost: singlePost)
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let singlePost  = self.rzPostModel[indexPath.row] as RZPostModel
        let singlePost  = self.rzCorePost[indexPath.row] as RZPosts
        
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailView") as! RZPostDetailView
        //detailView.rzSinglePost = singlePost
        detailView.rzCorePost = singlePost
        self.navigationController?.pushViewController(detailView, animated: false)
    }
    
    //End of Extended class
}

