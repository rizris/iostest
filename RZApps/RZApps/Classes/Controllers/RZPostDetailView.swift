//
//  RZPostDetailView.swift
//  RZApps
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/15/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit
import CoreData
import AlamofireImage

class RZPostDetailView: RZBaseView {

    var rzCorePost = RZPosts()
    var foundUserObject = [RZUsers]()
    var foundCommentObject = [RZComments]()
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postBody: UITextView!
    @IBOutlet weak var totalComments: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = RZ_Constant.AZ_App.APPLICATION_NAME
        self.navigationController?.delegate = self
        
        foundUserObject = self.FindUserByUserid(userid: Int32(self.rzCorePost.postuserid))
        foundCommentObject = self.FindCommentByPostid(postid: Int32(self.rzCorePost.postid))
        
        self.InitialLoadings()
        
    }

    func InitialLoadings () {
        self.NavigationControllerSetup()
        self.SetupPostView()
    }
    
    func SetupPostView () {
        self.postTitle.text = self.rzCorePost.posttitle
        self.postBody.text = self.rzCorePost.postbody
        
        self.SetupUserInfo()
        self.SetupCommetnsInfo()
    }
    
    func SetupUserInfo () {
        if foundUserObject.count != 0 {
            let rzGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GoToUserDetailView))
            self.userName.isUserInteractionEnabled = true
            self.userName.addGestureRecognizer(rzGesture)
            
            self.userName.text = foundUserObject[0].user_name
            let aUrl = "\(RZ_Constant.AZ_App.PROFILE_IMAGE_URL)\(foundUserObject[0].user_email!))"
            let imageurl = URL(string: aUrl)
            let filter = AspectScaledToFillSizeFilter(size: self.profileImage.frame.size)
            self.profileImage.contentMode = .scaleAspectFit
            self.profileImage.af_setImage(withURL: imageurl!, placeholderImage: UIImage.init(named: "placeholder"), filter: filter, completion: { (response) in
                self.profileImage.contentMode = .scaleToFill
            })
        }
    }
    func SetupCommetnsInfo () {
        if foundCommentObject.count != 0 {
            let totalComments = String(foundCommentObject.count)
            self.totalComments.text = "\(totalComments)"
        }else{
            self.totalComments.text = "0"
        }
    }

    @objc func GoToUserDetailView () {
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailView") as! RZUserDetailView
        detailView.foundUserObject = foundUserObject
        self.navigationController?.pushViewController(detailView, animated: false)
    }
    
    
    


}


extension RZPostDetailView: UINavigationControllerDelegate {
    
    func NavigationControllerSetup ()  {
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "rzBackButton"), for: .normal)
        btnLeftMenu.addTarget(self, action: #selector(BackAction), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func BackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool){
        self.navigationController?.isNavigationBarHidden = false
        navigationController.navigationBar.isTranslucent = false
        navigationController.setNeedsStatusBarAppearanceUpdate()
        navigationController.navigationBar.barTintColor = UIColor(RZ_Constant.RZ_AppColors.APP_BACKGROUND_COLOR)
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor(RZ_Constant.RZ_AppColors.HIGHLIGHT_BLUE) as Any]
        navigationController.navigationBar.tintColor = UIColor(RZ_Constant.RZ_AppColors.HIGHLIGHT_BLUE)
    }
}
