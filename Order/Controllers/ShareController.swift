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
		case Conf = "設定画面"
	}
	
	func getEnumTitle(_tag : Int) -> String{
		switch(_tag){
		case 1:return EnumTitle.Order.rawValue
		default: return EnumTitle.Conf.rawValue
		}
	}
	
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

	//イベントリスト作成
	func makeEventList(_days:[Date]) -> [Date]{
		var _return : [Date] = []

		let _today = Date()
		var _comp = Calendar.current.dateComponents([.year, .month, .day, .hour],from:_today)
		_comp.hour = 9
		_return.append(Calendar.current.date(from: _comp)!)
		
		return _return
	}

}
