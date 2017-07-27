//
//  HistoryViewController.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/18.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class CartViewController: UIViewController{
	
	var shareController : ShareController = ShareController()
	var _CartViewModel : CartViewModel!
	
	var myTableView:UITableView!
	var myCalender : Date!
	var orderlist : [OrderModel]!
	
	var CONST_TAG = 13
	let CONST_WEEK = ["","日", "月", "火", "水", "木", "金", "土"]
	var CONST_FORMATTER = "yyyy年MM月dd日"
	let CONST_TAGS : [String : Int] = ["Header":100, "List":200]
	
	init() {
		super.init(nibName: nil, bundle: nil)
		
		self.title = shareController.getEnumTitle(_tag: CONST_TAG)
		
		let myBarButton : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(onClickMyButton(sender:)))
		self.navigationItem.setRightBarButton(myBarButton, animated: true)
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
		let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
		self.myCalender = appDelegate.targetDate
		self.orderlist = appDelegate.orderList
		
		self.showView(_date: self.myCalender)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	//Make Header
	func makeHeader() -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 110))
		_return.tag = CONST_TAGS["Header"]!
		
		let CONST_HEIGHT = 25
		let CONST_WIDTH : Int = Int(self.view.frame.width)
		let CONST_LOCATION_Y = 75
		let CONST_FONT = UIFont(name: "Arial", size: 18)
		
		var textLabel : UILabel?
		
		textLabel = UILabel(frame: CGRect(x:0, y:CONST_LOCATION_Y, width:CONST_WIDTH, height:CONST_HEIGHT))
		textLabel?.text = getHeaderText()
		textLabel?.textAlignment = NSTextAlignment.center
		textLabel?.font = CONST_FONT
		_return.addSubview(textLabel!)
		
		_return.backgroundColor = UIColor.white
		return _return
	}
	
	// Calender CollectionView Header
	func getHeaderText() -> String{
		let fmt = DateFormatter()
		fmt.dateFormat = CONST_FORMATTER
		
		let comp = Calendar.Component.weekday
		let weekday = NSCalendar.current.component(comp, from: self.myCalender)
		
		return fmt.string(from: self.myCalender)+"(\(CONST_WEEK[weekday]))のご注文内容"
	}
	
	//注文履歴画面表示
	func showView(_date : Date){
		if(self.view.viewWithTag(CONST_TAGS["Header"]!) != nil){
			let _View = self.view.viewWithTag(CONST_TAGS["Header"]!)
			_View?.removeFromSuperview()
		}
		self.view.addSubview(self.makeHeader())
		
		if(self.view.viewWithTag(CONST_TAGS["List"]!) != nil){
			let _View = self.view.viewWithTag(CONST_TAGS["List"]!)
			_View?.removeFromSuperview()
		}
		
		self._CartViewModel = CartViewModel(_size:CGRect(x: 0, y: 110, width: self.view.frame.width, height: self.view.frame.height - 130), _orderlist: self.orderlist)
		self.myTableView = self._CartViewModel.myTableView
		self.myTableView.tag = CONST_TAGS["List"]!
		self.view.addSubview(self.myTableView)
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/

	internal func onClickMyButton(sender: UIButton){
		let alert : UIAlertController = UIAlertController(title: "警告！", message: "買い物かごを空にしますか", preferredStyle: .actionSheet)
		let buttonOK = UIAlertAction(title: "続ける",style: .default,
			handler: { action in
				self.orderlist = []
				
				let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
				appDelegate.orderList = self.orderlist

				self.navigationController?.popViewController(animated: true)
		})
		
		let buttonNG = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
		alert.addAction(buttonOK)
		alert.addAction(buttonNG)
		self.present(alert, animated: true, completion:nil)
	}
}
