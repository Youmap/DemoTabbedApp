//
//  YMTabBarViewController.swift.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/4/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

class YMTabBarViewController : UIViewController, YMTabBarTabEventDelegate {
	private let tabDelegates : [YMTabBarTabViewDelegate]

	private var currentSelectedTab : YMTabBarTab!

	required init(tabDelegates : [YMTabBarTabViewDelegate]) {
		self.tabDelegates = tabDelegates
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder : NSCoder) {
		self.tabDelegates = []
		super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		// Create the tabbar
		let tabBarView = YMTabBarView()

		// Add it to the view
		view = tabBarView
		tabBarView.anchor(top: view.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor)

		// Add the tabs
		for delegate in self.tabDelegates {
			tabBarView.addTab(eventDelegate: self, viewDelegate: delegate)
		}
		
		currentSelectedTab = tabBarView.tabs.first
	}

	override func viewWillAppear(_ animated: Bool) {
		show(uiViewController: currentSelectedTab.uiViewController)
	}

	private func show(uiViewController: UIViewController) {
	}

	internal func tabSelect(tab : YMTabBarTab) {
		animate(from: currentSelectedTab, to: tab)
		currentSelectedTab = tab
	}

	private func animate(from fromTab: YMTabBarTab, to toTab : YMTabBarTab) {
//		toTab.tabbedViewController.uiViewController.dismiss(animated: true, completion: nil)
print("self.parent = \(self.parent.debugDescription)")
//		self.parent?.present(fromTab.tabbedViewController.uiViewController, animated: true, completion: nil)
	}
}
