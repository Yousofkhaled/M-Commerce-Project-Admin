//
//  AddProductViewController.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 26/10/2023.
//

import UIKit

class AddProductViewController: UIViewController {
    // MARK: - Variables

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var vendorTextField: UITextField!
    
    var vendor_name : String?
    var view_model : AddProductViewModel = AddProductViewModel()
    
    var  bindresultToPreviousController: ( () -> () ) = {}
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vendor_name = vendor_name {
            vendorTextField.text = vendor_name
            vendorTextField.isEnabled = false;
        }
        else {
            
        }
        
        view_model.bindresultToHomeViewController = {
            DispatchQueue.main.async {
                // deque screen
                self.bindresultToPreviousController()
                self.navigationController?.popViewController(animated: true)
            }
        }

    }
    // MARK: - Actions
    @IBAction func nextViewBrnTapped(_ sender: Any) {
        
        var title_str : String, vendor_str : String, type_str : String, description_str : String;
        
        title_str = titleTextField.text!
        vendor_str = vendorTextField.text!
        type_str = typeTextField.text!
        description_str = descriptionTextField.text!
        
        print("I am pressed")
        
        view_model.addNewProduct(title_str: title_str, vendor_str: vendor_str, type_str: type_str, description_str: description_str)
       
    }
    

}
