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
	var CONST_BG : UIColor!

	var CONST_HEADER_TITLE = "商品選択"
	var CONST_HEADER_SEARCHPNG = "search.png"
	var CONST_HEADER_CARTPNG = "cart.png"
	var CONST_ATTRFORECOLOR = [ NSForegroundColorAttributeName: UIColor.blue ]
	
	var CONST_VIEWS_HEIGHT : [String:CGFloat] = ["Header":64, "Body":0,"Footer":1]

	public var search_btn : UIButton!
	public var cart_btn : UIButton!
	public var category_scroll : UIScrollView!
	public var category_scroll_max : CGFloat = 2
	
	public var myScrollView : UIScrollView!
	public var myPageSize : Int!
	
	override init() {
	}

	init(_size:CGSize, _navHeight:CGFloat, _staHeight:CGFloat, _segcon: Int){
		self.CONST_FRAMESIZE = _size
		self.CONST_NAVIGATIONBAR_HEIGHT = _navHeight + 20
		self.CONST_STATUSBAR_HEIGHT = _staHeight + 30
		self.CONST_VIEWS_HEIGHT["Body"] = CONST_FRAMESIZE.height - self.CONST_NAVIGATIONBAR_HEIGHT - self.CONST_STATUSBAR_HEIGHT - self.CONST_VIEWS_HEIGHT["Header"]! - self.CONST_VIEWS_HEIGHT["Footer"]!
		self.CONST_BG = shareController.convHex2Color(_hexStr: "F5ECCE", _alpha:1)
	}
	
	func getHeaderView() -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: self.CONST_NAVIGATIONBAR_HEIGHT, width: self.CONST_FRAMESIZE.width, height: CONST_VIEWS_HEIGHT["Header"]!))
		_return.backgroundColor = self.CONST_BG
		
		let _title : UILabel = UILabel(frame: CGRect(x: 0, y: 8, width: CONST_FRAMESIZE.width, height: 0))
		_title.text = CONST_HEADER_TITLE
		_title.sizeToFit()
		_title.frame.origin.x = CONST_FRAMESIZE.width/2 - _title.frame.size.width/2
		_return.addSubview(_title)
		
		self.search_btn = UIButton(frame: CGRect(x: CONST_FRAMESIZE.width - 16 - 16 - 16, y: 8, width: 16, height: 16))
		self.search_btn.tag = 1
		let _searchImage : UIImage = UIImage(named: CONST_HEADER_SEARCHPNG)!
		self.search_btn.setImage(_searchImage, for: .normal)
		_return.addSubview(self.search_btn)

		self.cart_btn = UIButton(frame: CGRect(x: CONST_FRAMESIZE.width - 16 - 8, y: 8, width: 16, height: 16))
		self.cart_btn.tag = 2
		let _cartImage : UIImage = UIImage(named: CONST_HEADER_CARTPNG)!
		self.cart_btn.setImage(_cartImage, for: .normal)
		_return.addSubview(self.cart_btn)

		self.category_scroll = UIScrollView()
		self.category_scroll.backgroundColor = UIColor.clear
		self.category_scroll.isPagingEnabled = true
		self.category_scroll.bounces = true
		self.category_scroll.tag = 1
		self.category_scroll.frame = CGRect(x: 0, y: self.cart_btn.frame.origin.y + self.cart_btn.frame.size.height + 16, width: self.CONST_FRAMESIZE.width, height: 20)
		self.category_scroll.contentSize = CGSize(width:self.CONST_FRAMESIZE.width * category_scroll_max, height:0)
		_return.addSubview(self.category_scroll)

		return _return
	}
	
	func getBodyView() -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: self.CONST_NAVIGATIONBAR_HEIGHT + CONST_VIEWS_HEIGHT["Header"]!, width: self.CONST_FRAMESIZE.width, height: CONST_VIEWS_HEIGHT["Body"]!))
		_return.backgroundColor = UIColor.white
		let width = _return.frame.maxX
		let height = _return.frame.maxY
		
		/*
		myScrollView = UIScrollView(frame: CGRect(x: 0, y: CONST_VIEWS_HEIGHT["Header"]!, width: CONST_FRAMESIZE.width, height: CONST_VIEWS_HEIGHT["Body"]!))
		myScrollView.showsHorizontalScrollIndicator = false;
		myScrollView.showsVerticalScrollIndicator = false
		myScrollView.isPagingEnabled = true
		myScrollView.contentSize = CGSize(width: CGFloat(self.myPageSize) * width, height: 0)
		_return.addSubview(myScrollView)
		*/
		
		// ページ数分ボタンを生成する.
		/*
		for i in 0 ..< self.myPageSize {
			let myLabel:UILabel = UILabel(frame: CGRect(x: CGFloat(i) * width + width/2 - 40, y: height/2 - 40, width: 80, height: 80))
			myLabel.backgroundColor = UIColor.black
			myLabel.textColor = UIColor.white
			myLabel.textAlignment = NSTextAlignment.center
			myLabel.layer.masksToBounds = true
			myLabel.text = "Page\(i)"
			myLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
			myLabel.layer.cornerRadius = 40.0
			
			myScrollView.addSubview(myLabel)
		}
		*/
		
		// PageControlを作成する.
/*
		myPagecontrol = UIPageControl(frame: CGRect(x:0, y:0, width:width, height:24))
		myPagecontrol.backgroundColor = self.CONST_BG
		myPagecontrol.numberOfPages = self.myPageSize
		myPagecontrol.currentPage = 0
		myPagecontrol.isUserInteractionEnabled = false
		_return.addSubview(myPagecontrol)
*/

		return _return
	}
	
	func getFooterView() -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: self.CONST_FRAMESIZE.height - self.CONST_STATUSBAR_HEIGHT, width: self.CONST_FRAMESIZE.width, height: CONST_VIEWS_HEIGHT["Footer"]!))
		_return.backgroundColor = UIColor.white
		return _return
	}
	
	
}
