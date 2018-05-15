//
//  YMTabbedViewController.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/11/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

//** Base class for tabbed view controllers
class YMTabbedViewController :  UIViewController, YMTabBarTabViewDelegate {
	
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

	var intrinsicContentSize: CGSize { get { return CGSize(width: 35.0, height: 35.0) } }

	var uiViewController : UIViewController { get { return self }}

	var isToggle : Bool {
		get {
			return false
		}
	}

	var toggleState : Bool {
		get {
			return false
		}

		set {
		}
	}
}
