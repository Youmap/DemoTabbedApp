//
//  UIView+Anchor.swift
//  SocialMeter
//
//  Created by Marc Aupont on 12/1/17.
//  Copyright © 2017 YouMap. All rights reserved.
//

import UIKit

///With this extension you can call .anchor on any view and provide its top, right, bottom and left anchors. If you dont require padding just provide 0
extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat = 0.0, paddingRight: CGFloat = 0.0, paddingBottom: CGFloat = 0.0, paddingLeft: CGFloat = 0.0, width: CGFloat = 0.0, height: CGFloat = 0.0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let right = right {
            
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let bottom = bottom {
            
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let left = left {
            
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if width != 0 {
            
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

