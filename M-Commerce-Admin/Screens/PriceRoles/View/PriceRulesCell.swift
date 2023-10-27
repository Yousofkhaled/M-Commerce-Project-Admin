//
//  PriceRulesCell.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 26/10/2023.
//

import UIKit

class PriceRulesCell: UICollectionViewCell {
    @IBOutlet weak var discount: UILabel!
    
    @IBOutlet weak var priceDiscount: UILabel!
    @IBOutlet weak var endDiscount: UILabel!
    @IBOutlet weak var startDiscount: UILabel!
    @IBOutlet weak var numberOfUsage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
