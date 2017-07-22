//
//  MainTabBarControllerViewController.swift
//  StressCHeck
//
//  Created by TatsuoYagi on 2017/07/03.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		
		var uIViewController : [UIViewController] = [OrderViewController(),ConfViewController()]		
		uIViewController[0].tabBarItem = UITabBarItem(title: "商品注文", image: UIImage(named:"list.png"), tag: 1)
		uIViewController[1].tabBarItem = UITabBarItem(title: "利用者設定", image: UIImage(named:"conf.png"), tag: 2)
				
		var navigationControllers : [UINavigationController] = []
		for value in uIViewController{
			navigationControllers.append(UINavigationController(rootViewController: value))
		}
		
		self.viewControllers = navigationControllers
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
