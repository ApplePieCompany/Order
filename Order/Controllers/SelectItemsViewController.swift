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
	var CONST_SEGCON : NSArray = ["丼","定食", "洋食","一品料理"]
	
	public var myCalender : Date!
	
	var _headerView : UIView!
	var _bodyView : UIView!
	var _footerView : UIView!
	
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
		
		selectItemsViewModel.search_btn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		selectItemsViewModel.cart_btn.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		//		selectItemsViewModel.segcon.addTarget(self, action: #selector(self.segconChanged(segcon:)), for: UIControlEvents.valueChanged)
		
		selectItemsViewModel.category_scroll.delegate = self
		//		selectItemsViewModel.myScrollView.delegate = self
		
		self.getCategoryList()
		selectItemsViewModel.category_scroll.viewWithTag(101)?.backgroundColor = UIColor.orange
		self.getItemList()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func getCategoryList(){
		let _BASEWIDTH = 122
		var _BASETAG = 101
		
		for j in 0 ..< self.CONST_SEGCON.count {
			let _x = j * _BASEWIDTH + 4
			let _button : UIButton = UIButton(frame: CGRect(x: _x, y: 0, width: _BASEWIDTH - 4, height: 20))
			_button.tag = _BASETAG
			_button.backgroundColor = UIColor.lightGray
			_button.setTitle(self.CONST_SEGCON[j] as? String, for: .normal)
			_button.setTitleColor(UIColor.white, for: .normal)
			_button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
			_button.titleLabel?.textAlignment = .center
			_button.layer.cornerRadius = 4.0
			_button.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
			selectItemsViewModel.category_scroll.addSubview(_button)
			
			_BASETAG += 1
		}
	}
	
	func getItemList(){
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
		case 1 , 2:
			print(sender.tag)

		case 101 ,102, 103, 104:
			for i in 101...104{
				let _temp = selectItemsViewModel.category_scroll.viewWithTag(i)
				_temp?.backgroundColor = UIColor.lightGray
			}
			let _target = selectItemsViewModel.category_scroll.viewWithTag(sender.tag)
			_target?.backgroundColor = UIColor.orange
			
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
		if(scrollView.tag==1){
			scrollView.contentOffset.x = CGFloat(Int(scrollView.contentOffset.x / 375) * 360)
			
			//			print("CONTENT OFFSET IS \(scrollView.contentOffset.x)")
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
