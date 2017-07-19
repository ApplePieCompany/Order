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

	public var DataSources : [OrderModel] = []

	
	var CONST_SIZE : CGRect!
	var CONST_SECTION = "ご注文商品"
	
	var myTableView : UITableView!
	
	init(_size:CGRect) {
		super.init()
		
		self.DataSources = shareController.getOrderList()
		
		self.CONST_SIZE = _size

		self.myTableView = UITableView(frame: self.CONST_SIZE, style: .plain)
		self.myTableView.backgroundColor = UIColor.white
		self.myTableView.rowHeight = 60
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
		
		var num = NSNumber(value: self.DataSources[indexPath.row].Count)
		var formatter = NumberFormatter()
		formatter.numberStyle = NumberFormatter.Style.decimal
		formatter.groupingSeparator = ","
		formatter.groupingSize = 3
		cell.Count.text = "ご注文数量\n\(formatter.string(from: num)!)"

		num = NSNumber(value: self.DataSources[indexPath.row].Tanka)
		formatter = NumberFormatter()
		formatter.numberStyle = NumberFormatter.Style.decimal
		formatter.groupingSeparator = ","
		formatter.groupingSize = 3
		cell.Tanka.text = "ご注文商品単価\n@\(formatter.string(from: num)!)"

		let _sum = self.DataSources[indexPath.row].Count * self.DataSources[indexPath.row].Tanka
		num = NSNumber(value: _sum)
		formatter = NumberFormatter()
		formatter.numberStyle = NumberFormatter.Style.decimal
		formatter.groupingSeparator = ","
		formatter.groupingSize = 3
		cell.Kingaku.text = "ご注文商品金額\n¥\(formatter.string(from: num)!)"
		
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return CONST_SECTION
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	}
}

class OrderItem: UITableViewCell {
	var Name: UILabel!
	var Count: UILabel!
	var Tanka: UILabel!
	var Kingaku: UILabel!
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		Name = UILabel(frame: CGRect.zero)
		Name.textAlignment = .left
		Name.font = UIFont(name: "Arial", size: 18)
		Name.adjustsFontSizeToFitWidth = true
		contentView.addSubview(Name)

		Count = UILabel(frame: CGRect.zero)
		Count.textAlignment = .left
		Count.font = UIFont(name: "Arial", size: 14)
		Count.numberOfLines = 2
		Count.baselineAdjustment = .none
		Count.lineBreakMode = .byTruncatingTail
		Count.adjustsFontSizeToFitWidth = true
		contentView.addSubview(Count)

		Tanka = UILabel(frame: CGRect.zero)
		Tanka.textAlignment = .left
		Tanka.font = UIFont(name: "Arial", size: 14)
		Tanka.numberOfLines = 2
		Tanka.baselineAdjustment = .none
		Tanka.lineBreakMode = .byTruncatingTail
		Tanka.adjustsFontSizeToFitWidth = true
		contentView.addSubview(Tanka)

		Kingaku = UILabel(frame: CGRect.zero)
		Kingaku.textAlignment = .left
		Kingaku.font = UIFont(name: "Arial", size: 14)
		Kingaku.numberOfLines = 2
		Kingaku.baselineAdjustment = .none
		Kingaku.lineBreakMode = .byTruncatingTail
		Kingaku.adjustsFontSizeToFitWidth = true
		contentView.addSubview(Kingaku)
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
		Count.frame = CGRect(x: 50, y: 30, width: 150, height: 25)
		Tanka.frame = CGRect(x: 150, y: 30, width: 150, height: 25)
		Kingaku.frame = CGRect(x: 250, y: 30, width: 150, height: 25)
	}
	
}
