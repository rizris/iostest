//
//  RZ_Utility.swift
//  RZApps
//
//  Created by Abdul Hameed Mohamed Rizvi on 5/15/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit
import SwiftMessages

class RZ_Utility: NSObject {
    
    class RZAlertMessages {
        
        class func DisplayAlertOnNavigationBar(_ description : String,_ themeStyle: Theme?) {
            DispatchQueue.main.async(execute: {() -> Void in
                if description.count != 0 {
                    let aSwiftMessage = MessageView.viewFromNib(layout: .tabView)
                    aSwiftMessage.configureTheme(themeStyle!)
                    aSwiftMessage.configureContent(title: "", body: description)
                    aSwiftMessage.button?.isHidden = true
                    var aSwiftMessageConfig = SwiftMessages.defaultConfig
                    aSwiftMessageConfig.presentationStyle = .top
                    aSwiftMessageConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
                    aSwiftMessageConfig.duration = .seconds(seconds: 2.0)
                    SwiftMessages.show(config: aSwiftMessageConfig, view: aSwiftMessage)
                }
            })
        }
    }

}
