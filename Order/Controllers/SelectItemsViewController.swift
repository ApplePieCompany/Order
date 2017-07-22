//
//  SelectItemsViewController.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/19.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class SelectItemsViewController: UIViewController{

	var shareController : ShareController = ShareController()
	var selectItemsViewModel : SelectItemsViewModel!
	
	var CONST_TAG = 12
	var CONST_FRAMESIZE : CGSize!
	
	public var myCalender : Date!
	
	
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
		self.CONST_FRAMESIZE = CGSize(width: self.view.frame.width, height: self.view.frame.height)

		let _navHeight = self.navigationController?.navigationBar.frame.size.height
		let _staHeight = UIApplication.shared.statusBarFrame.height
		selectItemsViewModel = SelectItemsViewModel(_size: self.CONST_FRAMESIZE, _navHeight: _navHeight!, _staHeight: _staHeight)
		
		let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
		self.myCalender = appDelegate.targetDate

		self.view.backgroundColor = UIColor.white
		self.view.addSubview(selectItemsViewModel.getHeaderView())
		self.view.addSubview(selectItemsViewModel.getBodyView())
		self.view.addSubview(selectItemsViewModel.getFooterView())
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
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
