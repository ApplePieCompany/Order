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
	public var category : Int!
	public var ingradient : Ingradient!
	public var bilingual : Bilingual!
	
	init(_code : String, _name : String, _tanka : Int, _photo : UIImage, _category:Int = -1, _ingradient : Ingradient, _bilingual: Bilingual){
		self.code = _code
		self.name = _name
		self.tanka = _tanka
		self.photo = _photo
		self.category = _category
		self.ingradient = _ingradient
		self.bilingual = _bilingual
	}
}

class Ingradient{
	public var egg : Bool!
	public var rice : Bool!
	public var pork : Bool!
	
	init(_egg: Bool = false, _rice:Bool = false, _pork: Bool = false){
		self.egg = _egg
		self.rice = _rice
		self.pork = _pork
	}
	
	init(){
		let _rnd : Int = Int(arc4random() % 8)
		
		switch(_rnd){
		case 0: self.egg = false; self.rice = false; self.pork = false
		case 1: self.egg = false; self.rice = false; self.pork = true
		case 2: self.egg = false; self.rice = true; self.pork = false
		case 3: self.egg = false; self.rice = true; self.pork = true
		case 4: self.egg = true; self.rice = false; self.pork = false
		case 5: self.egg = true; self.rice = false; self.pork = true
		case 6: self.egg = true; self.rice = true; self.pork = false
		case 7: self.egg = true; self.rice = true; self.pork = true
		default: print("")
		}
	}
	
}

class Bilingual{
	public var english : String!
	public var korean : String!
	public var chinese : String!
	
	init(_english : String = "", _korean : String = "", _chinese : String = ""){
		self.english = _english
		self.korean = _korean
		self.chinese = _chinese
	}
	
	init(){
		self.english = "English name is ..."; self.korean = "Korrean name is ..."; self.chinese = "Chinese name is ..."
	}
}

class ItemModels: NSObject{
	var CONST_DEMODATAS : [ItemModel] = [
		ItemModel(_code: "Item_001", _name: "うな重", _tanka: 100, _photo: UIImage(named: "うな重.jpg")!, _category:0, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_002", _name: "かつ丼", _tanka: 200, _photo: UIImage(named: "かつ丼.jpg")!, _category:0, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_003", _name: "天丼", _tanka: 300, _photo: UIImage(named: "天丼.jpg")!, _category:0, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_004", _name: "親子丼", _tanka: 400, _photo: UIImage(named: "親子丼.jpg")!, _category:0, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_005", _name: "海鮮丼", _tanka: 500, _photo: UIImage(named: "海鮮丼.jpg")!, _category:0, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_006", _name: "めっちゃうまいうな重", _tanka: 600, _photo: UIImage(named: "うな重.jpg")!, _category:0, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_007", _name: "めっちゃうまいかつ丼", _tanka: 700, _photo: UIImage(named: "かつ丼.jpg")!, _category:0, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_008", _name: "めっちゃうまい天丼", _tanka: 800, _photo: UIImage(named: "天丼.jpg")!, _category:0, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_009", _name: "めっちゃうまい親子丼", _tanka: 900, _photo: UIImage(named: "親子丼.jpg")!, _category:0, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_010", _name: "めっちゃうまい海鮮丼", _tanka: 1000, _photo: UIImage(named: "海鮮丼.jpg")!, _category:0, _ingradient: Ingradient(), _bilingual: Bilingual()),

		ItemModel(_code: "Item_101", _name: "から揚げ定食", _tanka: 110, _photo: UIImage(named: "から揚げ定食.jpg")!, _category:1, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_102", _name: "鮭の定食", _tanka: 210, _photo: UIImage(named: "鮭の定食.jpg")!, _category:1, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_103", _name: "焼肉定食", _tanka: 310, _photo: UIImage(named: "焼肉定食.jpg")!, _category:1, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_104", _name: "生姜焼き定食", _tanka: 410, _photo: UIImage(named: "生姜焼き定食.jpg")!, _category:1, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_105", _name: "大盛りから揚げ定食", _tanka: 510, _photo: UIImage(named: "から揚げ定食.jpg")!, _category:1, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_106", _name: "大盛り鮭の定食", _tanka: 610, _photo: UIImage(named: "鮭の定食.jpg")!, _category:1, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_107", _name: "大盛り焼肉定食", _tanka: 710, _photo: UIImage(named: "焼肉定食.jpg")!, _category:1, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_108", _name: "大盛り生姜焼き定食", _tanka: 810, _photo: UIImage(named: "生姜焼き定食.jpg")!, _category:1, _ingradient: Ingradient(), _bilingual: Bilingual()),

		ItemModel(_code: "Item_201", _name: "カレーライス", _tanka: 120, _photo: UIImage(named: "カレーライス.jpg")!, _category:2, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_202", _name: "ハヤシライス", _tanka: 220, _photo: UIImage(named: "ハヤシライス.jpg")!, _category:2, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_203", _name: "オムライス", _tanka: 320, _photo: UIImage(named: "オムライス.jpg")!, _category:2, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_204", _name: "めっさ美味しいカレーライス", _tanka: 420, _photo: UIImage(named: "カレーライス.jpg")!, _category:2, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_205", _name: "めっさ美味しいハヤシライス", _tanka: 520, _photo: UIImage(named: "ハヤシライス.jpg")!, _category:2, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_206", _name: "めっさ美味しいオムライス", _tanka: 620, _photo: UIImage(named: "オムライス.jpg")!, _category:2, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_207", _name: "でらうみゃぁカレーライス", _tanka: 720, _photo: UIImage(named: "カレーライス.jpg")!, _category:2, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_208", _name: "でらうみゃぁハヤシライス", _tanka: 820, _photo: UIImage(named: "ハヤシライス.jpg")!, _category:2, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_209", _name: "でらうみゃぁオムライス", _tanka: 920, _photo: UIImage(named: "オムライス.jpg")!, _category:2, _ingradient: Ingradient(), _bilingual: Bilingual()),

		ItemModel(_code: "Item_301", _name: "おにぎり３０１", _tanka: 130, _photo: UIImage(named: "おにぎり.jpg")!, _category:3, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_302", _name: "おにぎり３０２", _tanka: 230, _photo: UIImage(named: "おにぎり.jpg")!, _category:3, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_303", _name: "おにぎり３０３", _tanka: 330, _photo: UIImage(named: "おにぎり.jpg")!, _category:3, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_304", _name: "おにぎり３０４", _tanka: 430, _photo: UIImage(named: "おにぎり.jpg")!, _category:3, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_305", _name: "おにぎり３０５", _tanka: 530, _photo: UIImage(named: "おにぎり.jpg")!, _category:3, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_306", _name: "おにぎり３０６", _tanka: 630, _photo: UIImage(named: "おにぎり.jpg")!, _category:3, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_307", _name: "おにぎり３０７", _tanka: 730, _photo: UIImage(named: "おにぎり.jpg")!, _category:3, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_308", _name: "おにぎり３０８", _tanka: 830, _photo: UIImage(named: "おにぎり.jpg")!, _category:3, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_309", _name: "おにぎり３０９", _tanka: 930, _photo: UIImage(named: "おにぎり.jpg")!, _category:3, _ingradient: Ingradient(), _bilingual: Bilingual()),
		ItemModel(_code: "Item_310", _name: "おにぎり３１０", _tanka: 1030, _photo: UIImage(named: "おにぎり.jpg")!, _category:3, _ingradient: Ingradient(), _bilingual: Bilingual())
	]
	
	func getItems(_category: Int, _current: Int) -> [ItemModel]{
		var _return : [ItemModel] = []
		
		let _ItemModels : ItemModels = ItemModels()
		let _min : Int!
		var _max : Int!
		var _targetItems : [ItemModel] = _ItemModels.makeList(_category: _category)
		
		if(_current == 0){ _min = 0 }
		else{
			if(_current == _targetItems.count - 1){
				_min = _current - 2
			}
			else{ _min = _current - 1 }
		}
		_max = _min + 2
		
		for i in _min..._max{
			_return.append(_targetItems[i])
		}
		
		return _return
	}
	
	func makeList(_category: Int) -> [ItemModel]{
		var _return : [ItemModel] = []
		
		for itemmodel in CONST_DEMODATAS{
			if(itemmodel.category == _category){ _return.append(itemmodel) }
		}
		
		return _return
	}
	
}
