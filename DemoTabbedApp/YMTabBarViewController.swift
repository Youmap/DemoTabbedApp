//
//  YMTabBarViewController.swift.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/4/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

class YMTabBarViewController : UIViewController {
	private let contentDisplayView: UIView
		// This is the view in which to display each tabbed view's content.

	private let tabButtons : [YMTabBarTabButton]
		// The tab bar buttons.

	private var tabBarView = YMTabBarView()

	internal var currentSelectedTab : YMTabBarTabButton!
		// The currently selected tab.

	required init(tabButtons : [YMTabBarTabButton], contentDisplayView: UIView) {
		self.tabButtons = tabButtons
		self.contentDisplayView = contentDisplayView
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder : NSCoder) {
		self.tabButtons = []
		self.contentDisplayView = UIView()
		super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		// Add the tabbarView to the view.
		view = tabBarView
		tabBarView.anchor(top: view.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor)

		// Add the tabs to the view.
		for button in self.tabButtons {
			tabBarView.addTab(tabBarButton: button)
		}

		// Set the action target for each delegate tabBarButton.
		for button in self.tabButtons {
			button.setActionTarget(tabBarViewController: self)
		}

		currentSelectedTab = tabButtons.first
		currentSelectedTab.isSelected = true
	}

	override func viewWillAppear(_ animated: Bool) {
		guard let viewController = currentSelectedTab.uiViewController else {
			return
		}
		guard let tabBarParent = tabBarView.superview else {
			return
		}
		// Show the currently selected viewController's view.
		contentDisplayView.insertSubview(viewController.view, belowSubview: tabBarParent)
	}

	internal func handleToggleSelect(tab : YMTabBarToggle) {
		// Called when a YMTabBarToggle is selected.
		tab.isEnabled = false
		animateToggleButton(buttonView: tab, isSelected: !tab.toggleState) { (_) in
			tab.toggleState = !tab.toggleState
			tab.isEnabled = true
			// Note: this does not change the currently selected tab.
		}
	}

	internal func handleTabSelect(tab : YMTabBarTab) {
		// Called when a YMTabBarTab is selected.
		animate(from: currentSelectedTab, to: tab)
		currentSelectedTab = tab
	}

	private func animate(from fromTab: YMTabBarTabButton, to toTab : YMTabBarTabButton) {
		guard fromTab != toTab else {
			return
		}
		guard let fromViewController = fromTab.uiViewController else {
			return
		}
		guard let toViewController = toTab.uiViewController else {
			return
		}

		// Update the tabbed view controller's content
		animate(from: fromViewController, to: toViewController)

		// Update the tabs
		animate(tabView: toTab)
		fromTab.isSelected = false
		toTab.isSelected = true
	}

    private func animate(from fromVC: UIViewController, to toVC: UIViewController) {

		contentDisplayView.insertSubview(toVC.view, belowSubview: tabBarView.superview!)
		parent?.addChildViewController(toVC)

        // Send the current navigation controller view to the back
        UIView.animate(withDuration: 0.325, animations: {
            fromVC.view.layer.transform = CATransform3DMakeScale(0.825, 0.825, 1)
        },
		completion: { (success: Bool) -> Void in
			fromVC.view.removeFromSuperview()
			fromVC.removeFromParentViewController()
		})

        // Bring the destination navigation controller view to the front
        let startingY = view.frame.height
        toVC.view.layer.transform = CATransform3DMakeTranslation(0, startingY, 0)
        let strongOut = RALUnitBezier.bezier(withControlPoints: 0.385, 1.180, 0.155, 0.990)!
		
        let _ = RALAnimation.start(withDuration: 0.5, delay: 0, ease: EaseLinear, tick: { value in
            let strongOutValue = CGFloat(strongOut(value))
            let transform = CATransform3DMakeTranslation(0, startingY - (startingY * strongOutValue), 0)
            toVC.view.layer.transform = transform
			
        },
        onComplete: { completed in
            toVC.view.layer.transform = CATransform3DIdentity
        })
	}

    private func animate(tabView : UIView) {
        UIView.animate(withDuration: 0.15, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .layoutSubviews,
            animations: {
            	tabView.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
            }, completion: { Bool -> Void in

            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1.5, options: .layoutSubviews,
            animations: {
                tabView.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
            }, completion: nil)
        })
    }

	private func animateToggleButton(buttonView : UIView, isSelected : Bool, onCompletion: @escaping (Bool)->Void) {
		let transform = isSelected ? CGAffineTransform(rotationAngle: .pi / 4) : CGAffineTransform(rotationAngle: 0.0)

		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1.5, options: [.curveEaseOut, .beginFromCurrentState], animations: {
			buttonView.transform = transform
			buttonView.transform = buttonView.transform.scaledBy(x: 1.3, y: 1.3)
		}, completion: { _ in

			UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
				buttonView.transform = transform
				buttonView.transform = buttonView.transform.scaledBy(x: 1.0, y: 1.0)
			}, completion: onCompletion)
		})

    }
}
