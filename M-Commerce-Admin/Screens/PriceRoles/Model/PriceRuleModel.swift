//
//  PriceRuleModel.swift
//  M-Commerce-Admin
//
//  Created by Ziyad Qassem on 28/10/2023.
//

import Foundation
struct PriceRuleContainer : Codable{
    let price_rules : [PriceRuleModel]
}
struct  PriceRuleModel : Codable {
    var  id : Int?
    var  value  : String?
    var value_type : String?
    var usage_limit : Int?
    var starts_at : String?
    var ends_at : String?
    var title : String?
    var prerequisite_subtotal_range : SubtotalRange?
}
struct SubtotalRange : Codable{
    var greater_than_or_equal_to : String?
}

