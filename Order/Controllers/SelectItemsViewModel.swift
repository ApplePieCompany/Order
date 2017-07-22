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

	var CONST_HEADER_TITLE = "商品一覧"
	var CONST_HEADER_PNG = "cart.png"
	var CONST_SEGCON : NSArray = ["丼","定食", "洋食","一品料理"]
	var CONST_ATTRFORECOLOR = [ NSForegroundColorAttributeName: UIColor.blue ]

	
	var CONST_VIEWS_HEIGHT : [String:CGFloat] = ["Header":100, "Body":0,"Footer":1]
	
	override init() {
	}

	init(_size:CGSize, _navHeight:CGFloat, _staHeight:CGFloat){
		self.CONST_FRAMESIZE = _size
		self.CONST_NAVIGATIONBAR_HEIGHT = _navHeight + 20
		self.CONST_STATUSBAR_HEIGHT = _staHeight + 30
		self.CONST_VIEWS_HEIGHT["Body"] = CONST_FRAMESIZE.height - self.CONST_NAVIGATIONBAR_HEIGHT - self.CONST_STATUSBAR_HEIGHT - self.CONST_VIEWS_HEIGHT["Header"]! - self.CONST_VIEWS_HEIGHT["Footer"]!
	}
	
	func getHeaderView() -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: self.CONST_NAVIGATIONBAR_HEIGHT, width: self.CONST_FRAMESIZE.width, height: CONST_VIEWS_HEIGHT["Header"]!))
		_return.backgroundColor = shareController.convHex2Color(_hexStr: "F5ECCE", _alpha:1)
		
		let _title : UILabel = UILabel(frame: CGRect(x: 0, y: 8, width: CONST_FRAMESIZE.width, height: 0))
		_title.text = CONST_HEADER_TITLE
		_title.sizeToFit()
		_title.frame.origin.x = CONST_FRAMESIZE.width/2 - _title.frame.size.width/2
		_return.addSubview(_title)
		
		let _cart : UIButton = UIButton(frame: CGRect(x: CONST_FRAMESIZE.width - 32 - 8, y: _title.frame.size.height + 8, width: 32, height: 32))
		let _cartImage : UIImage = UIImage(named: CONST_HEADER_PNG)!
		_cart.setImage(_cartImage, for: .normal)
		_return.addSubview(_cart)

		let _segcon : UISegmentedControl = UISegmentedControl(items: CONST_SEGCON as [AnyObject])
		_segcon.setTitleTextAttributes(CONST_ATTRFORECOLOR, for: UIControlState.selected)
		_segcon.center = CGPoint(x: self.CONST_FRAMESIZE.width/2, y: _cart.frame.origin.y + _cart.frame.size.height + 20)
		_segcon.backgroundColor = UIColor.blue
		_segcon.tintColor = UIColor.white
		_segcon.layer.cornerRadius = 5
		_segcon.selectedSegmentIndex = 0
		_return.addSubview(_segcon)
		
		return _return
	}
	
	func getBodyView() -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: self.CONST_NAVIGATIONBAR_HEIGHT + CONST_VIEWS_HEIGHT["Header"]!, width: self.CONST_FRAMESIZE.width, height: CONST_VIEWS_HEIGHT["Body"]!))
		_return.backgroundColor = UIColor.orange
		return _return
	}
	
	func getFooterView() -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: self.CONST_FRAMESIZE.height - self.CONST_STATUSBAR_HEIGHT, width: self.CONST_FRAMESIZE.width, height: CONST_VIEWS_HEIGHT["Footer"]!))
		_return.backgroundColor = UIColor.white
		return _return
	}

}
