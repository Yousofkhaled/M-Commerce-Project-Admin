//
//  DiscountCodeViewModel.swift
//  M-Commerce-Admin
//
//  Created by Ziyad Qassem on 28/10/2023.
//

import Foundation
class DiscountCodeViewModel {
    var  bindresultToHomeViewController: ( () -> () ) = {}
    var networkManager = NetworkManager()
    var handerDataOfHome: (() -> Void)?
    var AllDiscountCodes: DiscountContainer? {
        didSet{
            if let validHander =  handerDataOfHome {
                validHander()
            }
        }
    }
    //MARK: - Network Functions
    func getDiscountCodes(priceRuleId : Int?){
        networkManager.getDiscountCodes(priceRuleId: 1138489032854, Handler: { (dataValue:DiscountContainer?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.AllDiscountCodes = mydata
                self.bindresultToHomeViewController()

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    //MARK: - UI Functions
    func getDiscountCodesNumber()-> Int {
        return AllDiscountCodes?.discount_codes.count ?? 1
    }
    
    func getDiscountCodesTitle(index : Int)-> String {
        return AllDiscountCodes?.discount_codes[index].code ?? "Summer Sale"
    }
    
    func getNumberOfUsages(index : Int) -> Int {
        return AllDiscountCodes?.discount_codes[index].usage_count ?? 0
    }
    
}
