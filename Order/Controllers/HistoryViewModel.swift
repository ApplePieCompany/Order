//
//  HistoryViewModel.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/19.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class HistoryViewModel: NSObject, UITableViewDelegate, UITableViewDataSource{

	var shareController : ShareController = ShareController()

	public var myCalendar:Date!
	public var DataSources : [OrderModel] = []

	
	var CONST_SIZE : CGRect!
	var CONST_SECTION = "ご注文商品"
	
	var CONST_LABEL : [String:String] = [
		"Count":"ご注文数量",
		"Tanka":"ご注文商品単価",
		"Kingaku":"ご注文商品金額",
	]
	
	var myTableView : UITableView!
	
	init(_size:CGRect, _date:Date) {
		super.init()
		
		self.myCalendar = _date
		self.DataSources = shareController.getOrderList(_date:self.myCalendar)
		
		self.CONST_SIZE = _size

		self.myTableView = UITableView(frame: self.CONST_SIZE, style: .grouped)
		self.myTableView.backgroundColor = UIColor.white
		self.myTableView.rowHeight = 70
		self.myTableView.delegate = self
		self.myTableView.dataSource = self
		self.myTableView.register(OrderItem.self, forCellReuseIdentifier: NSStringFromClass(OrderItem.self))
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return DataSources.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(OrderItem.self), for: indexPath) as! OrderItem
		cell.Name.text = self.DataSources[indexPath.row].Name
		
		cell.Count.text = "\(CONST_LABEL["Count"]!)\n\(self.makeCell(_val: self.DataSources[indexPath.row].Count))"
		cell.Tanka.text = "\(CONST_LABEL["Tanka"]!)\n\(self.makeCell(_val: self.DataSources[indexPath.row].Tanka))"

		let _sum = self.DataSources[indexPath.row].Count * self.DataSources[indexPath.row].Tanka
		cell.Kingaku.text = "\(CONST_LABEL["Kingaku"]!)\n\(self.makeCell(_val: _sum))"

		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return CONST_SECTION
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	}
	
	//4 Cell
	func makeCell(_val : Int) -> String{
		let num = NSNumber(value: _val)
		let formatter = NumberFormatter()
		formatter.numberStyle = NumberFormatter.Style.decimal
		formatter.groupingSeparator = ","
		formatter.groupingSize = 3
		return formatter.string(from: num)!
	}
}

class OrderItem: UITableViewCell {
	var Name: UILabel!
	var Count: UILabel!
	var Tanka: UILabel!
	var Kingaku: UILabel!
	
	var CONST_LABEL_NAME_FONT = UIFont(name: "Arial", size: 18)
	var CONST_LABEL_FONT = UIFont(name: "Arial", size: 14)
	
	var CONST_LABEL_CGRECT : [String : CGRect] = [
		"Count" : CGRect(x: 20, y: 40, width: 100, height: 25),
		"Tanka" : CGRect(x: 130, y: 40, width: 100, height: 25),
		"Kingaku" : CGRect(x: 240, y: 40, width: 100, height: 25),
	]
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		Name = makeLabel(_font: CONST_LABEL_NAME_FONT!)
		contentView.addSubview(Name)

		Count = makeLabel(_rect : CONST_LABEL_CGRECT["Count"]!)
		contentView.addSubview(Count)

		Tanka = makeLabel(_rect : CONST_LABEL_CGRECT["Tanka"]!)
		contentView.addSubview(Tanka)

		Kingaku = makeLabel(_rect : CONST_LABEL_CGRECT["Kingaku"]!)
		contentView.addSubview(Kingaku)
	}
	
	func makeLabel(_font : UIFont) -> UILabel{
		let _return : UILabel = UILabel(frame: CGRect.zero)
		_return.textAlignment = .left
		_return.font = _font
		_return.adjustsFontSizeToFitWidth = true
		return _return
	}

	func makeLabel(_rect: CGRect) -> UILabel{
		let _return : UILabel = UILabel(frame: _rect)
		_return.textAlignment = .center
		_return.font = CONST_LABEL_FONT
		_return.numberOfLines = 2
		_return.baselineAdjustment = .none
		_return.lineBreakMode = .byTruncatingTail
		_return.adjustsFontSizeToFitWidth = true
		return _return
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder: ) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()

		Name.frame = CGRect(x: 8, y: 5, width: frame.width - 100, height: 25)
		/*
		Count.frame = CONST_LABEL_CGRECT["Count"]!
		Tanka.frame = CONST_LABEL_CGRECT["Tanka"]!
		Kingaku.frame = CONST_LABEL_CGRECT["Kingaku"]!
		*/
	}
	
}
