//
//  DiscountModel.swift
//  M-Commerce-Admin
//
//  Created by Ziyad Qassem on 28/10/2023.
//

import Foundation
struct DiscountContainer :Codable {
    var discount_codes : [DiscountCode]
}
struct DiscountCode : Codable {
    let id : Int
    let price_rule_id : Int
    let usage_count : Int
    let code : String
}
