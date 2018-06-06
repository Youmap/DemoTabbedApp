//
//  YMTabBarTabButton.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/11/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

//** The delegate required to implement for a YMTabBarTabButton.
protocol YMTabBarTabButtonDelegate {
	var normalIcon : UIImage { get }
	var highlightedIcon : UIImage { get }
	var selectedIcon : UIImage { get }
	var disabledIcon : UIImage { get }
	var intrinsicContentSize : CGSize { get }
	var tabbedContentViewController : UIViewController? { get }
}

//** The base implementation for all YMTabBarTabButtonDelegate. (It can't be a protocol extension because it contains computed properties.)
//** All YMTabBarTabButtonDelegate should inherit from this.
class YMTabBarTabButtonDelegateBase :  YMTabBarTabButtonDelegate {
	
	init(normalIcon : UIImage, highlightedIcon : UIImage, selectedIcon : UIImage, disabledIcon : UIImage, tabbedContentViewController : UIViewController? = nil) {
		_normalIcon = normalIcon
		_highlightedIcon = highlightedIcon
		_selectedIcon = selectedIcon
		_disabledIcon = disabledIcon
		_tabbedContentViewController = tabbedContentViewController
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

	var intrinsicContentSize: CGSize { get { return CGSize(width: 35.0, height: 35.0) } }

	private let _tabbedContentViewController : UIViewController?
	var tabbedContentViewController : UIViewController? { get { return _tabbedContentViewController }}
}

//** Private base class for YMTabBarTabs or YMTabBarToggles
class YMTabBarTabButton : UIButton {

	internal static let tabBarHeight = CGFloat(60)	// TODO: get this elsewhere

	internal var tabDelegate : YMTabBarTabButtonDelegate

	internal var tabBarViewController : YMTabBarViewController?
		// This must be set for the UIButton to do anything.

	fileprivate init(tabDelegate : YMTabBarTabButtonDelegate) {
		self.tabDelegate = tabDelegate

		super.init(frame: .zero)

		self.setImage(tabDelegate.normalIcon, for: .normal)
		self.setImage(tabDelegate.highlightedIcon, for: .highlighted)
		self.setImage(tabDelegate.selectedIcon, for: .selected)
		self.setImage(tabDelegate.disabledIcon, for: .disabled)
		self.addTarget(self, action: #selector(handleTabSelect), for: .touchUpInside)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError(#function + "init(coder:) has not been implemented")
	}

	override var intrinsicContentSize: CGSize { get { return tabDelegate.intrinsicContentSize } }

	override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
		let top = (YMTabBarTab.tabBarHeight - intrinsicContentSize.height) / 2.0
		let origin = CGPoint(x: 0.0, y: top)
		return CGRect(origin: origin, size: intrinsicContentSize)
	}

	internal var uiViewController : UIViewController? { get { return tabDelegate.tabbedContentViewController }}

	@objc internal func handleTabSelect() {
		fatalError(#function + " is not overridden. Sub-classes are required to implement this.")
	}

	internal func setActionTarget(tabBarViewController : YMTabBarViewController) {
		self.tabBarViewController = tabBarViewController
	}
}

//** Pubic YMTabBarTab
class YMTabBarTab : YMTabBarTabButton {
	internal override init(tabDelegate : YMTabBarTabButtonDelegate) {
		super.init(tabDelegate: tabDelegate)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError(#function + "init(coder:) has not been implemented")
	}

	@objc internal override func handleTabSelect() {
		guard let tabBarViewController = tabBarViewController else {
			fatalError(#function + "tabBarViewController")
		}
		tabBarViewController.handleTabSelect(tab: self)
	}
}

//** Pubic YMTabBarToggle
class YMTabBarToggle : YMTabBarTabButton {
	internal override init(tabDelegate : YMTabBarTabButtonDelegate) {
		super.init(tabDelegate: tabDelegate)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError(#function + "init(coder:) has not been implemented")
	}

	@objc internal override func handleTabSelect() {
		guard let tabBarViewController = tabBarViewController else {
			fatalError(#function + "tabBarViewController")
		}
		tabBarViewController.handleToggleSelect(tab: self)
	}

	private var _toggleState : Bool = false
	var toggleState : Bool {
		get {
			return _toggleState
		}

		set {
			_toggleState = newValue
		}
	}
}
