//
//  AvailavleProductsViewModel.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 28/10/2023.
//

import Foundation

struct ProductsResponse: Codable {
    var products: [Product]
}

struct Variant : Codable {
    var  price : String?
    var inventory_quantity : Int?
    var option1 : String?
    var option2 : String?
    var option3 : String?
}
struct Product : Codable {
    var id : Int64?
    var title : String?
    var vendor : String?
    var body_html : String?
    var images : [Image]
    var variants : [Variant]?
    var tags : String?
}

struct MyProductcontainer : Codable{
    var product : Product
}
