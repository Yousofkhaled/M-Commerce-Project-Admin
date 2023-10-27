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
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureCollectionView()
        navigationItem.title = "Price Rules"
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
    }
    
}
// MARK: - UICollectionView DataSource
extension DiscountCodeViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = discountCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.dicountCodeCell, for: indexPath) as! DicountCodeCell
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor;
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


