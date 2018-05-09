//
//  YMTabBarViewController.swift.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/4/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

protocol YMTabbedViewController {
	var normalIcon : UIImage { get }
	var highlightedIcon : UIImage { get }
	var selectedIcon : UIImage { get }
	var disabledIcon : UIImage { get }
	func handleViewControllerSelected()
}

class YMTabbedViewControllerBase :  UIViewController, YMTabbedViewController{
	
	init(normalIcon : UIImage, highlightedIcon : UIImage, selectedIcon : UIImage, disabledIcon : UIImage) {
		_normalIcon = normalIcon
		_highlightedIcon = highlightedIcon
		_selectedIcon = selectedIcon
		_disabledIcon = disabledIcon
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private let _normalIcon : UIImage
	var normalIcon: UIImage {
		get { return _normalIcon }
	}
	
	private let _highlightedIcon : UIImage
	var highlightedIcon: UIImage {
		get { return _highlightedIcon }
	}
	
	private let _selectedIcon : UIImage
	var selectedIcon: UIImage {
		get { return _selectedIcon }
	}
	
	private let _disabledIcon : UIImage
	var disabledIcon: UIImage {
		get { return _disabledIcon }
	}

	func handleViewControllerSelected() {
	}
}

class YMTabBarViewController : UIViewController {
	private let tabbedViewControllers : [YMTabbedViewController]

	private var currentSelectedTab : YMTabBarTab!

	required init(tabbedViewControllers : [YMTabbedViewController]) {
		self.tabbedViewControllers = tabbedViewControllers
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder : NSCoder) {
		self.tabbedViewControllers = []
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
		for vc in self.tabbedViewControllers {
			tabBarView.addTab(tabBarViewController: self, tabbedViewController: vc)
		}
	}

	func tabSelect(tab : YMTabBarTab) {
		currentSelectedTab = tab
	}
}
