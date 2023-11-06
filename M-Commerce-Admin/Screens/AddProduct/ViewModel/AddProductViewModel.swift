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
    
    var all_brands : [SmartCollectionModel] = []
    
    var capture_handler : (() -> Void) = {}
    func getSmartCollections (Handler: @escaping () -> Void ) {
        capture_handler = Handler
        manager.getBrands { (data : Brands?, error) in
            if (data != nil) {
                self.all_brands = data?.smart_collections ?? []
            }
            self.capture_handler()
        }
    }
    
    func addToSmartCollection (product_id : Int, vendor_id : Int) {
        
        print("add to smart collection")
        
    }
    
    
    func addNewProduct (title_str : String, vendor_str : String, type_str : String, description_str : String, img_str : String) {
        
        
        getSmartCollections { [title_str, vendor_str, type_str, description_str, img_str] in
            self.network_add_new_product(title_str: title_str, vendor_str: vendor_str, type_str: type_str, description_str: description_str, img_str: img_str)
        }
    }
    
    func network_add_new_product (title_str : String, vendor_str : String, type_str : String, description_str : String, img_str : String) {
        manager.add_new_product(product_title: title_str, product_vendor: vendor_str, product_type: type_str, product_description: description_str, img_str: img_str) {data in
            print("i am here and done")
            
            print(data)
            
            let added_product_id : Int = data?.product?.id ?? 0
            
            var vendor_id : Int = 0
            for b in self.all_brands {
                print(b.title, "vs input : ", vendor_str)
                if b.title == vendor_str {
                    vendor_id = b.id
                    
                    print("am i correct?")
                    print(vendor_id, b.title)
                }
            }
            
            if (vendor_id != 0) {
                self.addToSmartCollection(product_id: added_product_id, vendor_id: vendor_id)
                
            }
            
            print("should bind result to home")
            self.bindresultToHomeViewController()
        }
        
        //https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg
        //https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png
    }
    
    func addProductToBrand () {
        
    }
}
