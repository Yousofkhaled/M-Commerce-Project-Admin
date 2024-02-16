//
//  DicountCodeCell.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 27/10/2023.
//

import UIKit

protocol discount_code_deletion {
    func reload_view()
}

class DicountCodeCell: UICollectionViewCell, UIContextMenuInteractionDelegate {
    
    
    var manager = NetworkServices()
    
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_) -> UIMenu? in
            
            let delete = UIAction(title : "delete") { (_) in
                print ("press delete")
                // delete action here
                
                print(Int64(self.price_rule_id!), Int64(self.discount_code_id!))
                self.manager.deleteDiscountById(priceRuleId: Int64(self.price_rule_id!), discountId: Int64(self.discount_code_id!), Handler: { error in
                    print(error)
                    self.deletion_delegate?.reload_view()
                })
            }
            let cancel = UIAction(title : "cancel") { (_) in
                print("cancel")
                // cancel action here
            }
            
            return UIMenu(title : "Menu", children : [delete, cancel])
        }
        
    }
    
    var discount_code_id : Int?
    var price_rule_id : Int?
    
    var deletion_delegate : discount_code_deletion?

    @IBOutlet weak var usageCount: UILabel!
    @IBOutlet weak var dicountCodeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let menu = UIContextMenuInteraction(delegate: self)
        self.addInteraction(menu)
        // Initialization code
    }
    func configureCellUI(dicountCodeTitle : String , numberOfUsage : Int ) {
        dicountCodeLabel.text = dicountCodeTitle
        usageCount.text = String(numberOfUsage)
    }
}
