//
//  PriceRuleViewModel.swift
//  M-Commerce-Admin
//
//  Created by Ziyad Qassem on 28/10/2023.
//

import Foundation
class PriceRuleViewModel {
    var  bindresultToHomeViewController: ( () -> () ) = {}
  private  var networkManager = NetworkManager()
  private  var handerDataOfHome: (() -> Void)?
  private  var AllPriceRule: PriceRuleContainer? {
        didSet{
            if let validHander =  handerDataOfHome {
                validHander()
            }
        }
    }
    //MARK: - Network Functions
    func getAllPriceRules (){
        networkManager.getPriceRule(Handler: { (dataValue:PriceRuleContainer?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.AllPriceRule = mydata
                self.bindresultToHomeViewController()

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    //MARK: - UI Functions
    func getPriceRulesNumber()-> Int {
        return AllPriceRule?.price_rules.count ?? 1
    }
    
    func getpriceRuleTitle(index : Int)-> String {
        return AllPriceRule?.price_rules[index].title ?? "50% Off"
    }
    
    func getStartDate(index : Int) -> String {
        return AllPriceRule?.price_rules[index].starts_at ?? "2023-10-23T12:00:00-04:00"
    } 
    func getEndDate(index : Int) -> String {
        return AllPriceRule?.price_rules[index].ends_at ?? "2023-12-31T11:00:00-05:00"
    }
    func setFourthLabel(index : Int) -> String {
        return AllPriceRule?.price_rules[index].value ?? "50.0%" + "After" + (AllPriceRule?.price_rules[index].prerequisite_subtotal_range.greater_than_or_equal_to ?? "1000$")
    }
    func getMaxUsage(index : Int) -> String {
        return String(AllPriceRule?.price_rules[index].usage_limit ?? 10)
    }
}

