//
//  HistoryViewController.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/18.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController{

	var shareController : ShareController = ShareController()
	var _HistoryViewModel : HistoryViewModel!

	var myTableView:UITableView!
	var myCalender : Date!
	
	var CONST_TAG = 11
	var CONST_FRAMESIZE : CGSize!
	let CONST_WEEK = ["","日", "月", "火", "水", "木", "金", "土"]
	var CONST_FORMATTER = "yyyy年MM月dd日"
	
	var _CellItems: [OrderModel] = []
	
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
		_HistoryViewModel = HistoryViewModel(_size:CGRect(x: 0, y: 110, width: self.view.frame.width, height: self.view.frame.height))
		
		let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
		self.myCalender = appDelegate.targetDate
		//		self.makeCellItems()
		
		self.view.addSubview(self.makeHeader())
		
		self.myTableView = _HistoryViewModel.myTableView
		self.view.addSubview(self.myTableView)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	//Make Header
	func makeHeader() -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 110))
		_return.tag = 100
		
		let CONST_HEIGHT = 25
		let CONST_WIDTH : Int = Int(self.view.frame.width)
		let CONST_LOCATION_Y = 75
		
		var leftButton : UIButton?
		var textLabel : UILabel?
		var rightButton : UIButton?

		textLabel = UILabel(frame: CGRect(x:0, y:CONST_LOCATION_Y, width:CONST_WIDTH, height:CONST_HEIGHT))
		textLabel?.text = getHeaderText()
		textLabel?.textAlignment = NSTextAlignment.center
		textLabel?.font = UIFont(name: "Arial", size: 22)
		_return.addSubview(textLabel!)
		
		leftButton = UIButton(frame: CGRect(x:0, y:CONST_LOCATION_Y, width:50, height:CONST_HEIGHT))
		leftButton?.titleLabel?.font = UIFont(name: "Arial", size: 22)!
		leftButton?.setTitle("＜", for: .normal)
		leftButton?.setTitleColor(UIColor.black, for:.normal)
		leftButton?.tag = 1
		leftButton?.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		_return.addSubview(leftButton!)
		
		rightButton = UIButton(frame: CGRect(x:CONST_WIDTH-50, y:CONST_LOCATION_Y, width:50, height:CONST_HEIGHT))
		rightButton?.titleLabel?.font = UIFont(name: "Arial", size: 22)!
		rightButton?.setTitle("＞", for: .normal)
		rightButton?.setTitleColor(UIColor.black, for:.normal)
		rightButton?.tag = 2
		rightButton?.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		_return.addSubview(rightButton!)
		
		_return.backgroundColor = UIColor.white
		return _return
	}

	// Calender CollectionView Header
	func getHeaderText() -> String{
		let fmt = DateFormatter()
		fmt.dateFormat = CONST_FORMATTER
		
		let comp = Calendar.Component.weekday
		let weekday = NSCalendar.current.component(comp, from: self.myCalender)

		return fmt.string(from: self.myCalender)+"(\(CONST_WEEK[weekday]))"
	}
	
	/* カレンダー送り戻しボタン処理 */
	internal func onClickMyButton(sender: UIButton){
		switch(sender.tag){
		case 1 , 2:
			
			let _headerView = self.view.viewWithTag(100)
			_headerView?.removeFromSuperview()
			
			var _idx = -1
			if(sender.tag==2){ _idx = 1 }
			
			self.myCalender = shareController.addCalendar(_date: self.myCalender, _day: _idx)
			
			self.view.addSubview(self.makeHeader())
			
			//			self.makeCellItems()
			myTableView.reloadData()

		default:print("error")
		}
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
