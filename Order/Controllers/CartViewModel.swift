//
//  HistoryViewModel.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/19.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class CartViewModel: NSObject, UITableViewDelegate, UITableViewDataSource{
	
	var shareController : ShareController = ShareController()
	
	public var DataSources : [OrderModel] = []
	
	
	var CONST_SIZE : CGRect!
	var CONST_SECTION = "ご注文商品を確定する"
	
	var CONST_LABEL : [String:String] = [
		"Count":"ご注文数量",
		"Tanka":"ご注文商品単価",
		"Kingaku":"ご注文商品金額",
		]
	
	var myTableView : UITableView!
	
	init(_size:CGRect, _orderlist : [OrderModel]) {
		super.init()
		
		self.DataSources = _orderlist
		
		self.CONST_SIZE = _size
		
		self.myTableView = UITableView(frame: self.CONST_SIZE, style: .grouped)
		self.myTableView.backgroundColor = UIColor.white
		self.myTableView.rowHeight = 70
		self.myTableView.delegate = self
		self.myTableView.dataSource = self
		self.myTableView.register(CartOrderItem.self, forCellReuseIdentifier: NSStringFromClass(CartOrderItem.self))
	}
	
	func getSum() -> String{
		var _sum : Int = 0
		for order in self.DataSources{
			_sum += (order.Tanka * order.Counts)
		}
		
		return shareController.convNum2str(_val: _sum)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return DataSources.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CartOrderItem.self), for: indexPath) as! CartOrderItem
		cell.Name.text = self.DataSources[indexPath.row].Name
		
		cell.Count.text = "\(CONST_LABEL["Count"]!)\n\(shareController.convNum2str(_val: self.DataSources[indexPath.row].Counts))"
		cell.Tanka.text = "\(CONST_LABEL["Tanka"]!)\n\(shareController.convNum2str(_val: self.DataSources[indexPath.row].Tanka))"
		
		let _sum = self.DataSources[indexPath.row].Counts * self.DataSources[indexPath.row].Tanka
		cell.Kingaku.text = "\(CONST_LABEL["Kingaku"]!)\n\(shareController.convNum2str(_val: _sum))"

		let _ItemModels : [ItemModel] = ItemModels().CONST_DEMODATAS
		for itemmodel in _ItemModels{
			if(self.DataSources[indexPath.row].Code == itemmodel.code){
				cell.Photo.image = itemmodel.photo
				break
			}
		}
		
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return CONST_SECTION
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 25))
		
		var _size : CGSize!
		
		let _w = tableView.frame.size.width - 128
		let button : UIButton = UIButton(frame: CGRect(x: tableView.frame.size.width / 2 - (_w/2), y: 0, width: _w, height: 25))
		button.backgroundColor = UIColor.red
		button.setTitle(CONST_SECTION, for: .normal)
		button.layer.cornerRadius = 4.0
		returnedView.addSubview(button)
		
		/*
		let label = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.size.width, height: 25))
		label.text = CONST_SECTION
		label.textColor = UIColor.lightGray
		label.sizeToFit()
		_size = label.frame.size
		label.frame.size = _size
		returnedView.addSubview(label)
		*/

		let sum = UILabel(frame: CGRect(x: 0, y: 7, width: 0, height: 0))
		sum.text = "合計金額：\(getSum())円"
		sum.font = UIFont.systemFont(ofSize: 12)
		sum.textColor = UIColor.red
		sum.sizeToFit()
		_size = sum.frame.size
		sum.frame = CGRect(x: tableView.frame.size.width - _size.width - 16, y: 36, width: _size.width, height: _size.height)
		returnedView.addSubview(sum)
		
		return returnedView
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	}
}

class CartOrderItem: UITableViewCell {
	var Name: UILabel!
	var Count: UILabel!
	var Tanka: UILabel!
	var Kingaku: UILabel!
	var Photo : UIImageView!
	
	var CONST_LABEL_NAME_FONT = UIFont(name: "Arial", size: 18)
	var CONST_LABEL_FONT = UIFont(name: "Arial", size: 12)
	
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		Name = makeLabel(_font: CONST_LABEL_NAME_FONT!)
		contentView.addSubview(Name)
		
		Count = makeLabel(_font: CONST_LABEL_FONT!)
		contentView.addSubview(Count)
		Count.backgroundColor = UIColor.orange
		
		Tanka = makeLabel(_font: CONST_LABEL_FONT!)
		contentView.addSubview(Tanka)
		Tanka.backgroundColor = UIColor.cyan
		
		Kingaku = makeLabel(_font: CONST_LABEL_FONT!)
		contentView.addSubview(Kingaku)
		Kingaku.backgroundColor = UIColor.orange
		
		Photo = UIImageView(frame: CGRect.zero)
		contentView.addSubview(Photo)
	}
	
	func makeLabel(_font : UIFont) -> UILabel{
		let _return : UILabel = UILabel(frame: CGRect.zero)
		_return.textAlignment = .left
		_return.font = _font
		_return.numberOfLines = 2
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
		
		Name.frame = CGRect(x: 72, y: 5, width: frame.width - 100, height: 25)

		Count.frame = CGRect(x: 72, y: 40, width: 60, height: 25)
		Tanka.frame = CGRect(x: Count.frame.origin.x + Count.frame.size.width + 8, y: 40, width: 84, height: 25)
		Kingaku.frame = CGRect(x: Tanka.frame.origin.x + Tanka.frame.size.width + 8, y: 40, width: 84, height: 25)

		Photo.frame = CGRect(x: 4, y: 4, width: 64, height: 64)
	}
	
}
