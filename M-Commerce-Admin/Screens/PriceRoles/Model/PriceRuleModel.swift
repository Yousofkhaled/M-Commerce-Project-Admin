//
//  PriceRuleModel.swift
//  M-Commerce-Admin
//
//  Created by Ziyad Qassem on 28/10/2023.
//

import Foundation
struct PriceRuleContainer : Codable{
    let price_rule : PriceRuleModel
}
struct  PriceRuleModel : Codable {
    var  id : Int
    var  value  : String
    var value_type : String
    var usage_limit : Int
    var starts_at : String
    var ends_at : String
    var prerequisite_subtotal_range : SubtotalRange
}
struct SubtotalRange : Codable{
    var greater_than_or_equal_to : String
}
//[06:47, 28/10/2023] Yousof Khaled: "prerequisite_subtotal_range": {
//    "greater_than_or_equal_to": "40.0"
//  },
//[06:48, 28/10/2023] Yousof Khaled: "usage_limit": 10

//{
//  "price_rule": {
//    "title": "Coupon name",
//    "target_type": "line_item",
//    "target_selection": "all",
//    "allocation_method": "across",
//    "value_type": "percentage",
//    "value": -10.00,
//    "customer_selection": "all",
//    "starts_at": "2023-10-23T16:00:00Z",
//    "ends_at": "2023-12-31T16:00:00Z"
//  }
//}
