//
//  AddPriceRuleVC.swift
//  M-Commerce-Admin
//
//  Created by Ziyad Qassem on 28/10/2023.
//

import UIKit

class AddPriceRuleVC: UIViewController {

    @IBOutlet weak var DiscountType: UISegmentedControl!
    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var EndsAtDatePicker: UIDatePicker!
    @IBOutlet weak var startAtDatepicker: UIDatePicker!
    @IBOutlet weak var usagelimitField: UITextField!
    @IBOutlet weak var minimumSubtotalField: UITextField!
    @IBOutlet weak var discountAmountField: UITextField!
    var view_model = PriceRuleViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func DonePressed(_ sender: UIButton) {
    
        var arr : [String] = [discountAmountField.text! ,minimumSubtotalField.text!,usagelimitField.text!,TitleField.text!]
        var okay = true
        for s in arr {
            if(s.isEmpty){
                okay = false
                break
            }
        }
        if !okay {
            //Alert
        }
        //yyyy-MM-dd’T’HH:mm:ssZ
        else {
            let type = DiscountType.titleForSegment(at: DiscountType.selectedSegmentIndex)!
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm:ss"
            let str =  formatter.string(from: startAtDatepicker.date) + "T" + timeFormatter.string(from: startAtDatepicker.date) + "Z"
           let str2 = formatter.string(from: EndsAtDatePicker.date) + "T" + timeFormatter.string(from: EndsAtDatePicker.date) + "Z"
            
            
            view_model.addPriceRule(title: TitleField.text!, value_type: type, discountAmount:Int(discountAmountField.text!)! , starts_at: str, ends_at: str2, greater_than_or_equal_to: minimumSubtotalField.text!, usage_limit: Int(usagelimitField.text!)!)
        }
       
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
