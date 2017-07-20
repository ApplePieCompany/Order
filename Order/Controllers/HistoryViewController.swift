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
	var eventList : [Date]!
	var currentEventNo : Int = -1
	
	var CONST_TAG = 11
	let CONST_WEEK = ["","日", "月", "火", "水", "木", "金", "土"]
	var CONST_FORMATTER = "yyyy年MM月dd日"
	let CONST_TAGS : [String : Int] = ["Header":100, "List":200]

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
		let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
		self.myCalender = appDelegate.targetDate
		self.eventList = appDelegate.eventList
		
		for i in 0..<self.eventList.count{
			if(self.eventList[i] == self.myCalender){
				self.currentEventNo = i
				break
			}
		}
		
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
		let CONST_FONT = UIFont(name: "Arial", size: 22)
		let CONST_TITLES : [String: String] = ["left":"＜", "right":"＞"]
		
		var leftButton : UIButton?
		var textLabel : UILabel?
		var rightButton : UIButton?

		textLabel = UILabel(frame: CGRect(x:0, y:CONST_LOCATION_Y, width:CONST_WIDTH, height:CONST_HEIGHT))
		textLabel?.text = getHeaderText()
		textLabel?.textAlignment = NSTextAlignment.center
		textLabel?.font = CONST_FONT
		_return.addSubview(textLabel!)
		
		leftButton = UIButton(frame: CGRect(x:0, y:CONST_LOCATION_Y, width:50, height:CONST_HEIGHT))
		leftButton?.titleLabel?.font = CONST_FONT!
		leftButton?.setTitle(CONST_TITLES["left"], for: .normal)
		leftButton?.setTitleColor(UIColor.black, for:.normal)
		leftButton?.tag = 1
		leftButton?.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		_return.addSubview(leftButton!)
		
		rightButton = UIButton(frame: CGRect(x:CONST_WIDTH-50, y:CONST_LOCATION_Y, width:50, height:CONST_HEIGHT))
		rightButton?.titleLabel?.font = CONST_FONT!
		rightButton?.setTitle(CONST_TITLES["right"], for: .normal)
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

		self._HistoryViewModel = HistoryViewModel(_size:CGRect(x: 0, y: 110, width: self.view.frame.width, height: self.view.frame.height - 110), _date:_date)
		self.myTableView = self._HistoryViewModel.myTableView
		self.myTableView.tag = CONST_TAGS["List"]!
		self.view.addSubview(self.myTableView)
	}
	
	/* カレンダー送り戻しボタン処理 */
	internal func onClickMyButton(sender: UIButton){
		if(sender.tag == 1 && self.currentEventNo == 0){ return }
		if(sender.tag == 2 && self.currentEventNo == self.eventList.count-1){ return }

		if(sender.tag == 1){ self.currentEventNo -= 1 }
		if(sender.tag == 2){ self.currentEventNo += 1 }
		
		self.myCalender = self.eventList[self.currentEventNo]
		self.showView(_date: self.myCalender)
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
