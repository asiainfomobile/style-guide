//
//  TimeLineView.swift
//  demo
//
//  Created by admin on 3/1/16.
//  Copyright © 2016 __ASIAINFO__. All rights reserved.
//

import UIKit

class TimeLineView: UIView {
	@IBOutlet weak var logo1: UIImageView!
	@IBOutlet weak var logo2: UIImageView!
	@IBOutlet weak var logo3: UIImageView!
	
	@IBOutlet weak var label1: UILabel!
	@IBOutlet weak var label2: UILabel!
	@IBOutlet weak var label3: UILabel!
	
	@IBOutlet weak var topCenterXConstraint: NSLayoutConstraint!
	@IBOutlet weak var middleCenterXConstraint: NSLayoutConstraint!
	@IBOutlet weak var bottomCenterXConstraint: NSLayoutConstraint!
	
	var isTopLogoAtLeft: Bool {
		return topCenterXConstraint.constant == -100
	}
	
	var isMiddleLogoAtLeft: Bool {
		return middleCenterXConstraint.constant == -100
	}
	
	var isBottomLogoAtLeft: Bool {
		return bottomCenterXConstraint.constant == -100
	}
	
	var line1: CAShapeLayer!
	var line2: CAShapeLayer!
	
	var path1: CGPath {
		let point1 = CGPoint(x: CGRectGetMidX(logo1.frame), y: CGRectGetMaxY(logo1.frame))
		let point2 = CGPoint(x: CGRectGetMidX(logo2.frame), y: CGRectGetMinY(logo2.frame))
		
		let path1 = UIBezierPath()
		path1.moveToPoint(point1)
		path1.addLineToPoint(point2)
		
		return path1.CGPath
	}
	
	var path2: CGPath {
		let point3 = CGPoint(x: CGRectGetMidX(logo2.frame), y: CGRectGetMaxY(logo2.frame))
		let point4 = CGPoint(x: CGRectGetMidX(logo3.frame), y: CGRectGetMinY(logo3.frame))
		
		let path2 = UIBezierPath()
		path2.moveToPoint(point3)
		path2.addLineToPoint(point4)
		
		return path2.CGPath
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupLines()
	}
	
	func setupLines() {
		line1 = CAShapeLayer()
		line1.lineWidth = 2
		line1.strokeColor = UIColor.blueColor().CGColor
		line2 = CAShapeLayer()
		line2.lineWidth = 2
		line2.strokeColor = UIColor.blueColor().CGColor
		layer.addSublayer(line1)
		layer.addSublayer(line2)
	}
	
	func animationLines() {
		let animation1 = makeAnimationToNewPath(path1)
		let animation2 = makeAnimationToNewPath(path2)
		
		line1.addAnimation(animation1, forKey: nil)
		line2.addAnimation(animation2, forKey: nil)
	}
	
	override func displayLayer(layer: CALayer) {
		line1.path = path1
		line2.path = path2
	}
	
	func makeAnimationToNewPath(newPath: CGPath) -> CABasicAnimation {
		let animation: CABasicAnimation = CABasicAnimation(keyPath: "path")
		animation.duration = 0.25
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		animation.fillMode = kCAFillModeForwards
		animation.removedOnCompletion = false
		animation.toValue = newPath
		return animation
	}
	
	@IBAction func topTapped(sender: AnyObject) {
		topCenterXConstraint.constant = isTopLogoAtLeft ? 0 : -100
		UIView.animateWithDuration(0.25) { () -> Void in
            self.label1.alpha = self.isTopLogoAtLeft ? 1 : 0
			self.layoutIfNeeded()
			self.animationLines()
		}
	}
	
	@IBAction func middleTapped(sender: AnyObject) {
		middleCenterXConstraint.constant = isMiddleLogoAtLeft ? 0 : -100
		UIView.animateWithDuration(0.25) { () -> Void in
            self.label2.alpha = self.isMiddleLogoAtLeft ? 1 : 0
			self.layoutIfNeeded()
			self.animationLines()
		}
	}
	
	@IBAction func bottomTapped(sender: AnyObject) {
		bottomCenterXConstraint.constant = isBottomLogoAtLeft ? 0 : -100
		UIView.animateWithDuration(0.25) { () -> Void in
            self.label3.alpha = self.isBottomLogoAtLeft ? 1 : 0
			self.layoutIfNeeded()
			self.animationLines()
		}
	}
}
