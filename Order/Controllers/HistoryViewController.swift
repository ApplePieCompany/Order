//
//  HistoryViewController.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/18.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

	var shareController : ShareController = ShareController()

	var myCollectionView:UICollectionView!
	var myCalender : Date!
	
	var CONST_TAG = 11
	var CONST_FRAMESIZE : CGSize!
	let CONST_WEEK = ["","日", "月", "火", "水", "木", "金", "土"]
	var CONST_CellIdent = "MyCell"
	var CONST_ReuseIdent = "Section"
	var CONST_SECTION = 1
	var CONST_FORMATTER = "yyyy年MM月dd日"
	
	var _Layout_itemSize : CGSize!
	var _Layout_headerReferenceSize = CGSize(width:0,height:10)
	var _Layout_sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
	
	var _Collection_Frame : CGRect!
	var _Collection_HeaderSize : CGSize!
	
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
		
		self._Layout_itemSize = CGSize(width:CONST_FRAMESIZE.width, height:CONST_FRAMESIZE.height / 11)
		self._Collection_Frame = CGRect(x: 0, y: 110, width: CONST_FRAMESIZE.width, height:CONST_FRAMESIZE.height)
		self._Collection_HeaderSize = CGSize(width: CONST_FRAMESIZE.width, height: 30)
		
		let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
		self.myCalender = appDelegate.targetDate
		self.makeCellItems()
		
		self.view.addSubview(self.makeHeader())
		
		self.myCollectionView = self.getCollectionView()
		self.view.addSubview(myCollectionView)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	//Make Header
	func makeHeader() -> UIView{
		let _return : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 110))
		
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

	//Make CellItems
	func makeCellItems(){
		self._CellItems = shareController.getOrderList()
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
		_return.register(HistoryCustomUICollectionViewCell.self, forCellWithReuseIdentifier: CONST_CellIdent)
		_return.register(HistoryCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CONST_ReuseIdent)
		_return.delegate = self
		_return.dataSource = self
		
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
			var _idx = -1
			if(sender.tag==2){ _idx = 1 }
			
			self.myCalender = shareController.addCalendar(_date: self.myCalender, _month: _idx)
			self.makeCellItems()
			myCollectionView.reloadData()
			
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

	/*          */
	/* DELEGATE */
	/*          */
	
	//セクション数
	internal func numberOfSections(in collectionView: UICollectionView) -> Int {
		return CONST_SECTION
	}
	
	//セクションヘッダサイズ
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return _Collection_HeaderSize
	}

	//ヘッダセクションを返す
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
	{
		let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CONST_ReuseIdent, for: indexPath) as! HistoryCollectionReusableView
		return headerView
	}

	//セルのサイズを設定
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width: CGFloat = 100
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
		return self._CellItems.count
	}
	
	//Cellに値を設定する
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell : HistoryCustomUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CONST_CellIdent, for: indexPath as IndexPath) as! HistoryCustomUICollectionViewCell
		cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.white : UIColor.lightGray
		cell.isUserInteractionEnabled = false//デフォはクリックできない
		
		cell.seq?.text = String( _CellItems[indexPath.row].Seq)
		cell.itemName?.text = _CellItems[indexPath.row].ItemName
		
		return cell
	}
	
	//セルクリック時の処理
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
	}
}

// 4 HistoryCollectionView Header
class HistoryCollectionReusableView: UICollectionReusableView {
	var seq : UILabel?
	var itemName : UILabel?
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		seq = UILabel(frame: CGRect(x:0, y:10, width:frame.width, height:frame.height))
		seq?.text = "No"
		seq?.textAlignment = NSTextAlignment.center
		seq?.font = UIFont(name: "Arial", size: 22)
		self.addSubview(seq!)

		itemName = UILabel(frame: CGRect(x:50, y:10, width:frame.width, height:frame.height))
		itemName?.text = "商品名"
		itemName?.textAlignment = NSTextAlignment.center
		itemName?.font = UIFont(name: "Arial", size: 22)
		self.addSubview(itemName!)
	}
}

// 4 HistoryCollectionView Cell
class HistoryCustomUICollectionViewCell : UICollectionViewCell{
	var seq : UILabel?
	var itemName : UILabel?
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		seq = UILabel(frame: CGRect(x:0, y:0, width:frame.width, height:frame.height))
		seq?.text = "nil"
		seq?.baselineAdjustment = .none
		seq?.lineBreakMode = .byTruncatingTail
		seq?.textAlignment = NSTextAlignment.center
		seq?.adjustsFontSizeToFitWidth = true
		self.contentView.addSubview(seq!)
		
		itemName = UILabel(frame: CGRect(x:50, y:0, width:frame.width, height:frame.height))
		itemName?.text = "nil"
		itemName?.baselineAdjustment = .none
		itemName?.lineBreakMode = .byTruncatingTail
		itemName?.textAlignment = NSTextAlignment.center
		itemName?.adjustsFontSizeToFitWidth = true
		self.contentView.addSubview(itemName!)
	}
}
