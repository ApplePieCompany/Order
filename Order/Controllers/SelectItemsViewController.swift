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
	
	public var myCalender : Date!
	
	var _headerView : UIView!
	var _bodyView : UIView!
	var _footerView : UIView!
	
	var _category_idx : Int!
	var _item_list : [ItemModel] = []
	var _item_idx : Int!
	
	var _itemSegcon : Int!
	var _itemCount = 0
	
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
		self._itemSegcon = appDelegate.itemSegcon

		self.CONST_FRAMESIZE = CGSize(width: self.view.frame.width, height: self.view.frame.height)
		let _navHeight = self.navigationController?.navigationBar.frame.size.height
		let _staHeight = UIApplication.shared.statusBarFrame.height
		selectItemsViewModel = SelectItemsViewModel(_size: self.CONST_FRAMESIZE, _navHeight: _navHeight!, _staHeight: _staHeight, _segcon: self._itemSegcon)
				
		self.view.addSubview(selectItemsViewModel.getHeaderView())
		self.view.addSubview(selectItemsViewModel.getBodyView())
		self.view.addSubview(selectItemsViewModel.getFooterView())
		
		selectItemsViewModel.sort_btn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		selectItemsViewModel.search_btn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		selectItemsViewModel.cart_btn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)

		selectItemsViewModel.item_back_btn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		selectItemsViewModel.item_next_btn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		
		//		selectItemsViewModel.segcon.addTarget(self, action: #selector(self.segconChanged(segcon:)), for: UIControlEvents.valueChanged)
		
		selectItemsViewModel.category_scroll.delegate = self
		//		selectItemsViewModel.myScrollView.delegate = self
		
		self.getCategoryList()
		self._category_idx = 101
		selectItemsViewModel.category_scroll.viewWithTag(self._category_idx)?.backgroundColor = UIColor.orange
		self.makeItemList()

		self.showItem()
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
		self._item_idx = 0
		
		let _ItemModels : ItemModels = ItemModels()
		self._item_list = _ItemModels.makeList(_category: self._category_idx - 101)
	}
	
	func showItem(){
		let subviews = selectItemsViewModel.item_detail_view.subviews
		for subview in subviews { subview.removeFromSuperview() }
		
		let _width = selectItemsViewModel.item_detail_view.frame.size.width - 8
		let _height = _width

		let _imageView : UIImageView = UIImageView(frame: CGRect(x: 4, y: 0, width: _width, height: _height))
		_imageView.contentMode = .scaleAspectFit
		_imageView.image = self._item_list[self._item_idx].photo
		selectItemsViewModel.item_detail_view.addSubview(_imageView)
		
		selectItemsViewModel.item_page.text = "\(self._item_idx! + 1) / \(self._item_list.count)"
		selectItemsViewModel.item_page.sizeToFit()
		
		/*
		let itemModels : ItemModels = ItemModels()
		let _itemModels : [ItemModel] = itemModels.getItems(_category: self._itemSegcon, _current: 0)
		let width = self.CONST_FRAMESIZE.width
		let height = self.CONST_FRAMESIZE.height
		
		let subviews = selectItemsViewModel.myScrollView.subviews
		for subview in subviews { subview.removeFromSuperview() }

		for i in 0 ..< _itemModels.count {
			let myLabel:UILabel = UILabel(frame: CGRect(x: CGFloat(i) * width + width/2 - 40, y: height/2 - 40, width: 80, height: 80))
			myLabel.backgroundColor = UIColor.black
			myLabel.textColor = UIColor.white
			myLabel.textAlignment = NSTextAlignment.center
			myLabel.layer.masksToBounds = true
			myLabel.text = "Page\(i)"
			myLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
			myLabel.layer.cornerRadius = 40.0
			
			selectItemsViewModel.myScrollView.addSubview(myLabel)
		}
		*/
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/

	/* ヘッダボタン処理 */
	internal func onClickMyButton(sender: UIButton){
		switch(sender.tag){
		case selectItemsViewModel.CONST_TAGS["sort_btn"]!:
			selectItemsViewModel.sort_btn_IDX = selectItemsViewModel.sort_btn_IDX == 0 ? 1: 0
			selectItemsViewModel.sort_btn.setImage(UIImage(named: selectItemsViewModel.CONST_HEADER_SORT[selectItemsViewModel.sort_btn_IDX])!, for: .normal)
			
		case selectItemsViewModel.CONST_TAGS["search_btn"]! , selectItemsViewModel.CONST_TAGS["cart_btn"]!:
			print(sender.tag)
			
		case 101 ,102, 103, 104:
			for i in 101...104{ selectItemsViewModel.category_scroll.viewWithTag(i)?.backgroundColor = UIColor.lightGray }
			selectItemsViewModel.category_scroll.viewWithTag(sender.tag)?.backgroundColor = UIColor.orange

		case selectItemsViewModel.CONST_TAGS["back_btn"]!:
			self._item_idx = self._item_idx - 1 < 0 ? 0 :self._item_idx - 1
			self.showItem()

		case selectItemsViewModel.CONST_TAGS["next_btn"]!:
			self._item_idx = self._item_idx + 1 >= self._item_list.count ? self._item_list.count - 1: self._item_idx + 1
			self.showItem()
			
		default:print("error")
		}
	}

	//ヘッダセグコン処理
	internal func segconChanged(segcon: UISegmentedControl){
		switch segcon.selectedSegmentIndex {
		case 0, 1:
			self._itemCount = 0
			print(segcon.selectedSegmentIndex)
			
		default:
			print("Error")
		}
	}
	
	
	
	/* DELEGATE */
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		if(scrollView.tag == selectItemsViewModel.CONST_TAGS["category_scroll"]!){
		}
	}

	/*
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let _exPage = selectItemsViewModel.myPagecontrol.currentPage
		var _currentPage = _exPage
		
		if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
			_currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
		}

		let itemModels : ItemModels = ItemModels()
		let _itemModels : [ItemModel] = itemModels.getItems(_category: self._itemSegcon, _current: selectItemsViewModel.myPagecontrol.currentPage)
		selectItemsViewModel.myPagecontrol.currentPage = _currentPage

		print("Ex is \(_exPage) : Now is \(_currentPage) : Items : \(_itemModels.count)")
		
		self.getItemList()
	}
	*/
}
