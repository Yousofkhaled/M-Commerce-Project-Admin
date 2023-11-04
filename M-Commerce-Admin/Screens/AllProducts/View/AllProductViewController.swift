//
//  AllProductViewController.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 27/10/2023.
//

import UIKit

class AllProductViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var allProuductCollectionView: UICollectionView!
    
    let categoryViewModel = CategoryViewModel()

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureCollectionView()
        
        categoryViewModel.bindresultToHomeViewController = {
            DispatchQueue.main.async {
                self.allProuductCollectionView.reloadData()
            }
        }
        
        configureLoadingDataFromApi()
    }
    
    private func configureCollectionView() {
        allProuductCollectionView.dataSource = self
        allProuductCollectionView.delegate = self
        //Registers
        allProuductCollectionView.register(UINib(nibName: CellIdentifier.availableProductsCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.availableProductsCell)
    }
    
    //MARK: - Configure The Loading Data
    func configureLoadingDataFromApi(){

        categoryViewModel.getDataFromApiForHome()

    }
    // MARK: - Actions

    @IBAction func addBtnTapped(_ sender: Any) {
//        let vc = AddProductViewController()
//        navigationController?.pushViewController(vc, animated: true)
        
        let vc = AddProductViewController()
        vc.bindresultToPreviousController = {
            self.categoryViewModel.getDataFromApiForHome()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
// MARK: - UICollectionView DataSource
extension AllProductViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryViewModel.getNumberOfProducts() ?? 3

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = allProuductCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.availableProductsCell, for: indexPath) as! AvailableProductsCell
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor;
        
        cell.productName.text = categoryViewModel.getTitle(index: indexPath.row)
        cell.productImage.downloadImageFrom(categoryViewModel.getImage(index: indexPath.row))
        
//        cell.productBrand.text = categoryViewModel.getTitle(index: indexPath.row)
//        cell.productName.text = categoryViewModel.getTitle(index: indexPath.row)

        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
                    let vc = ProductInfoViewController()
        vc.setID(id: categoryViewModel.getProductID(index: indexPath.item))
                    navigationController?.pushViewController(vc, animated: true)
        
    }
}


// MARK: - UICollectionView Delegate
extension AllProductViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        return CGSize(width: allProuductCollectionView.frame.width - 20  , height: allProuductCollectionView.frame.height/4)
        
    }
}


