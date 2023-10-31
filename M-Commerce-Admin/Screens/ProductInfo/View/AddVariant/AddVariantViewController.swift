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
    
    
    var add_variant_closure : (() -> Void) = {}
    
    @IBAction func Add_button_pressed(_ sender: Any) {
        add_variant_closure()
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
