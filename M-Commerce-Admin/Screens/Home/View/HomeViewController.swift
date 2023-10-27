//
//  HomeViewController.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 26/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    private func configureCollectionView() {
        brandsCollectionView.dataSource = self
        brandsCollectionView.delegate = self
        //Registers
        brandsCollectionView.register(UINib(nibName: CellIdentifier.brandsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.brandsCollectionViewCell)
        
    }
}
// MARK: - UICollectionView DataSource
extension HomeViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = brandsCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.brandsCollectionViewCell, for: indexPath) as! BrandsCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor;
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        let vc = AvailableProductsVC()
        //        homeViewModel.setSelectedBrandID(Index: indexPath.row)
                    navigationController?.pushViewController(vc, animated: true)
        //            vc.modalPresentationStyle = .automatic
        //                present(vc, animated: true)
    }
}

// MARK: - UICollectionView Delegate
extension HomeViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        return CGSize(width: (brandsCollectionView.frame.width - 20)/2  , height: brandsCollectionView.frame.height/3)
        
    }
}


