//
//  SelectItemsViewController.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/19.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class SelectItemsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

	var shareController : ShareController = ShareController()
	
	var myCollectionView:UICollectionView!
	var myCalender : Date!

	var CONST_TAG = 12
	var CONST_FRAMESIZE : CGSize!
	var CONST_CellIdent = "MyCell"
	var CONST_ReuseIdent = "Section"
	var CONST_SECTION = 2
	var CONST_TAGS : [String:Int] = ["Select":100, "List":200]

	var _Layout_itemSize : CGSize!
	var _Layout_headerReferenceSize = CGSize(width:0,height:8)
	var _Layout_sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
	
	var _Collection_Frame : CGRect!
	var _Collection_HeaderSize : CGSize!

	var _CellItems: [Date] = []
	var _EventList : [Date] = []
	var _ItemList : [ItemModel] = []
	
	
	init() {
		super.init(nibName: nil, bundle: nil)
		
		self.title = shareController.getEnumTitle(_tag: CONST_TAG)
		
		let _ItemModels : ItemModels = ItemModels()
		self._ItemList = _ItemModels.makeList()
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
		self._EventList = appDelegate.eventList

		self.CONST_FRAMESIZE = CGSize(width: self.view.frame.width, height: self.view.frame.height)
		
		self._Layout_itemSize = CGSize(width:CONST_FRAMESIZE.width, height:CONST_FRAMESIZE.height / 11)
		self._Collection_Frame = CGRect(x: 0, y: 0, width: CONST_FRAMESIZE.width, height:CONST_FRAMESIZE.height - 49)
		self._Collection_HeaderSize = CGSize(width: CONST_FRAMESIZE.width, height: 40)
		
		self.myCollectionView = self.getCollectionView()
		self.view.addSubview(self.myCollectionView)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// Calender CollectionView
	func getCollectionView() -> UICollectionView{
		var _return:UICollectionView!
		
		let _Layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		_Layout.itemSize = _Layout_itemSize
		//		_Layout.headerReferenceSize = _Layout_headerReferenceSize
		//		_Layout.sectionInset = _Layout_sectionInset
		
		// CollectionViewを生成.
		_return = UICollectionView(frame: _Collection_Frame, collectionViewLayout: _Layout)
		_return.tag = CONST_TAGS["Select"]!
		_return.backgroundColor = UIColor.white
		_return.register(SelectCustomUICollectionViewCell.self, forCellWithReuseIdentifier: CONST_CellIdent)
		_return.register(SelectCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CONST_ReuseIdent)
		_return.delegate = self
		_return.dataSource = self
		
		return _return
	}
	
	// Calender CollectionView Header
	func getHeaderText() -> String{
		return "<<HEADER>>"
	}

	internal func segconChanged(segcon: UISegmentedControl){
		
		switch segcon.selectedSegmentIndex {
		case 0:
			if(self.view.viewWithTag(CONST_TAGS["List"]!) != nil){
				let _View = self.view.viewWithTag(CONST_TAGS["List"]!)
				_View?.removeFromSuperview()
			}

		case 1:
			if(self.view.viewWithTag(CONST_TAGS["Select"]!) != nil){
				let _View = self.view.viewWithTag(CONST_TAGS["Select"]!)
				_View?.removeFromSuperview()
			}
			
		default:
			print("Error")
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
		switch(section){
		case 0:return _Collection_HeaderSize
		default:return CGSize(width: 0, height: 0)
		}
	}
	
	//ヘッダセクションを返す
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
	{
		var _idx = 0
		for i in 0..<self._EventList.count{
			if(self._EventList[i] == self.myCalender){
				_idx = 1
				break
			}
		}
		
		let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CONST_ReuseIdent, for: indexPath) as! SelectCollectionReusableView
		headerView.backgroundColor = UIColor.lightGray
		headerView.mySegcon?.selectedSegmentIndex = _idx
		headerView.mySegcon?.addTarget(self, action: #selector(self.segconChanged(segcon:)), for: UIControlEvents.valueChanged)
		return headerView
	}
	
	//セルのサイズを設定
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width: CGFloat = collectionView.frame.size.width
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
		case 0:return 1
		case 1:return self._ItemList.count
		default:
			print("error")
			return 0
		}
	}
	
	//Cellに値を設定する
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell : SelectCustomUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CONST_CellIdent, for: indexPath as IndexPath) as! SelectCustomUICollectionViewCell
		cell.backgroundColor = UIColor.white
		cell.isUserInteractionEnabled = false//デフォはクリックできない
		
		switch(indexPath.section){
		case 0 , 1:
			if(indexPath.section == 0){
				cell.name?.text = "　　　【商品一覧】"
				cell.tanka?.text = nil
			}
			else{
				cell.imageView.image = self._ItemList[indexPath.row].photo
				cell.name?.text = self._ItemList[indexPath.row].name
				cell.tanka?.text = "@"+shareController.convNum2str(_val: self._ItemList[indexPath.row].tanka)
				cell.isUserInteractionEnabled = true
			}
			
		default:
			print("section error")
		}
		
		return cell
	}
	
	//セルクリック時の処理
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(self._ItemList[indexPath.row])
	}
}

// 4 CollectionView Header
class SelectCollectionReusableView: UICollectionReusableView {

	var mySegcon: UISegmentedControl?
	let myArray: NSArray = ["商品選択","買い物かご"]
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		let attrForeCOlor = [ NSForegroundColorAttributeName: UIColor.blue ]
		
		mySegcon = UISegmentedControl(items: myArray as [AnyObject])
		mySegcon?.setTitleTextAttributes(attrForeCOlor, for: UIControlState.selected)
		mySegcon?.center = CGPoint(x: frame.width/2, y: 20)
		mySegcon?.backgroundColor = UIColor.blue
		mySegcon?.tintColor = UIColor.white
		mySegcon?.layer.cornerRadius = 5
		self.addSubview(mySegcon!)
	}
}

// 4 CollectionView Cell
class SelectCustomUICollectionViewCell : UICollectionViewCell{
	var imageView : UIImageView!
	var name : UILabel?
	var tanka : UILabel?
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		imageView = UIImageView(frame: CGRect(x: 8, y: 0, width: 48, height: 48))
		self.contentView.addSubview(imageView)
		
		name = UILabel(frame: CGRect(x:64, y:0, width:300, height:frame.height))
		name?.text = "nil"
		name?.baselineAdjustment = .none
		name?.lineBreakMode = .byTruncatingTail
		name?.textAlignment = NSTextAlignment.left
		name?.adjustsFontSizeToFitWidth = true
		self.contentView.addSubview(name!)

		tanka = UILabel(frame: CGRect(x:frame.width-65, y:0, width:55, height:frame.height))
		tanka?.text = "nil"
		tanka?.baselineAdjustment = .none
		tanka?.lineBreakMode = .byTruncatingTail
		tanka?.textAlignment = NSTextAlignment.right
		tanka?.adjustsFontSizeToFitWidth = true
		self.contentView.addSubview(tanka!)
	}
}

