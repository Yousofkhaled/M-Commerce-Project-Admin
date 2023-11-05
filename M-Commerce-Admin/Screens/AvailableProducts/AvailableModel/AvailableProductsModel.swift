//
//  AvailableProductsModel.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 28/10/2023.
//

import Foundation

class ProductViewModel {
    var handerDataOfHome: (() -> Void)?
    var  bindresultToProductsViewController: ( () -> () ) = {}
    
    var services = NetworkServices()
    var manager = AbstractNetworkService()
    
    var AllBrandProducts: ProductsResponse? {
        didSet{
            if let validHander =  handerDataOfHome {
                validHander()
            }
        }
    }
    
    var completeModelArray : [ProductCompleteModel?] = []
    
    //MARK: -CAll Request of Api
    func getDataFromApiForProduct() {
        services.getAllProductsForBrandData(BrandId: HomeViewModel.selectedBrandID ?? 303787573398, Handler: { (dataValue:ProductsResponse?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.AllBrandProducts = mydata
                
                self.AllBrandProducts!.products = self.AllBrandProducts!.products.sorted(by: { p1, p2 in
                    var a1 = p1 as Product
                    var a2 = p2 as Product
                    
                    return a1.id! < a2.id!
                })
                print("num products for brand : ")
                print(mydata.products.count)
                //self.bindresultToProductsViewController()
                self.completeModelArray = []
                self.getCompleteModels()

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    
    
    let dispatchGroup = DispatchGroup()
    
    func getCompleteModels () {
        
        for p in AllBrandProducts!.products {
            dispatchGroup.enter()
            manager.getData(endPoint: EndPoint.product_info(ProductID: p.id!), Handler: { (dataValue:AllProducts?, error: Error?) in
                print("Success")

                if let mydata = dataValue {
                    //self.product = mydata.product
                    
                    self.completeModelArray.append(mydata.product)
                    

                }else {
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
                self.dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
//            for p in self.completeModelArray {
//                print(p)
//            }
            self.completeModelArray = self.completeModelArray.sorted(by: { p1, p2 in
                var a1 = p1! as ProductCompleteModel
                var a2 = p2! as ProductCompleteModel
                
                return a1.id! < a2.id!
            })
            self.bindresultToProductsViewController()
        }
        
    }
    
    
    func getDataFromApiForProduct_WithFilter(SearchText : String) {
        services.getAllProductsForBrandData(BrandId: HomeViewModel.selectedBrandID ?? 303787573398, Handler: { (dataValue:ProductsResponse?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.AllBrandProducts = mydata
                self.AllBrandProducts?.products = []
                
                for p in mydata.products {
                    if (p.title?.contains(SearchText) == true){
                        self.AllBrandProducts?.products.append(p)
                    }
                }
                
                self.bindresultToProductsViewController()

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    func get_brand(index: Int) -> String {
        return AllBrandProducts?.products[index].vendor ?? "Bad request"
    }
    
    func getPrice (index : Int) -> String {
        var bad = "0 $"
        if index >= completeModelArray.count {
            return bad
        }
        guard let all_variants = completeModelArray[index]?.variants else {
            return bad
        }
        if all_variants.count == 0 {
            return bad
        }
        var ret = all_variants[0].price ?? "0"
        return ret + "$"
    }
    
    func getAmount (index : Int) -> Int {
        var bad = 0
        if index >= completeModelArray.count {
            return bad
        }
        guard let all_variants = completeModelArray[index]?.variants else {
            return bad
        }
        if all_variants.count == 0 {
            return bad
        }
        var val = 0
        for v in 0 ..< all_variants.count {
            val += all_variants[v].inventory_quantity ?? 0
        }
        return val
//        var ret = all_variants[0].inventory_quantity ?? 0
//        return ret
    }
    
    
    
    //MARK: -Getting Number of Brands
func getNumberOfProduct() -> Int? {
    return AllBrandProducts?.products.count
   }
    func getTitle(index: Int) -> String?{
        return  AllBrandProducts?.products[index].title
 
    }
    func getid(index: Int) -> String{
        return  AllBrandProducts?.products[index].images[0].src ?? "none"
 
    }
    func getProductID (index : Int) -> Int64{
            return AllBrandProducts?.products[index].id ?? 0
        }
   
//    func getImage(index: Int) -> String?{
//        return getAllBrands?.smart_collections[index].image.src
//
//    }
}
    


