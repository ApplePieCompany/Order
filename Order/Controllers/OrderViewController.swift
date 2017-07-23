//
//  OrderViewController.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/14.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
	
	var shareController : ShareController = ShareController()
	
	var myCollectionView:UICollectionView!
	var myCalender : Date!
	
	var CONST_TAG = 1
	var CONST_FRAMESIZE : CGSize!
	let CONST_WEEK = ["日", "月", "火", "水", "木", "金", "土"]
	var CONST_CellIdent = "MyCell"
	var CONST_ReuseIdent = "Section"
	var CONST_SECTION = 2
	var CONST_DAYS = 7
	var CONST_FORMATTER = "yyyy年MM月"
	
	var _Layout_itemSize : CGSize!
	var _Layout_headerReferenceSize = CGSize(width:0,height:10)
	var _Layout_sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
	
	var _Collection_Frame : CGRect!
	var _Collection_HeaderSize : CGSize!
	
	var _CellItems: [Date] = []
	var _EventList : [Date] = []
	var _IsIng : Bool = false
	
	enum DayColor{
		case Sun
		case Sat
		case Week
		
		var Colors : UIColor{
			switch self{
			case .Sun:return UIColor(red: 220.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)
			case .Sat:return UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
			case .Week:return UIColor.darkGray
			}
		}
	}

	
	init() {
		super.init(nibName: nil, bundle: nil)

		self.title = shareController.getEnumTitle(_tag: CONST_TAG)
		self.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.favorites, tag: CONST_TAG)
		self.tabBarItem.badgeColor = UIColor.red
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

		self._Layout_itemSize = CGSize(width:CONST_FRAMESIZE.width / 9, height:CONST_FRAMESIZE.height / 11)
		self._Collection_Frame = CGRect(x: 0, y: 0, width: CONST_FRAMESIZE.width, height:CONST_FRAMESIZE.height - 49)
		self._Collection_HeaderSize = CGSize(width: CONST_FRAMESIZE.width, height: 30)

		self.myCalender = Date()
		self.makeCellItems()
		
		self.myCollectionView = self.getCollectionView()
		if(self._EventList.count>0 ){
			self.tabBarItem.badgeValue = "!"
		}
		
		self.view.addSubview(myCollectionView)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(_ animated: Bool){
		//		myCollectView.setContentOffset(CGPoint(x:0,y:self.myCollectView.contentSize.height - self.myCollectView.frame.size.height), animated: false)
	}	


	/*  */
	// Calender CollectionView Header
	func getHeaderText() -> String{
		let fmt = DateFormatter()
		fmt.dateFormat = CONST_FORMATTER
		return fmt.string(from: self.myCalender)
	}
	
	/* カレンダー送り戻しボタン処理 */
	internal func onClickMyButton(sender: UIButton){
		switch(sender.tag){
		case 1 , 2:
			var _idx = -1
			if(sender.tag==2){ _idx = 1 }
			
			self.myCalender = shareController.addCalendar(_date: self.myCalender, _month: _idx)
			self.makeCellItems()
			myCollectionView.reloadData()
			
		default:print("error")
		}
	}

	//Make CellItems
	func makeCellItems(){
		let _temp = shareController.getCalendarDays(_date: self.myCalender)
		self._CellItems = shareController.makeCalendar(beg: _temp.beg , end: _temp.end)
		self._EventList = shareController.makeEventList(_days: self._CellItems)
	}

	// Calender CollectionView
	func getCollectionView() -> UICollectionView{
		var _return:UICollectionView!
		
		let _Layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		_Layout.itemSize = _Layout_itemSize
		//		_Layout.headerReferenceSize = _Layout_headerReferenceSize
		_Layout.sectionInset = _Layout_sectionInset
		
		// CollectionViewを生成.
		_return = UICollectionView(frame: _Collection_Frame, collectionViewLayout: _Layout)
		_return.backgroundColor = UIColor.white
		_return.register(CustomUICollectionViewCell.self, forCellWithReuseIdentifier: CONST_CellIdent)
		_return.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CONST_ReuseIdent)
		_return.delegate = self
		_return.dataSource = self
		
		return _return
	}
	
	//イベントリストに指定日付があるか？
	func IsEvent(_date:Date) -> Bool{
		var _return = false
		
		var _basecomp = Calendar.current.dateComponents([.year, .month, .day, .hour],from:_date)
		_basecomp.hour = 9
		
		for i in 0..<self._EventList.count{
			var _comp = Calendar.current.dateComponents([.year, .month, .day, .hour],from:self._EventList[i])
			_comp.hour = 9
			
			if(_basecomp == _comp){
				_return = true
				break
			}
		}
		
		return _return
	}
	
	//指定月かどうかの判定
	func IsThisMonth(_date:Date) -> Bool{
		var _return = false
		
		let calendar = Calendar.current
		let _diff : Int = calendar.dateComponents([.day], from: Date(), to: _date).day!
		
		_return = _diff > -1 ? true: false
		
		return _return
	}
	
	
	/*          */
	/* DELEGATE */
	/*          */

	//セクション数
	internal func numberOfSections(in collectionView: UICollectionView) -> Int {
		return CONST_SECTION
	}
	
	//セクションヘッダサイズ
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		switch(section){
		case 0:return _Collection_HeaderSize
		default:return CGSize(width: 0, height: 0)
		}
	}

	//ヘッダセクションを返す
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
	{
		let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CONST_ReuseIdent, for: indexPath) as! CollectionReusableView
		headerView.textLabel?.text = self.getHeaderText()
		headerView.leftButton?.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		headerView.rightButton?.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
		return headerView
	}

	//セルのサイズを設定
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width: CGFloat = collectionView.frame.size.width / CGFloat(CONST_DAYS)
		let height: CGFloat = width
		return CGSize(width:width, height:height)
	}
	
	//セルの垂直方向のマージンを設定
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	//セルの水平方向のマージンを設定
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	//Cellの総数を返す
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch(section){
		case 0:return CONST_DAYS
		case 1:return self._CellItems.count
		default:
			print("error")
			return 0
		}
	}
	
	//Cellに値を設定する
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell : CustomUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CONST_CellIdent, for: indexPath as IndexPath) as! CustomUICollectionViewCell
		cell.backgroundColor = UIColor.white
		cell.isUserInteractionEnabled = false//デフォはクリックできない
		
		switch(indexPath.section){
		case 0 , 1:
			//フォント色
			if((indexPath.row % 7) == 0){ cell.textLabel?.textColor = DayColor.Sun.Colors }
			else{
				if((indexPath.row % 7) == 6){cell.textLabel?.textColor = DayColor.Sat.Colors}
				else{ cell.textLabel?.textColor = DayColor.Week.Colors }
			}
			
			if(indexPath.section == 0){
				cell.textLabel?.text = CONST_WEEK[indexPath.row]
			}
			else{
				//過去のフォント色
				cell.tag = -1
				let _IsPast = self.IsThisMonth(_date: self._CellItems[indexPath.row]) ? false: true
				if(_IsPast){ cell.textLabel?.textColor = UIColor.lightGray }

				//日付抽出
				let calendar = Calendar.current
				let _day = calendar.component(.day,from:self._CellItems[indexPath.row])
				
				//イベントがあれば「注文済」表示
				if(self.IsEvent(_date: self._CellItems[indexPath.row])){
					var _IsLast : Bool = false
					if(!_IsPast){ _IsLast = self._EventList[self._EventList.count - 1] == self._CellItems[indexPath.row] ? true: false }
					
					let attrText = _IsLast ? NSMutableAttributedString(string: "\(_day)\n注文中"): NSMutableAttributedString(string: "\(_day)\n注文済")
					let _beg = _day < 10 ? 1 : 2
					attrText.addAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 24.0)], range: NSMakeRange(0, _beg))
					attrText.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 20)], range: NSMakeRange(_beg, 4))
					if(_IsLast){
						attrText.addAttributes([NSForegroundColorAttributeName: UIColor.red], range: NSMakeRange(_beg, 4))
					}
					
					cell.textLabel?.attributedText = attrText
					cell.isUserInteractionEnabled = true
					cell.tag = _IsPast ? 0 : 1//過去注文は０、未来注文は１
				}
				else{
					cell.textLabel?.text = "\(_day)\n"
					cell.tag = _IsPast ? -1 : 1//過去は−１、未来注文は１
				}
				
				if(cell.tag > -1){ cell.isUserInteractionEnabled = true }
			}
			
		default:
			print("section error")
		}
		
		return cell
	}
	
	//セルクリック時の処理
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
		appDelegate.targetDate = self._CellItems[indexPath.row]
		appDelegate.eventList = self._EventList
		appDelegate.itemSegcon = 0
		
		switch(Int((collectionView.cellForItem(at: indexPath)?.tag)!)){
		case 0:
			let _HistoryViewController : HistoryViewController = HistoryViewController()
			self.navigationController?.pushViewController(_HistoryViewController, animated: true)

		case 1:
			let _SelectItemsViewController : SelectItemsViewController = SelectItemsViewController()
			self.navigationController?.pushViewController(_SelectItemsViewController, animated: true)

		default:
			print("error")
		}

	}
}
