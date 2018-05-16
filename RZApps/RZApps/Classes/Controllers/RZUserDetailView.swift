//
//  RZUserDetailView.swift
//  RZApps
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/16/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit
import CoreData
import AlamofireImage
import SwiftMessages


class RZUserDetailView: RZBaseView {

    var foundUserObject = [RZUsers]()
    var rzCoreUser = RZUsers()
    //@IBOutlet weak var mapViewLocation: UIView!
    
    @IBOutlet weak var uImage: UIImageView!
    @IBOutlet weak var uName: UILabel!
    
    @IBOutlet weak var uUsername: UILabel!
    @IBOutlet weak var uEmail: UILabel!
    @IBOutlet weak var uStreet: UILabel!
    @IBOutlet weak var uCity: UILabel!
    @IBOutlet weak var uZip: UILabel!
    @IBOutlet weak var uPhone: UILabel!
    @IBOutlet weak var uWeb: UILabel!
    @IBOutlet weak var uCompanyName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = RZ_Constant.AZ_App.APPLICATION_NAME
        self.navigationController?.delegate = self

        self.InitialLoadings()
    }

    func InitialLoadings () {
        self.NavigationControllerSetup()
        if self.foundUserObject.count != 0 {
            self.rzCoreUser = foundUserObject[0]
            self.SetupUserInfor()
        }else{
            RZ_Utility.RZAlertMessages.DisplayAlertOnNavigationBar("No record found", Theme.error)
        }
    }
    
    func SetupUserInfor () {
        self.uName.text = foundUserObject[0].user_name
        let aUrl = "\(RZ_Constant.AZ_App.PROFILE_IMAGE_URL)\(foundUserObject[0].user_email!))"
        let imageurl = URL(string: aUrl)
        let filter = AspectScaledToFillSizeFilter(size: self.uImage.frame.size)
        self.uImage.contentMode = .scaleAspectFit
        self.uImage.af_setImage(withURL: imageurl!, placeholderImage: UIImage.init(named: "placeholder"), filter: filter, completion: { (response) in
            self.uImage.contentMode = .scaleToFill
        })
        
        self.uUsername.text = foundUserObject[0].user_username
        self.uEmail.text = foundUserObject[0].user_email
        self.uStreet.text = foundUserObject[0].user_street
        self.uCity.text = foundUserObject[0].user_city
        self.uZip.text = foundUserObject[0].user_zipcode
        self.uPhone.text = foundUserObject[0].user_phone
        self.uWeb.text = foundUserObject[0].user_web
        self.uCompanyName.text = foundUserObject[0].user_companyname
        
    }
    
    @IBAction func LocateUserLocation(_ sender: Any) {
        let locationView = self.storyboard?.instantiateViewController(withIdentifier: "UserLocation") as! RZUserLocation
        locationView.rzCoreUser = rzCoreUser
        self.navigationController?.pushViewController(locationView, animated: false)
    }
}


extension RZUserDetailView: UINavigationControllerDelegate {
    
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
