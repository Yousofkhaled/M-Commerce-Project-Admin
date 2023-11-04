//
//  ProductInfoViewModel.swift
//  E-Commerce-Project
//
//  Created by Admin on 25/10/2023.
//

import Foundation

protocol ProductInfoDelegate {
    func viewReload()
}

class ProductInfoViewModel {
    
    var id : Int64?
    var product : ProductCompleteModel?
   
    var manager = AbstractNetworkService()
    var networkManager = NetworkServices()
    //var myView : ProductInfoViewController?
    var myView : ProductInfoDelegate?
    
    
    let threading_manager : DispatchGroup = DispatchGroup()
   
    
    func reload_my_view () {
        myView?.viewReload()
    }
    
    func numberOfOptions () -> Int{
        return product?.options?.count ?? 0
    }
    
    func optionValuesCount (for_Row row : Int) -> Int{
        return product?.options?[row].values?.count ?? 0
    }
    
    
    func optionName (row : Int, column : Int) -> String {
        return product?.options?[row].values?[column] ?? "Nil"
    }
    
    func initializeProduct () {
        manager.getData(endPoint: EndPoint.product_info(ProductID: id!), Handler: { (dataValue:AllProducts?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.product = mydata.product
                
//                self.reload_my_view()
                DispatchQueue.main.async {
                    self.reload_my_view()
                }
                
                //print(mydata)

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    func updateVariant (variant_id : Int, inventory_item_id : Int, inventory_quantity : Int, price : String) {
        
        threading_manager.enter()
        networkManager.editVariantQuantity(inventory_item_id: inventory_item_id, new_quantity: inventory_quantity) {
            self.threading_manager.leave()
        }
        
        threading_manager.enter()
        networkManager.edit_variant_price(variant_id: variant_id, variant_price: price) {
            self.threading_manager.leave()
        }
        
        threading_manager.notify(queue: DispatchQueue.main) {
            
            self.initializeProduct()
            
        }
        
    }
    
    func update_product (product_title: String, product_tags: String, product_description: String) {
        var product_id : Int = product?.id ?? -1
        
        networkManager.edit_product_data(product_id: product_id, product_title: product_title, product_tags: product_tags, product_description: product_description) {
            
            self.initializeProduct()
            
        }
    }
    
    
    //MARK: - Fetching Data From Api to chech if in favourite
    
}
