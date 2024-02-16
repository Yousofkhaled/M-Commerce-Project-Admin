//
//  PriceRuleViewModel.swift
//  M-Commerce-Admin
//
//  Created by Ziyad Qassem on 28/10/2023.
//

import Foundation
class AddPriceRulediscountViewModel {
    var Manager = NetworkManager()
    
    var  bindresultToHomeViewController: ( () -> () ) = {}

    
    func addPriceRule(title: String,value_type : String , discountAmount value : Int,starts_at: String, ends_at:String , greater_than_or_equal_to: String,usage_limit : Int){
        Manager.createPriceRule(title: title, value_type: value_type, discountAmount: value, starts_at: starts_at, ends_at: ends_at, greater_than_or_equal_to: greater_than_or_equal_to, usage_limit: usage_limit) {
            
            self.bindresultToHomeViewController()
            
            print("add is successful in PriceRuleViewModel view model")
        }
    }
}
