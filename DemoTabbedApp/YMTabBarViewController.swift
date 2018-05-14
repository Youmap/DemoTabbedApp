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
		guard fromTab != toTab else {
			return
		}
	
		// Update the tabbed view controller's content
		animate(from: fromTab.uiViewController, to: toTab.uiViewController)

		// Update the tabs
		animate(tabView: toTab)
		fromTab.isSelected = false
		toTab.isSelected = true
	}

    private func animate(from fromVC: UIViewController, to toVC: UIViewController) {

		displayView.insertSubview(toVC.view, belowSubview: tabBarView.superview!)
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

//    private func animatePressedPostButton() {
//        if postPressed == false {
//            postPressed = true
//            let postItemImageView = customTabBar.getIconView(for: .post)
//            if let transform = postItemImageView.layer.presentation()?.affineTransform() {
//                postItemImageView.layer.removeAllAnimations()
//                postItemImageView.transform = transform
//            }
//
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1.5, options: [.curveEaseOut, .beginFromCurrentState], animations: {
//                postItemImageView.transform = CGAffineTransform(rotationAngle: .pi / 4)
//                postItemImageView.transform = postItemImageView.transform.scaledBy(x: 1.3, y: 1.3)
//            }, completion: { _ in
//
//                UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
//                    postItemImageView.transform = CGAffineTransform(rotationAngle: .pi / 4)
//                    postItemImageView.transform = postItemImageView.transform.scaledBy(x: 1.0, y: 1.0)
//                }, completion: nil)
//            })
//
//        } else {
//
//           self.reset()
//        }
//    }
}
