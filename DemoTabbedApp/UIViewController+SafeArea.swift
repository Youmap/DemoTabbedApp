//
//  UIViewController+SafeArea.swift
//  SocialMeter
//
//  Created by Marc Aupont on 2/2/18.
//  Copyright © 2018 YouMap. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.topAnchor
        } else {
            return topLayoutGuide.topAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomLayoutGuide.bottomAnchor
        }
    }
}
