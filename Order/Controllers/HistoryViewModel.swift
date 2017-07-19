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
		self.myTableView.rowHeight = 50
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
		cell.itemName.text = self.DataSources[indexPath.row].ItemName
		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return CONST_SECTION
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	}
}

class OrderItem: UITableViewCell {
	var itemName: UILabel!
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		itemName = UILabel(frame: CGRect.zero)
		itemName.textAlignment = .left
		contentView.addSubview(itemName)

	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder: ) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		itemName.frame = CGRect(x: 8, y: 0, width: frame.width - 100, height: frame.height)
	}
	
}
