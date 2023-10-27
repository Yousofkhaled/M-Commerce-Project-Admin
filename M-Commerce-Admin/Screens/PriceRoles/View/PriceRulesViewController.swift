//
//  PriceRulesViewController.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 26/10/2023.
//

import UIKit

class PriceRulesViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var offersCollectionView: UICollectionView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureCollectionView()
        navigationItem.title = "Price Rules"
    }
    
    private func configureCollectionView() {
        offersCollectionView.dataSource = self
        offersCollectionView.delegate = self
        //Registers
        offersCollectionView.register(UINib(nibName: CellIdentifier.priceRulesCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.priceRulesCell)
    }
    // MARK: - Actions

    @IBAction func addBtnTapped(_ sender: Any) {
//        let vc = AddProductViewController()
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}
// MARK: - UICollectionView DataSource
extension PriceRulesViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = offersCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.priceRulesCell, for: indexPath) as! PriceRulesCell
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor;
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
                    let vc = DiscountCodeViewController()
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


