//
//  OrderModel.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/19.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class OrderModel: NSObject {

	public var OrderYMD : Date!
	public var Code : String!
	public var Name : String!
	public var Counts : Int!
	public var Tanka : Int!

	override init(){		
	}
	
	init(_OrderYMD : Date = Date(), _Code : String = "", _Name : String, _Counts : Int, _Tanka : Int) {
		self.OrderYMD = _OrderYMD
		self.Code = _Code
		self.Name = _Name
		self.Counts = _Counts
		self.Tanka = _Tanka
	}

}
