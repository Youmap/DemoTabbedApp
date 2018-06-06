//
//  YMTabBarView.swift
//  DemoTabbedApp
//
//  Created by Michael Valentiner on 5/7/18.
//  Copyright © 2018 Heliotropix. All rights reserved.
//

import UIKit

class YMTabBarView : UIView {
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

	internal func addTab(tabBarButton : YMTabBarTabButton) {
		stackView.addArrangedSubview(tabBarButton)
		tabBarButton.anchor(top: stackView.topAnchor)
	}
}
