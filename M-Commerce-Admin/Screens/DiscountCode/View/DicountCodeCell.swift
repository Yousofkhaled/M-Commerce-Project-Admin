//
//  DicountCodeCell.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 27/10/2023.
//

import UIKit

class DicountCodeCell: UICollectionViewCell {

    @IBOutlet weak var usageCount: UILabel!
    @IBOutlet weak var dicountCodeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCellUI(dicountCodeTitle : String , numberOfUsage : Int ) {
        dicountCodeLabel.text = dicountCodeTitle
        usageCount.text = String(numberOfUsage)
    }
}
