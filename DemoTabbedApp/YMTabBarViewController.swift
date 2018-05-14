//
//  YMTabBarViewController.swift.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/4/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

class YMTabBarViewController : UIViewController, YMTabBarTabEventDelegate {
	private let displayView: UIView
	private let tabDelegates : [YMTabBarTabViewDelegate]
	private var tabBarView = YMTabBarView()
	internal var currentSelectedTab : YMTabBarTab!

	required init(tabDelegates : [YMTabBarTabViewDelegate], displayView: UIView) {
		self.tabDelegates = tabDelegates
		self.displayView = displayView
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder : NSCoder) {
		self.tabDelegates = []
		self.displayView = UIView()
		super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		// Add the tabbarView to the view
		view = tabBarView
		tabBarView.anchor(top: view.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor)

		// Add the tabs
		for delegate in self.tabDelegates {
			tabBarView.addTab(eventDelegate: self, viewDelegate: delegate)
		}
		
		currentSelectedTab = tabBarView.tabs.first
		currentSelectedTab.isSelected = true
	}

	override func viewWillAppear(_ animated: Bool) {
		// Show the initial viewController's view
		displayView.insertSubview(currentSelectedTab.uiViewController.view, belowSubview: tabBarView.superview!)
	}

	internal func toggleSelect(tab : YMTabBarTab) {
		tab.isSelected = !tab.isSelected
	}

	internal func tabSelect(tab : YMTabBarTab) {
		animate(from: currentSelectedTab, to: tab)
		currentSelectedTab = tab
	}

	private func animate(from fromTab: YMTabBarTab, to toTab : YMTabBarTab) {
		// Update the tabbed view controller's content
		fromTab.uiViewController.view.removeFromSuperview()
		fromTab.uiViewController.removeFromParentViewController()

		displayView.insertSubview(toTab.uiViewController.view, belowSubview: tabBarView.superview!)
		parent?.addChildViewController(toTab.uiViewController)

		// Update the tabs
		fromTab.isSelected = false
		toTab.isSelected = true
	}
}
