//
//  OrderViewModel.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/16.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class OrderViewModels: NSObject{
	override init() {
		super.init()
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
}

// 4 CollectionView Header
class CollectionReusableView: UICollectionReusableView {
	var leftButton : UIButton?
	var textLabel : UILabel?
	var rightButton : UIButton?
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		textLabel = UILabel(frame: CGRect(x:0, y:10, width:frame.width, height:frame.height))
		textLabel?.text = ""
		textLabel?.textAlignment = NSTextAlignment.center
		textLabel?.font = UIFont(name: "Arial", size: 22)
		self.addSubview(textLabel!)

		leftButton = UIButton(frame: CGRect(x:0, y:10, width:50, height:25))
		leftButton?.titleLabel?.font = UIFont(name: "Arial", size: 22)!
		leftButton?.setTitle("＜", for: .normal)
		leftButton?.setTitleColor(UIColor.black, for:.normal)
		leftButton?.tag = 1
		self.addSubview(leftButton!)
		
		rightButton = UIButton(frame: CGRect(x:frame.width-50, y:10, width:50, height:25))
		rightButton?.titleLabel?.font = UIFont(name: "Arial", size: 22)!
		rightButton?.setTitle("＞", for: .normal)
		rightButton?.setTitleColor(UIColor.black, for:.normal)
		rightButton?.tag = 2
		self.addSubview(rightButton!)
	}
}

// 4 CollectionView Cell
class CustomUICollectionViewCell : UICollectionViewCell{
	var textLabel : UILabel?
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		textLabel = UILabel(frame: CGRect(x:0, y:0, width:frame.width, height:frame.height))
		textLabel?.text = "nil"
		textLabel?.numberOfLines = 2
		textLabel?.baselineAdjustment = .none
		textLabel?.lineBreakMode = .byTruncatingTail
		textLabel?.textAlignment = NSTextAlignment.center
		textLabel?.adjustsFontSizeToFitWidth = true
		self.contentView.addSubview(textLabel!)
	}
}
