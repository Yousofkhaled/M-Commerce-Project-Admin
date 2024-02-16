//
//  AddVariantViewController.swift
//  M-Commerce-Admin
//
//  Created by Admin on 29/10/2023.
//

import UIKit

class AddVariantViewController: UIViewController {
    
    @IBOutlet weak var size_text_field: UITextField!
    
    @IBOutlet weak var color_text_field: UITextField!
    
    @IBOutlet weak var price_text_field: UITextField!
    
    @IBOutlet weak var quantity_text_field: UITextField!
    
    var product_ID : Int = 0
    var add_variant_closure : (() -> Void) = {}
    
    @IBAction func Add_button_pressed(_ sender: Any) {
        
        // api call here
        // one function (data + quantity)
        
        // api1 (product_id, option1, option2, price) {handler (variant_id, quantity)}
        // api2 (variant_id, quantity) { handler view_model.initialize {reload my vc} }
        
        var manager = NetworkServices()
        
        
        
        manager.addProductVariant(product_id: product_ID, option_1: size_text_field.text ?? "911", option_2: color_text_field.text ?? "cyan", price: price_text_field.text ?? "1234.00") { inventory_item_id in
            
            manager.editVariantQuantity(inventory_item_id: inventory_item_id ?? 0, new_quantity: Int(self.quantity_text_field.text ?? "0") ?? 0) {
                self.add_variant_closure()
            }
            
        }
        
        //add_variant_closure()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
