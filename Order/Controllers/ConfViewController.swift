//
//  ConfViewController.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/14.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class ConfViewController: UIViewController {

	var shareController : ShareController = ShareController()
	var CONST_TAG = 2
	
	init() {
		super.init(nibName: nil, bundle: nil)
		
		self.title = shareController.getEnumTitle(_tag: CONST_TAG)
		self.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.favorites, tag: CONST_TAG)

		self.view.backgroundColor = UIColor.cyan
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
