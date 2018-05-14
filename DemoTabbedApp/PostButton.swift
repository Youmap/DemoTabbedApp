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
		let normalIconName = "postButtonIcon"
		guard let normalIcon = UIImage(named: normalIconName) else {
			fatalError("\(normalIconName) is missing from Assets")
		}
		let selectedIconName = "post-selected"
		guard let selectedIcon = UIImage(named: selectedIconName) else {
			fatalError("\(selectedIconName) is missing from Assets")
		}
    	super.init(normalIcon: normalIcon, highlightedIcon: normalIcon, selectedIcon: selectedIcon, disabledIcon: normalIcon)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override var intrinsicContentSize: CGSize { get { return CGSize(width: 60.0, height: 60.0) } }
}
