//
//  PostButton.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/4/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

class PostButton : YMTabBarToggle {
	init() {
		super.init(tabDelegate: PostButtonDelegate())
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError(#function + "init(coder:) has not been implemented")
	}
}

class PostButtonDelegate : YMTabBarTabButtonDelegateBase {

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
}

class PostButtonViewController : UIViewController {
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		view.backgroundColor = .red
	}

	override func viewWillAppear(_ animated: Bool) {
	}
}
