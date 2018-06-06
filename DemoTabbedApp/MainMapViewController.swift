//
//  MainMapViewController.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/4/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

class MainMapTab : YMTabBarTab {
	init() {
		super.init(tabDelegate: MainMapTabDelegate())
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError(#function + "init(coder:) has not been implemented")
	}
}

class MainMapTabDelegate : YMTabBarTabButtonDelegateBase {

	init() {
		let normalIconName = "homeIcon"
		guard let normalIcon = UIImage(named: normalIconName) else {
			fatalError("\(normalIconName) is missing from Assets")
		}
		let selectedIconName = "home-selected"
		guard let selectedIcon = UIImage(named: selectedIconName) else {
			fatalError("\(selectedIconName) is missing from Assets")
		}
    	super.init(normalIcon: normalIcon, highlightedIcon: normalIcon, selectedIcon: selectedIcon, disabledIcon: normalIcon,
			tabbedContentViewController: MainMapViewController())
	}
}

class MainMapViewController : UIViewController {
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
