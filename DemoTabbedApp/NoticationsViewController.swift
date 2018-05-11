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
 		let iconName = "notificationIcon"
		guard let icon = UIImage(named: iconName) else {
			fatalError("\(iconName) is missing from Assets")
		}
   	super.init(normalIcon: icon, highlightedIcon: icon, selectedIcon: icon, disabledIcon: icon)
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
