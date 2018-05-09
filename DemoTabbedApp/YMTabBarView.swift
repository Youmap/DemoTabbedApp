//
//  YMTabBarView.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/7/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

class YMTabBarTab : UIButton {

	private let tabBarViewController : YMTabBarViewController
	private let tabbedViewController : YMTabbedViewController

	init(tabBarViewController : YMTabBarViewController, tabbedViewController : YMTabbedViewController) {
		self.tabBarViewController = tabBarViewController
		self.tabbedViewController = tabbedViewController

		super.init(frame: .zero)

		self.setImage(tabbedViewController.normalIcon, for: .normal)
		self.setImage(tabbedViewController.highlightedIcon, for: .highlighted)
		self.setImage(tabbedViewController.selectedIcon, for: .selected)
		self.setImage(tabbedViewController.disabledIcon, for: .disabled)
		self.addTarget(self, action: #selector(handleTabSelect), for: .touchUpInside)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc internal func handleTabSelect() {
		// Tell the tabbar viewcontroller this tab was selected
		tabBarViewController.tabSelect(tab: self)
	}
	
	override var intrinsicContentSize: CGSize { get { return CGSize(width: 48.0, height: 48.0) } }
	
	override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
		return CGRect(origin: .zero, size: intrinsicContentSize)
	}
}

class YMTabBarView : UIView {
	internal var tabs : [YMTabBarTab] = []
	private let stackView : UIStackView = {
		let stack = UIStackView(frame: .zero)
		stack.axis = .horizontal
		stack.distribution = .equalCentering
		stack.spacing = 10.0
		return stack
	}()

	init() {
		super.init(frame: .zero)
		addSubview(stackView)
		stackView.anchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor,
			paddingRight: 10, paddingLeft: 10)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	internal func addTab(tabBarViewController : YMTabBarViewController, tabbedViewController : YMTabbedViewController) {
		let tab = YMTabBarTab(tabBarViewController: tabBarViewController, tabbedViewController: tabbedViewController)
		tabs.append(tab)
let hue = CGFloat(arc4random_uniform(100)) / 100.0
tab.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
		stackView.addArrangedSubview(tab)
		tab.anchor(top: stackView.topAnchor, paddingTop: 10.0)
	}
}
