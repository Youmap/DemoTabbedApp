//
//  PostButton.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/4/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

class PostButtonViewController : YMTabbedViewController {
	init() {
		let iconName = "postButtonIcon"
		guard let icon = UIImage(named: iconName) else {
			fatalError("\(iconName) is missing from Assets")
		}
    	super.init(normalIcon: icon, highlightedIcon: icon, selectedIcon: icon, disabledIcon: icon)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override var intrinsicContentSize: CGSize { get { return CGSize(width: 60.0, height: 60.0) } }
}
