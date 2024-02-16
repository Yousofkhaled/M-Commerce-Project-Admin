//
//  PriceRulesCell.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 26/10/2023.
//

import UIKit

protocol price_rule_deletion {
    func update_me()
}

class PriceRulesCell: UICollectionViewCell, UIContextMenuInteractionDelegate {
    
    
    var manager = NetworkServices()
    
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_) -> UIMenu? in
            
            let delete = UIAction(title : "delete") { (_) in
                print ("press delete")
                // delete action here
//                self.manager.deleteProductById(ProductId: Int64(self.price_rule_id!)) { _ in
//                    self.deletion_delegate?.update_me()
//                }
//
                self.manager.deletePriceRuleById(priceRuleId: Int64(self.price_rule_id!)) { _ in
                    self.deletion_delegate?.update_me()
                }
                
            }
            let cancel = UIAction(title : "cancel") { (_) in
                print("cancel")
                // cancel action here
            }
            
            return UIMenu(title : "Menu", children : [delete, cancel])
        }
        
    }
    
    var price_rule_id : Int?
    
    var deletion_delegate : price_rule_deletion?
    
    
    
    @IBOutlet weak var discount: UILabel!
    
    @IBOutlet weak var priceDiscount: UILabel!
    @IBOutlet weak var endDiscount: UILabel!
    @IBOutlet weak var startDiscount: UILabel!
    @IBOutlet weak var numberOfUsage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let menu = UIContextMenuInteraction(delegate: self)
        self.addInteraction(menu)
        // Initialization code
    }
    func configureCellUI(discountName : String,PriceDiscountBody: String , startDate : String ,endDate : String , usageNumber : String ){
        discount.text = discountName
        priceDiscount.text = PriceDiscountBody
        startDiscount.text = startDate
        endDiscount.text = endDate
        numberOfUsage.text = usageNumber
    }

}
