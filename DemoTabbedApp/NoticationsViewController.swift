//
//  NoticationsViewController.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/4/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

class NoticationsViewController : YMTabbedViewController {
	
	init() {
		let normalIconName = "notificationIcon"
		guard let normalIcon = UIImage(named: normalIconName) else {
			fatalError("\(normalIconName) is missing from Assets")
		}
		let selectedIconName = "notificationIcon"
		guard let selectedIcon = UIImage(named: selectedIconName) else {
			fatalError("\(selectedIconName) is missing from Assets")
		}
    	super.init(normalIcon: normalIcon, highlightedIcon: normalIcon, selectedIcon: selectedIcon, disabledIcon: normalIcon)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		view.backgroundColor = .cyan
	}
	
	override func viewWillAppear(_ animated: Bool) {
	}
}
