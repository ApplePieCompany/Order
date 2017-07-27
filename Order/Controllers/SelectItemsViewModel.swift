//
//  SelectItemsViewModel.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/22.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class SelectItemsViewModel: NSObject {

	var shareController : ShareController = ShareController()

	var CONST_FRAMESIZE : CGSize!
	var CONST_NAVIGATIONBAR_HEIGHT : CGFloat!
	var CONST_STATUSBAR_HEIGHT : CGFloat!
	let CONST_WEEK = ["","日", "月", "火", "水", "木", "金", "土"]
	var CONST_FORMATTER = "yyyy年MM月dd日"
	var CONST_BG : UIColor!
	var CONST_BG_HEX :NSString = "F5ECCE"

	var CONST_HEADER_SORT : [String] = ["sort1.png","sort2.png"]
	var CONST_HEADER_SEARCHPNG = "search.png"
	var CONST_HEADER_CARTPNG = "cart.png"
	var CONST_ATTRFORECOLOR = [ NSForegroundColorAttributeName: UIColor.blue ]
	public var CONST_TAGS : [String:Int] = [
		"sort_btn" : 1,
		"search_btn" : 2,
		"cart_btn" : 3,
		"category_scroll" : 11,
		"item_scroll" : 12,
		"back_btn" : 21,
		"next_btn" : 22,
	]

	var CONST_BODY_BACK = "back.png"
	var CONST_BODY_NEXT = "next.png"
	
	var CONST_VIEWS_HEIGHT : [String:CGFloat] = ["Header":64, "Body":0,"Footer":1]

	public var sort_btn : UIButton!
	public var search_btn : UIButton!
	public var cart_btn : UIButton!
	public var sort_btn_IDX = 0
	
	public var category_scroll : UIScrollView!
	public var category_scroll_max : CGFloat = 2
	
	public var item_back_btn : UIButton!
	public var item_next_btn : UIButton!
	public var item_scroll : UIScrollView!
	
	override init() {
	}

	init(_size:CGSize, _navHeight:CGFloat, _staHeight:CGFloat){
		self.CONST_FRAMESIZE = _size
		self.CONST_NAVIGATIONBAR_HEIGHT = _navHeight + 20
		self.CONST_STATUSBAR_HEIGHT = _staHeight + 30
		self.CONST_VIEWS_HEIGHT["Body"] = CONST_FRAMESIZE.height - self.CONST_NAVIGATIONBAR_HEIGHT - self.CONST_STATUSBAR_HEIGHT - self.CONST_VIEWS_HEIGHT["Header"]! - self.CONST_VIEWS_HEIGHT["Footer"]!
		self.CONST_BG = shareController.convHex2Color(_hexStr: self.CONST_BG_HEX, _alpha:1)
	}
	
	func getHeaderView() -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: self.CONST_NAVIGATIONBAR_HEIGHT, width: self.CONST_FRAMESIZE.width, height: CONST_VIEWS_HEIGHT["Header"]!))
		_return.backgroundColor = self.CONST_BG

		let textLabel : UILabel = UILabel(frame: CGRect(x:0, y:0, width:CONST_FRAMESIZE.width, height:35))
		textLabel.text = getHeaderText()
		textLabel.textAlignment = NSTextAlignment.center
		textLabel.font = UIFont(name: "Arial", size: 16)
		_return.addSubview(textLabel)
		
		/*
		self.sort_btn = UIButton(frame: CGRect(x: CONST_FRAMESIZE.width - 16 - 60, y: 8, width: 16, height: 16))
		self.sort_btn.tag = CONST_TAGS["sort_btn"]!
		let _sortImage : UIImage = UIImage(named: CONST_HEADER_SORT[sort_btn_IDX])!
		self.sort_btn.setImage(_sortImage, for: .normal)
		_return.addSubview(self.sort_btn)
		*/

		self.search_btn = UIButton(frame: CGRect(x: CONST_FRAMESIZE.width - 16 - 40, y: 8, width: 16, height: 16))
		self.search_btn.tag = CONST_TAGS["search_btn"]!
		let _searchImage : UIImage = UIImage(named: CONST_HEADER_SEARCHPNG)!
		self.search_btn.setImage(_searchImage, for: .normal)
		_return.addSubview(self.search_btn)

		self.cart_btn = UIButton(frame: CGRect(x: CONST_FRAMESIZE.width - 16 - 16, y: 8, width: 16, height: 16))
		self.cart_btn.tag = CONST_TAGS["cart_btn"]!
		let _cartImage : UIImage = UIImage(named: CONST_HEADER_CARTPNG)!
		self.cart_btn.setImage(_cartImage, for: .normal)
		_return.addSubview(self.cart_btn)

		self.category_scroll = UIScrollView()
		self.category_scroll.backgroundColor = UIColor.clear
		self.category_scroll.isPagingEnabled = true
		self.category_scroll.bounces = true
		self.category_scroll.tag = CONST_TAGS["category_scroll"]!
		self.category_scroll.frame = CGRect(x: 0, y: self.cart_btn.frame.origin.y + self.cart_btn.frame.size.height + 16, width: self.CONST_FRAMESIZE.width, height: 20)
		self.category_scroll.contentSize = CGSize(width:self.CONST_FRAMESIZE.width * category_scroll_max, height:0)
		_return.addSubview(self.category_scroll)

		return _return
	}
	
	func getHeaderText() -> String{
		let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

		let fmt = DateFormatter()
		fmt.dateFormat = CONST_FORMATTER
		
		let comp = Calendar.Component.weekday
		let weekday = NSCalendar.current.component(comp, from: appDelegate.targetDate)
		
		return fmt.string(from: appDelegate.targetDate)+"(\(CONST_WEEK[weekday]))"
	}
	
	func getBodyView() -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: self.CONST_NAVIGATIONBAR_HEIGHT + CONST_VIEWS_HEIGHT["Header"]!, width: self.CONST_FRAMESIZE.width, height: CONST_VIEWS_HEIGHT["Body"]!))
		_return.backgroundColor = self.CONST_BG

		let width = _return.frame.maxX
		let height = CONST_VIEWS_HEIGHT["Body"]
		
		_return.addSubview(makeCenterView(width: width,height: height!))
		_return.addSubview(makeLeftView(height:height!))
		_return.addSubview(makeRightView(width: width,height: height!))
		
		return _return
	}
	
	func makeLeftView(height : CGFloat) -> UIView{
		let _leftView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: height))
		self.item_back_btn = UIButton(frame: CGRect(x: 4, y: CONST_VIEWS_HEIGHT["Body"]! / 2 - 16, width: 32, height: 32))
		let _backImage : UIImage = UIImage(named: self.CONST_BODY_BACK)!
		self.item_back_btn.setImage(_backImage, for: .normal)
		self.item_back_btn.tag = self.CONST_TAGS["back_btn"]!
		_leftView.addSubview(self.item_back_btn)
		return _leftView
	}
	
	func makeCenterView(width: CGFloat, height : CGFloat) -> UIScrollView{
		self.item_scroll = UIScrollView(frame: CGRect(x: 36, y: 0, width: width - 36 - 36, height: height))
		self.item_scroll.tag = CONST_TAGS["item_scroll"]!
		self.item_scroll.backgroundColor = UIColor.clear
		self.item_scroll.isPagingEnabled = true
		self.item_scroll.bounces = true
		return item_scroll
	}
	
	func makeRightView(width: CGFloat, height : CGFloat) -> UIView{
		let _rightView : UIView = UIView(frame: CGRect(x: width - 36, y: 0, width: 32, height: height))
		self.item_next_btn = UIButton(frame: CGRect(x: 0, y: CONST_VIEWS_HEIGHT["Body"]! / 2 - 16, width: 32, height: 32))
		let _nextImage : UIImage = UIImage(named: self.CONST_BODY_NEXT)!
		self.item_next_btn.setImage(_nextImage, for: .normal)
		self.item_next_btn.tag = self.CONST_TAGS["next_btn"]!
		_rightView.addSubview(self.item_next_btn)
		return _rightView
	}
	
	func getFooterView() -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: self.CONST_FRAMESIZE.height - self.CONST_STATUSBAR_HEIGHT, width: self.CONST_FRAMESIZE.width, height: CONST_VIEWS_HEIGHT["Footer"]!))
		_return.backgroundColor = UIColor.white
		return _return
	}
	
}
