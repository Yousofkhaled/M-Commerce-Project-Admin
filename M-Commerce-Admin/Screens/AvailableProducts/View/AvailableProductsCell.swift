//
//  AvailableProductsCell.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 26/10/2023.
//

import UIKit

protocol cell_delegate {
    func configureLoadingDataFromApi()
}

class AvailableProductsCell: UICollectionViewCell, UIContextMenuInteractionDelegate {
    
    
    var manager = NetworkServices()
    
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_) -> UIMenu? in
            
            let delete = UIAction(title : "delete") { (_) in
                print ("press delete")
                // delete action here
                self.manager.deleteProductById(ProductId: Int64(self.product_id)) { _ in
                    self.deletion_delegate?.configureLoadingDataFromApi()
                }
                
            }
            let cancel = UIAction(title : "cancel") { (_) in
                print("cancel")
                
                print(self.product_id)
                // cancel action here
            }
            
            return UIMenu(title : "Menu", children : [delete, cancel])
        }
        
    }
    
    
    
    
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    
    var product_id : Int = 0
    
    var deletion_delegate : cell_delegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let menu = UIContextMenuInteraction(delegate: self)
        self.addInteraction(menu)
        
        
    }
    
    

}

    
