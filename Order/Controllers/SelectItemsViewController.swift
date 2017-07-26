//
//  SelectItemsViewController.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/19.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class SelectItemsViewController: UIViewController, UIScrollViewDelegate{

	var shareController : ShareController = ShareController()
	var selectItemsViewModel : SelectItemsViewModel!
	
	var CONST_TAG = 12
	var CONST_FRAMESIZE : CGSize!
	var CONST_SEGCON : [Int:String] = [
	101:"丼",
	102:"定食",
	103:"洋食",
	104:"一品料理"
	]

	var CONST_CATEGORY_WIDTH = 124
	var CONST_CATEGORY_TAG_BASE = 101
	var CONST_ITEMS_X : [String:CGFloat] = ["Label":8, "Value":75]
	var CONST_CONTENTOFFSET_WIDTH : CGFloat!
	
	var CONST_INGREDIENTS : [String:UIImage] = [
		"egg":UIImage(named: "egg.png")!,
		"rice":UIImage(named: "rice.png")!,
		"pork":UIImage(named: "pork.png")!,
	]
	
	public var myCalender : Date!
	
	var _headerView : UIView!
	var _bodyView : UIView!
	var _footerView : UIView!
	
	var _category_idx : Int!
	var _item_list : [ItemModel] = []
	
	init() {
		super.init(nibName: nil, bundle: nil)
		
		self.title = shareController.getEnumTitle(_tag: CONST_TAG)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	required override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.view.backgroundColor = UIColor.white

		let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
		self.myCalender = appDelegate.targetDate

		self.CONST_FRAMESIZE = CGSize(width: self.view.frame.width, height: self.view.frame.height)
		let _navHeight = self.navigationController?.navigationBar.frame.size.height
		let _staHeight = UIApplication.shared.statusBarFrame.height
		selectItemsViewModel = SelectItemsViewModel(_size: self.CONST_FRAMESIZE, _navHeight: _navHeight!, _staHeight: _staHeight)
				
		self.view.addSubview(selectItemsViewModel.getHeaderView())
		self.view.addSubview(selectItemsViewModel.getBodyView())
		self.view.addSubview(selectItemsViewModel.getFooterView())
		
		//		selectItemsViewModel.sort_btn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		selectItemsViewModel.search_btn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		selectItemsViewModel.cart_btn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)

		selectItemsViewModel.item_back_btn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		selectItemsViewModel.item_next_btn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		
		selectItemsViewModel.category_scroll.delegate = self
		selectItemsViewModel.item_scroll.delegate = self
		
		self.CONST_CONTENTOFFSET_WIDTH = selectItemsViewModel.item_scroll.frame.width
		
		self.getCategoryList()
		self._category_idx = 101
		selectItemsViewModel.category_scroll.viewWithTag(self._category_idx)?.backgroundColor = UIColor.orange
		self.makeItemList()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func getCategoryList(){
		var _BASETAG = 101
		
		for j in 0 ..< self.CONST_SEGCON.count {
			let _x = j * self.CONST_CATEGORY_WIDTH + 4
			let _button : UIButton = UIButton(frame: CGRect(x: _x, y: 0, width: self.CONST_CATEGORY_WIDTH - 4, height: 20))
			_button.tag = _BASETAG
			_button.backgroundColor = UIColor.lightGray
			_button.setTitle(self.CONST_SEGCON[_BASETAG], for: .normal)
			_button.setTitleColor(UIColor.white, for: .normal)
			_button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
			_button.titleLabel?.textAlignment = .center
			_button.layer.cornerRadius = 4.0
			_button.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
			selectItemsViewModel.category_scroll.addSubview(_button)
			
			_BASETAG += 1
		}
	}
	
	func makeItemList(){
		let _ItemModels : ItemModels = ItemModels()
		self._item_list = _ItemModels.makeList(_category: self._category_idx - 101)

		selectItemsViewModel.item_scroll.contentSize = CGSize(width:selectItemsViewModel.item_scroll.frame.width * CGFloat(self._item_list.count) , height:0)
		selectItemsViewModel.item_scroll.contentOffset.x = 0
		
		self.showItem()
	}
	
	func showItem(){
		let subviews = selectItemsViewModel.item_scroll.subviews
		for subview in subviews { subview.removeFromSuperview() }
		
		for i in 0..<self._item_list.count{
			let _span = CONST_CONTENTOFFSET_WIDTH * CGFloat(i)

			let item_detail_view = UIView(frame: CGRect(x: 16 + _span, y: 16, width: selectItemsViewModel.item_scroll.frame.size.width - 32, height: selectItemsViewModel.item_scroll.frame.size.height - 32))
			item_detail_view.backgroundColor = UIColor.white
			
			let _width = item_detail_view.frame.size.width - 8
			let _height = _width
			
			let _item_page = UILabel(frame: CGRect(x: item_detail_view.frame.size.width - 36, y: -16, width: 48, height: 20))
			_item_page.text = "nil"
			_item_page.textAlignment = .left
			_item_page.font = UIFont.systemFont(ofSize: 14)
			_item_page.text = "\(i + 1) / \(self._item_list.count)"
			item_detail_view.addSubview(_item_page)
			
			let _imageView : UIImageView = UIImageView(frame: CGRect(x: 4 + _span, y: 4, width: _width, height: _height))
			_imageView.contentMode = .top
			_imageView.clipsToBounds = true
			_imageView.image =  shareController.resizeImage(_image: self._item_list[i].photo, _size: CGSize(width: _width, height: _height))
			_imageView.frame = CGRect(x: 4, y: 4, width: _width, height: (_imageView.image?.size.height)!)
			item_detail_view.addSubview(_imageView)
			
			var _y = 4 + _imageView.frame.height + 8
			let _name : UIView = self.getItemInfo(_width: _width, _y: _y, _labelArg:"商品名", _valArg:"\(self._item_list[i].name!)", _span:_span)
			item_detail_view.addSubview(_name)
			
			_y += (_name.frame.height + 8)
			let _tanka : UIView = self.getItemInfo(_width: _width, _y: _y, _labelArg:"税込み", _valArg:"\(self._item_list[i].tanka!)円", _span:_span)
			item_detail_view.addSubview(_tanka)
			
			_y += (_tanka.frame.height + 8)
			let Ingredient : UIView = self.getItemInfo(_width: _width, _y: _y, _labelArg:"原材料", _valArg:"", _span:_span, _isIngradient : true, _Ingradient :self._item_list[i].ingradient)
			item_detail_view.addSubview(Ingredient)

			_y += (Ingredient.frame.height + 10)
			let _English : UIView = self.getItemInfo(_width: _width, _y: _y, _labelArg:"英語名", _valArg:"\(self._item_list[i].bilingual.english!)\n(\(shareController.convertYen2(num: self._item_list[i].tanka)))", _span:_span)
			item_detail_view.addSubview(_English)
			
			item_detail_view.addSubview(getFooter(_width: _width, i: i))

			selectItemsViewModel.item_scroll.addSubview(item_detail_view)
		}
	}
	
	func getItemInfo(_width: CGFloat, _y: CGFloat, _labelArg:String, _valArg:String, _span:CGFloat, _isIngradient : Bool = false, _Ingradient : Ingradient = Ingradient()) -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0 + _span, y: 0, width: _width, height: 20))
		
		let _label : UILabel = UILabel(frame: CGRect(x: CONST_ITEMS_X["Label"]! , y: _y, width: _width, height: 30))
		_label.text = "\(_labelArg)："
		_label.numberOfLines = 0
		_label.sizeToFit()
		_return.addSubview(_label)
		
		if(!_isIngradient){
			let _val : UILabel = UILabel(frame: CGRect(x: CONST_ITEMS_X["Value"]! , y: _y, width: 200, height: 30))
			_val.text = "\(_valArg)"
			_val.numberOfLines = 0
			_val.sizeToFit()
			_return.addSubview(_val)
			
			let _maxH = max(_label.frame.height, _val.frame.height)
			_return.frame = CGRect(x: 0, y: 0, width: _label.frame.width + _val.frame.width, height: _maxH)
		}
		else{
			var _x = CONST_ITEMS_X["Value"]!
			var _cnt : CGFloat = 0
			
			if(_Ingradient.egg){
				let _EggImageView : UIImageView = UIImageView(frame: CGRect(x: _x, y: _y - 8, width: 59, height: 63))
				_EggImageView.contentMode = .scaleAspectFit
				_EggImageView.clipsToBounds = true
				_EggImageView.image =  CONST_INGREDIENTS["egg"]
				_return.addSubview(_EggImageView)
				_x += (59 + 4)
				_cnt += 1
			}

			if(_Ingradient.rice){
				let _RiceImageView : UIImageView = UIImageView(frame: CGRect(x: _x, y: _y - 8, width: 59, height: 63))
				_RiceImageView.contentMode = .scaleAspectFit
				_RiceImageView.clipsToBounds = true
				_RiceImageView.image =  CONST_INGREDIENTS["rice"]
				_return.addSubview(_RiceImageView)
				_x += (59 + 4)
				_cnt += 1
			}

			if(_Ingradient.pork){
				let _PorkImageView : UIImageView = UIImageView(frame: CGRect(x: _x, y: _y - 8, width: 59, height: 63))
				_PorkImageView.contentMode = .scaleAspectFit
				_PorkImageView.clipsToBounds = true
				_PorkImageView.image =  CONST_INGREDIENTS["pork"]
				_return.addSubview(_PorkImageView)
				_x += (59 + 4)
				_cnt += 1
			}
			
			_return.frame = CGRect(x: 0, y: 0, width: _label.frame.width + (59 * _cnt), height: 63)
}
		
		return _return
	}
	
	func getFooter(_width : CGFloat, i : Int) -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: selectItemsViewModel.item_scroll.frame.size.height - 65, width: selectItemsViewModel.item_scroll.frame.size.width - 32, height: 33))
		_return.backgroundColor = UIColor.lightGray
		
		let _countLabel : UILabel = UILabel(frame: CGRect(x: 8 , y: 6, width: _width, height: 30))
		_countLabel.text = "数　量："
		_countLabel.textColor = UIColor.white
		_countLabel.sizeToFit()
		_return.addSubview(_countLabel)
		
		let _order_label : UILabel = UILabel(frame: CGRect(x: 8 + _countLabel.frame.width, y: 2, width: 30, height: 29))
		_order_label.tag = 201 + i
		_order_label.text = "0"
		_order_label.backgroundColor = UIColor.white
		_order_label.textAlignment = .center
		_return.addSubview(_order_label)
		
		let _stepper : UIStepper = UIStepper(frame: CGRect(x: 8 + _countLabel.frame.width + _order_label.frame.width + 2, y: 2, width: 21, height: 21))
		_stepper.tag = 301 + i
		_stepper.backgroundColor = UIColor.blue
		_stepper.tintColor = UIColor.white
		_stepper.minimumValue = 0
		_stepper.maximumValue = 99
		_stepper.value = 0
		_stepper.autorepeat = true
		_stepper.addTarget(self, action: #selector(self.stepperOneChanged(stepper:)), for: UIControlEvents.valueChanged)
		_return.addSubview(_stepper)
		
		let _cartBtn : UIButton = UIButton(frame: CGRect(x: _return.frame.width - 65, y: 2, width: 62, height: 29))
		_cartBtn.tag = 401 + i
		_cartBtn.backgroundColor = UIColor.red
		_cartBtn.setTitle("買い物かごに\n入れる", for: .normal)
		_cartBtn.titleLabel?.font = UIFont.systemFont(ofSize: 9)
		_cartBtn.titleLabel?.textAlignment = .center
		_cartBtn.titleLabel?.numberOfLines = 2
		_cartBtn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		
		_return.addSubview(_cartBtn)
		return _return
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/

	/* ボタン処理 */
	internal func onClickMyButton(sender: UIButton){
		switch(sender.tag){
		case selectItemsViewModel.CONST_TAGS["sort_btn"]!:
			selectItemsViewModel.sort_btn_IDX = selectItemsViewModel.sort_btn_IDX == 0 ? 1: 0
			selectItemsViewModel.sort_btn.setImage(UIImage(named: selectItemsViewModel.CONST_HEADER_SORT[selectItemsViewModel.sort_btn_IDX])!, for: .normal)
			
		case selectItemsViewModel.CONST_TAGS["search_btn"]! , selectItemsViewModel.CONST_TAGS["cart_btn"]!:
			print(sender.tag)
			
		case 101..<105:
			for i in 101...104{ selectItemsViewModel.category_scroll.viewWithTag(i)?.backgroundColor = UIColor.lightGray }
			selectItemsViewModel.category_scroll.viewWithTag(sender.tag)?.backgroundColor = UIColor.orange
			
			self._category_idx = sender.tag
			self.makeItemList()

		case 401..<500:
			print("HI")
			
		case selectItemsViewModel.CONST_TAGS["back_btn"]!, selectItemsViewModel.CONST_TAGS["next_btn"]!:
			var _pos : CGPoint = CGPoint(x: 0, y: 0)
			let _max : CGFloat = CONST_CONTENTOFFSET_WIDTH * CGFloat( self._item_list.count - 1)
			
			if(sender.tag == selectItemsViewModel.CONST_TAGS["back_btn"]!){
				_pos.x = selectItemsViewModel.item_scroll.contentOffset.x - CONST_CONTENTOFFSET_WIDTH < 0 ? 0: selectItemsViewModel.item_scroll.contentOffset.x - CONST_CONTENTOFFSET_WIDTH
			}
			else{
				if(sender.tag == selectItemsViewModel.CONST_TAGS["next_btn"]!){
					_pos.x = selectItemsViewModel.item_scroll.contentOffset.x + CONST_CONTENTOFFSET_WIDTH > _max ? _max: selectItemsViewModel.item_scroll.contentOffset.x + CONST_CONTENTOFFSET_WIDTH
				}
			}
			_pos.x = CGFloat(Int(_pos.x / CONST_CONTENTOFFSET_WIDTH) * Int(CONST_CONTENTOFFSET_WIDTH))
			selectItemsViewModel.item_scroll.setContentOffset(_pos, animated: true)
			
		default:print("error")
		}
	}

	internal func stepperOneChanged(stepper: UIStepper){
		let _tag = stepper.tag - 100
		let _target : UILabel = selectItemsViewModel.item_scroll.viewWithTag(_tag) as! UILabel
		_target.text =  String(Int(stepper.value))
	}
	
	
	/*          */
	/* DELEGATE */
	/*          */
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		if(scrollView.tag == selectItemsViewModel.CONST_TAGS["item_scroll"]!){
		}
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		if(scrollView.tag == selectItemsViewModel.CONST_TAGS["category_scroll"]!){
		}
		else{
			if(scrollView.tag == selectItemsViewModel.CONST_TAGS["item_scroll"]!){
			}
		}
	}
}
