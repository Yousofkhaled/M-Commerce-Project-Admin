//
//  DiscountCodeViewController.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 27/10/2023.
//

import UIKit

class DiscountCodeViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var discountCollectionView: UICollectionView!
    
    var discountViewModel = DiscountCodeViewModel()
    
    var manager = NetworkManager()
    
    var priceRuleId = 0
    // MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureCollectionView()
        navigationItem.title = "Price Rules"
        discountViewModel.bindresultToHomeViewController = {
            self.discountCollectionView.reloadData()
        }
        discountViewModel.getDiscountCodes(priceRuleId: priceRuleId)
    }
    
    private func configureCollectionView() {
        discountCollectionView.dataSource = self
        discountCollectionView.delegate = self
        //Registers
        discountCollectionView.register(UINib(nibName: CellIdentifier.dicountCodeCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.dicountCodeCell)
    }
    // MARK: - Actions

    @IBAction func addBtnTapped(_ sender: Any) {
//        let vc = AddProductViewController()
//        navigationController?.pushViewController(vc, animated: true)
        
        //1. Create the alert controller.
        var alert = UIAlertController(title: "Discount Code", message: "Enter a new Promo Code", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = "ex: SUMMER SALE"
        })

        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (action) -> Void in
            let textField = (alert?.textFields![0])! as UITextField
            
            self.manager.addDiscountCode(priceRuleId: self.priceRuleId, codeStr: textField.text ?? "empty str") {
                self.discountViewModel.getDiscountCodes(priceRuleId: self.priceRuleId)
            }
            
//            println("Text field: \(textField.text)")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (action) -> Void in
            // do nothing
        }))
        

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
// MARK: - UICollectionView DataSource
extension DiscountCodeViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discountViewModel.getDiscountCodesNumber()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = discountCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.dicountCodeCell, for: indexPath) as! DicountCodeCell
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor;
        cell.configureCellUI(dicountCodeTitle: discountViewModel.getDiscountCodesTitle(index: indexPath.row), numberOfUsage: discountViewModel.getNumberOfUsages(index: indexPath.row))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        //            let vc = ProductsViewController()
        //        homeViewModel.setSelectedBrandID(Index: indexPath.row)
        //            navigationController?.pushViewController(vc, animated: true)
        //            vc.modalPresentationStyle = .automatic
        //                self.present(vc, animated: true)
        
    }
}


// MARK: - UICollectionView Delegate
extension DiscountCodeViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        return CGSize(width: discountCollectionView.frame.width - 20  , height: discountCollectionView.frame.height/6)
        
    }
}


