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
	
	public var myCalender : Date!
	
	var _headerView : UIView!
	var _bodyView : UIView!
	var _footerView : UIView!
	
	var _itemSegcon : Int!
	
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
		selectItemsViewModel.segcon.addTarget(self, action: #selector(self.segconChanged(segcon:)), for: UIControlEvents.valueChanged)
		
		selectItemsViewModel.myScrollView.delegate = self
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func getItemList(){
		let itemModels : ItemModels = ItemModels()
		let _itemModels : [ItemModel] = itemModels.getItems(_category: self._itemSegcon, _current: selectItemsViewModel.myPagecontrol.currentPage)
		
		for i in 0..<_itemModels.count{ print(_itemModels[i].code) }
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
			
		default:print("error")
		}
	}

	//ヘッダセグコン処理
	internal func segconChanged(segcon: UISegmentedControl){
		switch segcon.selectedSegmentIndex {
		case 0, 1:
			print(segcon.selectedSegmentIndex)
			
		default:
			print("Error")
		}
	}
	
	
	
	/* DELEGATE */
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
			selectItemsViewModel.myPagecontrol.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
		}
		
		self.getItemList()
	}
}
