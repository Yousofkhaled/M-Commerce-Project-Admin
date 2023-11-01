//
//  PriceRulesViewController.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 26/10/2023.
//

import UIKit

protocol reload_me {
    func reload_me()
    func update_me()
}

class PriceRulesViewController: UIViewController, reload_me {
    // MARK: - Variables
    @IBOutlet weak var offersCollectionView: UICollectionView!
    var priceRuleViewModel = PriceRuleViewModel()
    // MARK: - LifeCycle
    
    func reload_me () {
        print("reload_me price rules vc")
        offersCollectionView.reloadData()
    }
    
    func update_me () {
        priceRuleViewModel.getAllPriceRules()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureCollectionView()
        navigationItem.title = "Price Rules"
        priceRuleViewModel.bindresultToHomeViewController = {
            self.reload_me()
        }
        update_me()
    }
    
    private func configureCollectionView() {
        offersCollectionView.dataSource = self
        offersCollectionView.delegate = self
        //Registers
        offersCollectionView.register(UINib(nibName: CellIdentifier.priceRulesCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.priceRulesCell)
    }
    // MARK: - Actions

    @IBAction func addBtnTapped(_ sender: Any) {
        let vc = AddPriceRuleVC()
        vc.price_rules_protocol = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
// MARK: - UICollectionView DataSource
extension PriceRulesViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return priceRuleViewModel.getPriceRulesNumber()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = offersCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.priceRulesCell, for: indexPath) as! PriceRulesCell
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor;
        cell.configureCellUI(discountName: priceRuleViewModel.getpriceRuleTitle(index: indexPath.row), PriceDiscountBody: priceRuleViewModel.setFourthLabel(index: indexPath.row), startDate: priceRuleViewModel.getStartDate(index: indexPath.row), endDate: priceRuleViewModel.getEndDate(index: indexPath.row), usageNumber: priceRuleViewModel.getMaxUsage(index: indexPath.row))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
                    let vc = DiscountCodeViewController()
        vc.priceRuleId = priceRuleViewModel.getpriceRuleId(index: indexPath.item)
        //        homeViewModel.setSelectedBrandID(Index: indexPath.row)
                    navigationController?.pushViewController(vc, animated: true)
        //            vc.modalPresentationStyle = .automatic
        //                self.present(vc, animated: true)
        
    }
}


// MARK: - UICollectionView Delegate
extension PriceRulesViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        return CGSize(width: offersCollectionView.frame.width - 20  , height: offersCollectionView.frame.height/4)
        
    }
}


