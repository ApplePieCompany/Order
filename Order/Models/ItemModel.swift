//
//  ItemModel.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/22.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class ItemModel: NSObject {
	
	public var code : String!
	public var name : String!
	public var tanka : Int!
	public var photo : UIImage!
	
	init(_code : String, _name : String, _tanka : Int, _photo : UIImage){
		self.code = _code
		self.name = _name
		self.tanka = _tanka
		self.photo = _photo
	}
}

class ItemModels: NSObject{

	var CONST_DEMODATAS : [ItemModel] = [
		ItemModel(_code: "Item_01", _name: "商品名０１", _tanka: 100, _photo: UIImage(named: "うな重.jpg")!),
		ItemModel(_code: "Item_02", _name: "商品名０２", _tanka: 200, _photo: UIImage(named: "おにぎり.jpg")!),
		ItemModel(_code: "Item_03", _name: "商品名０３", _tanka: 300, _photo: UIImage(named: "オムライス.jpg")!),
		ItemModel(_code: "Item_04", _name: "商品名０４", _tanka: 400, _photo: UIImage(named: "かつ丼.jpg")!),
		ItemModel(_code: "Item_05", _name: "商品名０５", _tanka: 500, _photo: UIImage(named: "から揚げ定食.jpg")!),
		ItemModel(_code: "Item_06", _name: "商品名０６", _tanka: 600, _photo: UIImage(named: "カレーライス.jpg")!),
		ItemModel(_code: "Item_07", _name: "商品名０７", _tanka: 700, _photo: UIImage(named: "ハヤシライス.jpg")!),
		ItemModel(_code: "Item_08", _name: "商品名０８", _tanka: 800, _photo: UIImage(named: "海鮮丼.jpg")!),
		ItemModel(_code: "Item_09", _name: "商品名０９", _tanka: 900, _photo: UIImage(named: "鮭の定食.jpg")!),
		ItemModel(_code: "Item_10", _name: "商品名１０", _tanka: 1000, _photo: UIImage(named: "焼肉定食.jpg")!),
		ItemModel(_code: "Item_11", _name: "商品名１１", _tanka: 1100, _photo: UIImage(named: "親子丼.jpg")!),
		ItemModel(_code: "Item_12", _name: "商品名１２", _tanka: 1200, _photo: UIImage(named: "生姜焼き定食.jpg")!),
		ItemModel(_code: "Item_13", _name: "商品名１３", _tanka: 1300, _photo: UIImage(named: "天丼.jpg")!)
	]
	
	func makeList() -> [ItemModel]{
		return CONST_DEMODATAS
	}
	
}
