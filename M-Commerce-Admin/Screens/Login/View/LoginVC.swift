//
//  LoginVC.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 19/10/2023.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var googleBtnOutlet: UIButton!
    @IBOutlet weak var loginBtnOutlet: UIButton!
    @IBOutlet weak var UserPasswordTextField: UITextField!
    @IBOutlet weak var UserNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        UserPasswordTextField.isSecureTextEntry = true

    }
    
    func checkCustomerInfo (n : String, p : String) -> Bool{
        let name = "Yousof Khaled"
        let password = "0990"
        
        return n == name && p == password
    }
    
    //MARK: - ACTIONS
    @IBAction func LoginButton(_ sender: UIButton) {
        if getUserData() {
            
            
            
            if checkCustomerInfo(n: UserNameTextField.text!, p: UserPasswordTextField.text!){
                let vc = TabController()
//                navigationController?.pushViewController(vc, animated: true)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
             }
            else {
                self.showAlert(message: "User doesn't exi", actionType: .default)
            }
        }else {
            self.showAlert(message: "you've left a field empty please enter your password and your name", actionType: .default)
        }
    }
   
    
    
    func getUserData() -> Bool {
        if UserPasswordTextField.text?.isEmpty == false {
            if UserNameTextField.text?.isEmpty == false {
                return true
            }
        }
        return false
    }
    
   
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func showAlert(message:String , actionType : UIAlertAction.Style){
        let alert = UIAlertController(title: message, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "okay", style: actionType))
        
        self.present(alert, animated: true)
    }
    
    //https://en.afew-store.com/cdn/shop/collections/adidas-originals-stan-smith.jpg?v=1675693543
    //https://www.sneakerfiles.com/wp-content/uploads/2016/03/adidas-stan-smith-luxe-cork.jpg
}
