//
//  DiscoveryViewController.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/4/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

class DiscoveryTab : YMTabBarTab {
	init() {
		super.init(tabDelegate: DiscoveryTabDelegate())
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError(#function + "init(coder:) has not been implemented")
	}
}

class DiscoveryTabDelegate : YMTabBarTabButtonDelegateBase {

	init() {
		let normalIconName = "compassIcon"
		guard let normalIcon = UIImage(named: normalIconName) else {
			fatalError("\(normalIconName) is missing from Assets")
		}
		let selectedIconName = "compass-selected"
		guard let selectedIcon = UIImage(named: selectedIconName) else {
			fatalError("\(selectedIconName) is missing from Assets")
		}
    	super.init(normalIcon: normalIcon, highlightedIcon: normalIcon, selectedIcon: selectedIcon, disabledIcon: normalIcon,
			tabbedContentViewController: DiscoveryViewController())
	}
}

class DiscoveryViewController : UIViewController {
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		view.backgroundColor = .magenta
	}

	override func viewWillAppear(_ animated: Bool) {
	}
}
