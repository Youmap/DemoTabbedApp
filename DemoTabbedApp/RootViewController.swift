//
//  ViewController.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/4/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
//view.backgroundColor = .yellow

		// Create the tabbed ViewControllers to display.
		let tabbedViewControllers : [YMTabbedViewController] = [MainMapViewController(), DiscoveryViewController(), PostButtonViewController(), NoticationsViewController(), ProfileViewController()]

		// Create a background view that contains the tabbar.
		let backgroundTabBarContainer = UIView()
		view.addSubview(backgroundTabBarContainer)
		let tabBarHeight = CGFloat(60)
		let safeZoneHeight = CGFloat(44)
		backgroundTabBarContainer.anchor(right: view.rightAnchor, bottom: safeBottomAnchor, left: view.leftAnchor, paddingBottom: -safeZoneHeight, height: tabBarHeight + safeZoneHeight)
//backgroundTabBarContainer.backgroundColor = .blue

		// Create the TabBar View Controller.
		let tabbarViewController = YMTabBarViewController(tabbedViewControllers: tabbedViewControllers)
		backgroundTabBarContainer.addSubview(tabbarViewController.view)

		// Position the tabbar anchor to the top of the tabbar container
		tabbarViewController.view.anchor(top: backgroundTabBarContainer.topAnchor, right: backgroundTabBarContainer.rightAnchor, left: backgroundTabBarContainer.leftAnchor, height: tabBarHeight)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
