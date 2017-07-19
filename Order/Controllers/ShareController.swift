//
//  ShareController.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/14.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class ShareController: NSObject {
	
	enum EnumTitle : String{
		case Order = "注文画面"
		case History = "注文履歴画面"
		case Conf = "設定画面"
	}
	
	//タイトル取得
	func getEnumTitle(_tag : Int) -> String{
		switch(_tag){
		case 1:return EnumTitle.Order.rawValue
		case 11:return EnumTitle.History.rawValue
		case 2:return EnumTitle.Conf.rawValue
		default: return EnumTitle.Conf.rawValue
		}
	}
	
	//日付加算処理
	func addCalendar(_date : Date, _year : Int=0, _month : Int=0, _day:Int=0, _hour : Int=0, _minute : Int=0, _second:Int=0) -> Date{
		var _return : Date = _date
		let calendar = Calendar.current

		_return = calendar.date(byAdding: .year, value: _year, to: calendar.startOfDay(for: _return))!
		_return = calendar.date(byAdding: .month, value: _month, to: calendar.startOfDay(for: _return))!
		_return = calendar.date(byAdding: .day, value: _day, to: calendar.startOfDay(for: _return))!
		_return = calendar.date(byAdding: .hour, value: _hour, to: calendar.startOfDay(for: _return))!
		_return = calendar.date(byAdding: .minute, value: _minute, to: calendar.startOfDay(for: _return))!
		_return = calendar.date(byAdding: .second, value: _second, to: calendar.startOfDay(for: _return))!

		return _return
	}
	
	//月初・月末・期間取得
	func getCalendarDays(_date:Date) -> (beg:Date,end:Date){
		var comp = Calendar.current.dateComponents([.year, .month, .day, .hour],from:_date)
		comp.day = 1
		comp.hour = 9
		let _firstDay =  Calendar.current.date(from: comp)!

		var components = Calendar.current.dateComponents([.year, .month, .day, .hour],from:_firstDay)
		components.month = 1
		components.day = -1
		components.hour = 9
		
		let calendar = Calendar.current
		let range = calendar.range(of: .day, in: .month, for: _firstDay)
		var component = Calendar.current.dateComponents([.year, .month, .day, .hour],from:_firstDay)
		component.day = range?.count
		component.hour = 9
		let _lastDay = Calendar.current.date(from: component)!
		
		let _From : Date = self.getBeginDay(_date: _firstDay)
		let _To : Date = self.getEndDay(_date: _lastDay)
		return (_From,_To)
	}

	//カレンダー初日取得
	func getBeginDay(_date:Date) -> Date{
		let calendar = Calendar.current
		let span = -1 * (calendar.component(.weekday, from: _date) - 2)
		
		var comp = Calendar.current.dateComponents([.year, .month, .day, .hour],from:_date)
		comp.day = span
		comp.hour = 9
		
		let _return =  Calendar.current.date(from: comp)!
		return _return
	}
	
	//カレンダー終日取得
	func getEndDay(_date:Date) -> Date{
		var _return = _date
		
		let calendar = Calendar.current
		let span = 7 - calendar.component(.weekday, from: _date)
		
		if(span>0){
			var comp = Calendar.current.dateComponents([.year, .month, .day, .hour],from:_date)
			let _month = comp.month
			comp.month = _month! + 1
			comp.day = span
			comp.hour = 9
			_return =  Calendar.current.date(from: comp)!
		}

		return _return
	}
	
	//表示カレンダー作成
	func makeCalendar(beg:Date,end:Date) -> [Date]{
		var _return : [Date] = []
		
		var comp = Calendar.current.dateComponents([.year, .month, .day, .hour],from:beg)
		comp.hour = 9
		let _day = comp.day

		let calendar = Calendar.current
		let _diff : Int = calendar.dateComponents([.day], from: beg, to: end).day!

		for i in 0..._diff{
			comp.day = _day! + i
			_return.append(Calendar.current.date(from: comp)!)
		}

		return _return
	}

	//イベントリスト作成（ほんとはここでDB舐める）
	func makeEventList(_days:[Date]) -> [Date]{
		var _return : [Date] = []
		let _max = min(Int(arc4random_uniform(UInt32(_days.count))), 10)

		var _temp : [Date] = shuffleArray(_ary: _days)
		for i in 0..<_max{
			_return.append(_temp[i])
		}
		
		return _return
	}

	//配列シャッフル
	func shuffleArray(_ary:[Date]) -> [Date] {
		var _return = [Date]()

		var indexes = (0 ..< _ary.count).map { $0 }
		while indexes.count > 0 {
			let indexOfIndexes = Int(arc4random_uniform(UInt32(indexes.count)))
			let index = indexes[indexOfIndexes]
			_return.append(_ary[index])
			indexes.remove(at: indexOfIndexes)
		}

		return _return
	}

	//サンプルオーダーリスト作成（ほんとはここでDB舐める）
	func getOrderList() -> [OrderModel]{
		var _return : [OrderModel] = []

		let CONST_NAME = "商品名"
		let CONST_COUNT = Int(arc4random_uniform(25))

		for i in 0..<CONST_COUNT{
			let _no = (i+1)
			_return.append(OrderModel(_Name: "\(CONST_NAME)_\(_no)", _Count : _no, _Tanka : 100))
		}
		
		return _return
	}

}
