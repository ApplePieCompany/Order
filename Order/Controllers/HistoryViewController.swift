//
//  HistoryViewController.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/18.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		
		self.view.backgroundColor = UIColor.orange
		
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
