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
    func getDiscountCodes <T:Codable> (priceRuleId: Int,Handler : @escaping (T?,Error?) -> Void){
        let URL = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/price_rules/\(priceRuleId)/discount_codes.json"
        Alamofire.AF.request(URL,method: Alamofire.HTTPMethod.get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success")
                Handler(dataRetivied, nil)
                
                }catch let error{
                  print ("this is an error :\(error)")
                    Handler(nil, error)
                }
            }
            else{print("There is error in casting data")}
        }
    }
    func getPriceRule <T:Codable> (Handler : @escaping (T?,Error?) -> Void){
        let URL = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/price_rules.json"
        AF.request(URL,method: .get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success from get price rule network manager ")
                    Handler(dataRetivied, nil)
                
                }catch let error{
                  print ("this is an error :\(error)")
                    Handler(nil, error)
                }
            }
            else{print("There is error in casting data")}
        }
    }
}

class NetworkServices   {
    
    //MARK: - Fetching Data From Api
    func getData<T :Codable>(Handler: @escaping (T?,Error?) -> Void) {
        let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/smart_collections.json"
        
        AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success")
                    Handler(dataRetivied, nil)
                    
                    let ggg = dataRetivied as! Brands
                    print("===================================")
                    print(ggg.smart_collections[0].title )
                    print("===================================")
                }catch let error{
                    print (error)
                    Handler(nil, error)
                }
            }
            else{print("There is error in casting data")}
        }
    }
    //MARK: - Fetching Data From Api to catagory
    func getDataToCategory<T :Codable>(Handler: @escaping (T?,Error?) -> Void) {
        let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/products.json"
        
        AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success22")
                    Handler(dataRetivied, nil)
                    
                }catch let error{
                    print (error)
                    Handler(nil, error)
                }
            }
            else{print("There is error in casting data")}
        }
    }
    //MARK: - Fetching Data From Api by product Type
    func getDataByProductType<T :Codable>(Type : String,Handler: @escaping (T?,Error?) -> Void) {
        let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/products.json?product_type=\(Type)"
        
        AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success22")
                    Handler(dataRetivied, nil)
                    //               print("===================================")
                    //               print(ggg.products[1].id )
                    //               print("===================================")
                }catch let error{
                    print (error)
                    Handler(nil, error)
                }
            }
            else{print("There is error in casting data")}
        }
    }
    //MARK: - Fetching Data From Api to favourites
    func getCustomerWishList<T :Codable>(CustomerId : Int? ,Handler: @escaping (T?,Error?) -> Void){
        
        let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/customers/6866434621590/metafields.json?namespace=wishlist"
        
        Alamofire.AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success")
                    Handler(dataRetivied, nil)
                    
                }catch let error{
                    print ("this is an error :\(error)")
                    Handler(nil, error)
                }
            }
            else{}
        }
    }
    //MARK: - Fetching Data From Api to check if product is in favourites
    func getfavouriteItem<T:Codable> (userID : Int,productId : Int ,Handler: @escaping (T?,Error?) -> Void){
        let URL = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/customers/\(userID))/metafields.json?namespace=wishlist&key=\(productId)"
        Alamofire.AF.request(URL,method: Alamofire.HTTPMethod.get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success")
                    Handler(dataRetivied, nil)
                    
                }catch let error{
                    print ("this is an error :\(error)")
                    Handler(nil, error)
                }
            }
            else{}
        }
    }
    //MARK: - Fetching Data From Api to  remove product from favourites
    func removefavouriteItem (userID : Int, wishId: Int ,Handler: @escaping () -> Void){
        let URL = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/metafields/\(wishId).json?"
        Alamofire.AF.request(URL,method: Alamofire.HTTPMethod.delete,headers: ["X-Shopify-Access-Token":"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"]).response { response in
            switch response.result {
            case .success(_):
                Handler()
                break
            case .failure(let error):
                print(error)
            }
            
        }
    }
    //MARK: - sending favourite to api
    func addFavouriteItem(userID : Int,productId : Int,productName: String,Handler: @escaping () -> Void){
        let urlFile = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/customers/\(userID)/metafields.json"
        
        let body: [String: Any] = [
            "metafield": [
                "namespace": "wishlist",
                "key": "\(productId)",
                "value": "\(productName)",
                "owner_id": userID,
                "owner_resource": "customer",
                "type": "single_line_text_field"
            ]
        ]
        AF.request(urlFile ,method: .post, parameters: body, encoding: JSONEncoding.default, headers: ["X-Shopify-Access-Token": "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"]).response{ response in
            switch response.result {
            case .success(_):
                print("success from add favourites")
                Handler()
                break
            case .failure(let error):
                print("in add favourites in network manager")
                print(error)
            }
        }
    }
    
    //MARK: - Fetching Data From Api product By ID
    func getProductById<T :Codable>(ProductId : String ,Handler: @escaping (T?,Error?) -> Void){
        
        let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/products/\(ProductId).json"
        
        Alamofire.AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success")
                    Handler(dataRetivied, nil)
                    
                }catch let error{
                    print (error)
                    Handler(nil, error)
                }
            }
            else{print("There is error in casting data")}
        }
    }
    //MARK: - Fetching Data From Api to show all brand product
    func getAllProductsForBrandData<T :Codable>(BrandId: Int ,Handler: @escaping (T?,Error?) -> Void) {
        let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/collections/\(BrandId)/products.json"
        
        AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success")
                    
                    Handler(dataRetivied, nil)
                    
                }catch let error{
                    print (error)
                    Handler(nil, error)
                }
            }
            else{print("There is error in casting data")}
        }
    }
    //MARK: - Fetching Data From Api to show customer Data
    func getCustomerData<T :Codable>(Handler: @escaping (T?,Error?) -> Void){
        let urlFile = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/customers.json"
        
        AF.request(urlFile,method: Alamofire.HTTPMethod.get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success")
                    
                    Handler(dataRetivied, nil)
                    
                }catch let error{
                    print (error)
                    Handler(nil, error)
                }
            }
            else{print("There is error in casting data")}
        }
    }
    
    func addProductVariant(product_id: Int, option_1 : String, option_2 : String, price : String, Handler: @escaping (Int?) -> Void){
        let urlFile = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/products/\(product_id)/variants.json"
        
        let body: [String: Any] = [
            "variant": [
                "option1": option_1,
                "option2": option_2,
                "price": price
            ]
        ]
        
        AF.request(urlFile,method: Alamofire.HTTPMethod.post, parameters: body, headers: ["X-Shopify-Access-Token":"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"]).response { data in
            switch data.result {
            case .success(_):
                print("success from add variant")
                
                if let validData = data.data {
                    do{
                        let dataRetivied = try JSONDecoder().decode(VariantCompleteModel_Container.self, from: validData)
                        print("Success")
                        
                        Handler(dataRetivied.variant?.inventory_item_id)
                        
                    }catch let error{
                        print (error)
                    }
                }
                else{print("There is error in casting data")}
                
                break
                
            case .failure(let error):
                print("in add varaint in network manager")
                print(error)
            }
        }
    }
    
    func editVariantQuantity(inventory_item_id: Int, new_quantity : Int, Handler: @escaping () -> Void){
        let urlFile = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/inventory_levels/set.json"
        
        let body: [String: Any] = [
            
            "location_id": 67733225622,
            "inventory_item_id": inventory_item_id,
            "available": new_quantity
        
        ]
        
        print(inventory_item_id)
        print(new_quantity)
        
        AF.request(urlFile,method: Alamofire.HTTPMethod.post, parameters: body, headers: ["X-Shopify-Access-Token":"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"]).response { data in
            switch data.result {
            case .success(_):
                print("success from edit variant")
                Handler()
                break
            case .failure(let error):
                print("in edit varaint in network manager")
                print(error)
            }
        }
    }
    
    
    
    
}
  
    
 

protocol end_point_generator {
    var base_URL : String {get}
    var method : Alamofire.HTTPMethod {get}
    var filePath : String {get}
}

enum EndPoint  : end_point_generator {
    
    case Home
    case all_products
    case product_info (ProductID : Int64)
    
    var base_URL: String {
        return "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .Home:
            return .get
        case .all_products:
            return .get
        case .product_info:
            return .get
        }
    }
    
    var filePath: String {
        switch self {
        case .Home:
            return "smart_collections.json"
        case .all_products:
            return "products.json"
        case .product_info (let ProductID):
            return "products/\(ProductID).json"
        }
    }
    
    
}

class AbstractNetworkService   {
 
    //MARK: - Fetching Data From Api
    func getData<T :Codable>(endPoint : EndPoint, Handler: @escaping (T?,Error?) -> Void) {
        
        let urlFile = endPoint.base_URL + endPoint.filePath
    
   
        AF.request(urlFile,method: endPoint.method).response { data in
        if let validData = data.data {
            do{
                let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                
//                let x = dataRetivied as! AllProducts
//                print(x)
//
//                print("product succeeded")
                Handler(dataRetivied, nil)
            
            }catch let error{
              print (error)
//                print("product failed")
                Handler(nil, error)
            }
        }
        else{print("There is error in casting data")}
    }
  }
}

