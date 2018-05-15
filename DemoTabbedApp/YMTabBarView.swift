//
//  YMTabBarView.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/7/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

protocol YMTabBarTabViewDelegate {
	var normalIcon : UIImage { get }
	var highlightedIcon : UIImage { get }
	var selectedIcon : UIImage { get }
	var disabledIcon : UIImage { get }
	var intrinsicContentSize : CGSize { get }
	var uiViewController : UIViewController { get }
	var isToggle : Bool { get }
	var toggleState : Bool { get set }
}

protocol YMTabBarTabEventDelegate {
	func tabSelect(tab : YMTabBarTab)
	func toggleSelect(tab : YMTabBarTab)
}

extension YMTabBarTabEventDelegate {
	func tabSelect(tab : YMTabBarTab) {
	}

	func toggleSelect(tab : YMTabBarTab) {
	}
}

class YMTabBarTab : UIButton {

	internal static let tabBarHeight = CGFloat(60)

	private let eventDelegate : YMTabBarTabEventDelegate
	internal var viewDelegate : YMTabBarTabViewDelegate

	init(eventDelegate : YMTabBarTabEventDelegate, viewDelegate : YMTabBarTabViewDelegate) {
		self.eventDelegate = eventDelegate
		self.viewDelegate = viewDelegate

		super.init(frame: .zero)

		self.setImage(viewDelegate.normalIcon, for: .normal)
		self.setImage(viewDelegate.highlightedIcon, for: .highlighted)
		self.setImage(viewDelegate.selectedIcon, for: .selected)
		self.setImage(viewDelegate.disabledIcon, for: .disabled)
		self.addTarget(self, action: #selector(handleTabSelect), for: .touchUpInside)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override var intrinsicContentSize: CGSize { get { return viewDelegate.intrinsicContentSize } }

	override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
		let top = (YMTabBarTab.tabBarHeight - intrinsicContentSize.height) / 2.0
		let origin = CGPoint(x: 0.0, y: top)
		return CGRect(origin: origin, size: intrinsicContentSize)
	}

	@objc internal func handleTabSelect() {
		if viewDelegate.isToggle {
			eventDelegate.toggleSelect(tab: self)
		}
		else {
			eventDelegate.tabSelect(tab: self)
		}
	}

	internal var uiViewController : UIViewController { get { return viewDelegate.uiViewController }}
}

class YMTabBarView : UIView {
	internal var tabs : [YMTabBarTab] = []
	private let stackView : UIStackView = {
		let stack = UIStackView(frame: .zero)
		stack.axis = .horizontal
		stack.distribution = .equalCentering
		return stack
	}()

	init() {
		super.init(frame: .zero)
		addSubview(stackView)
		stackView.anchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor,
			paddingRight: 20, paddingLeft: 20)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	internal func addTab(eventDelegate : YMTabBarTabEventDelegate, viewDelegate : YMTabBarTabViewDelegate) {
		let tab = YMTabBarTab(eventDelegate: eventDelegate, viewDelegate: viewDelegate)
		tabs.append(tab)
		stackView.addArrangedSubview(tab)
		tab.anchor(top: stackView.topAnchor)
	}
}
