//
//  AddProductViewModel.swift
//  M-Commerce-Admin
//
//  Created by Admin on 04/11/2023.
//

import Foundation

class AddProductViewModel {
    
    var  bindresultToHomeViewController: ( () -> () ) = {}
    
    
    var manager = NetworkServices()
    
    func addNewProduct (title_str : String, vendor_str : String, type_str : String, description_str : String) {
        
        manager.add_new_product(product_title: title_str, product_vendor: vendor_str, product_type: type_str, product_description: description_str) {
            print("i am here and done")
            self.bindresultToHomeViewController()
        }
        
    }
}