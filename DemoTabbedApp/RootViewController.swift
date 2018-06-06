//
//  ViewController.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/4/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

	var tabBarViewController : YMTabBarViewController!

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		// Create a background view that contains the tabbar.
		let backgroundTabBarContainer = UIView()
		view.addSubview(backgroundTabBarContainer)
		let tabBarHeight = CGFloat(60)
		let safeZoneHeight = CGFloat(44)
		backgroundTabBarContainer.anchor(right: view.rightAnchor, bottom: safeBottomAnchor, left: view.leftAnchor, paddingBottom: -safeZoneHeight, height: tabBarHeight + safeZoneHeight)

		let gradientImage = UIImage(named: "tabBarBackgroundGradient")
		let backgroundGradientView = UIImageView(image: gradientImage)
		backgroundTabBarContainer.addSubview(backgroundGradientView)
		backgroundGradientView.anchor(right: view.rightAnchor, bottom: safeBottomAnchor, left: view.leftAnchor, paddingBottom: -safeZoneHeight, height: tabBarHeight + safeZoneHeight + 16)

		// Create the tab buttons for the tab bar.
		let tabButtons : [YMTabBarTabButton] = [MainMapTab(), DiscoveryTab(), PostButton(), NoticationsTab(), ProfileTab()]

		// Create the TabBar View Controller. Populate it with the tab buttons.
		tabBarViewController = YMTabBarViewController(tabButtons: tabButtons, contentDisplayView: self.view)
		backgroundTabBarContainer.addSubview(tabBarViewController.view)

		// Position the tabbar anchor to the top of the tabbar container
		tabBarViewController.view.anchor(top: backgroundTabBarContainer.topAnchor, right: backgroundTabBarContainer.rightAnchor, left: backgroundTabBarContainer.leftAnchor, height: tabBarHeight)

		// Add the tabbar view to the RootViewController's view
		self.addChildViewController(tabBarViewController)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
