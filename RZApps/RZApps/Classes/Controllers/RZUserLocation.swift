//
//  RZUserLocation.swift
//  RZApps
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/16/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreData

class RZUserLocation: RZBaseView, GMSMapViewDelegate {
    var rzCoreUser = RZUsers()
    var mapView:GMSMapView!
    var originLat : CLLocationDegrees = 0.0
    var originLng : CLLocationDegrees = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InitialLoadings()
    }
    
    func InitialLoadings () {
        self.NavigationControllerSetup()
        self.title = RZ_Constant.AZ_App.APPLICATION_NAME
        self.navigationController?.delegate = self
        
        self.CheckCoordinate()
    }
    func CheckCoordinate () {
        //self.originLat = 6.881136
        //self.originLng = 79.857949
        let lat = Double(self.rzCoreUser.user_lat!)
        let lng = Double(self.rzCoreUser.user_lng!)

        self.originLat = lat!
        self.originLng = lng!
        
        self.LoadMapWithCurrentLocation()
    }

    func LoadMapWithCurrentLocation () {
        let camera = GMSCameraPosition.camera(withLatitude: self.originLat, longitude: self.originLng, zoom: 15)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.mapType = .normal
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        view = mapView
     
        let when = DispatchTime.now() + 0.01
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.LoadAnnotationView(latitude: self.originLat, longitude: self.originLng)
        }
    }
    
    func LoadAnnotationView (latitude : CLLocationDegrees, longitude : CLLocationDegrees) {
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: coordinates)
        marker.map = mapView
        //marker.icon = UIImage(named: "location")
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: -0.1)
        
        marker.title = self.rzCoreUser.user_name
        marker.snippet = self.rzCoreUser.user_city
    }

}

extension RZUserLocation: UINavigationControllerDelegate {
    
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
