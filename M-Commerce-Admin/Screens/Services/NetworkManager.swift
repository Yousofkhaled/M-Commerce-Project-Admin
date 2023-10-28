//
//  NetworkManager.swift
//  M-Commerce-Admin
//
//  Created by Ziyad Qassem on 28/10/2023.
//

import Foundation
import Alamofire
class NetworkManager {
    //MARK: - create price Role
    func createPriceRule(title: String,value_type : String , discountAmount value : Int,starts_at: String, ends_at:String , greater_than_or_equal_to: String,  usage_limit : Int ,Handler : @escaping () -> Void){
       
            let urlFile = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/price_rules.json"
//            
            let body: [String: Any] = [
                  "price_rule": [
                    "title": title,
                    "target_type": "line_item",
                    "target_selection": "all",
                    "allocation_method": "across",
                    "value_type": value_type,
                    "value": Float(-value),
                    "customer_selection": "all",
                    "starts_at": starts_at,
                    "ends_at": ends_at,
                    "usage_limit": usage_limit,
            "price_rule.prerequisite_subtotal_range":["greater_than_or_equal_to": greater_than_or_equal_to]

                  ]
            ]
//        let body: [String: Any] =  [
//          "price_rule": [
//            "title": "mansour Discount",
//            "target_selection": "all",
//            "target_type": "line_item",
//            "allocation_method": "across",
//            "value_type": "percentage",
//            "value": -50.00,
//            "usage_limit": 10,
//            "starts_at": "2023-10-23T16:00:00Z",
//            "customer_selection": "all",
//            "ends_at": "2023-12-31T16:00:00Z",
//            "price_rule.prerequisite_subtotal_range":["greater_than_or_equal_to":"25.0"]
//          ]
//        ]
            AF.request(urlFile ,method: .post, parameters: body, encoding: JSONEncoding.default, headers: ["X-Shopify-Access-Token": "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"]).response{ response in
                switch response.result {
                case .success(_):
                    print("success from create price rule in network manager")
                    Handler()
                    break
                case .failure(let error):
                    print("price rule in network manager")
                    print(error)
                }
            }
        }
    
//    func getPriceRule() {
//          APIManager.shared.request(.get, "https://9ec35bc5ffc50f6db2fd830b0fd373ac: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@ios-q1-new-capital-2023.myshopify.com//admin/api/2023-10/price_rules/1405087318332.json") { (result: Result<PriceMRuleModel, Error>) in
//              switch result {
//              case .success(let priceRule):
//                  self.priceRule = priceRule
//                
//              case .failure(let error):
//                  print("Request failed with error: \(error)")
//              }
//          }
//      }
    
    
}
