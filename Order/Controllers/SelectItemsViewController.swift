//
//  SelectItemsViewController.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/19.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class SelectItemsViewController: UIViewController {

	init() {
		super.init(nibName: nil, bundle: nil)
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
		
		self.view.backgroundColor = UIColor.magenta

		let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
		print("===> \(appDelegate.targetDate)")
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
