//
//  OrderModel.swift
//  Order
//
//  Created by TatsuoYagi on 2017/07/19.
//  Copyright © 2017年 TatsuoYagi. All rights reserved.
//

import UIKit

class OrderModel: NSObject {

	public var Seq : Int!
	public var ItemName : String!

	init(_Seq : Int, _ItemName : String) {
		self.Seq = _Seq
		self.ItemName = _ItemName
	}

}
