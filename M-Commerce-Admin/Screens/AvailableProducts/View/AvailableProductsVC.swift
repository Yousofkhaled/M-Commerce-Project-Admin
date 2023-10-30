//
//  AvailableProductsVC.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 26/10/2023.
//

import UIKit

class AvailableProductsVC: UIViewController {
    // MARK: - Variables

    @IBOutlet weak var availableProductsCollectionView: UICollectionView!
    
    var productviewModel = ProductViewModel()

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureCollectionView()
        navigationItem.title = "Available Products"
        
        productviewModel.bindresultToProductsViewController = {
            DispatchQueue.main.async {
                self.availableProductsCollectionView.reloadData()
            }
        }
        
        configureLoadingDataFromApi()
    }
    
    func configureLoadingDataFromApi(){
      
            productviewModel.getDataFromApiForProduct()
        
    }
    
    private func configureCollectionView() {
        availableProductsCollectionView.dataSource = self
        availableProductsCollectionView.delegate = self
        //Registers
        availableProductsCollectionView.register(UINib(nibName: CellIdentifier.availableProductsCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.availableProductsCell)
    }
    // MARK: - Actions

    @IBAction func addBtnTapped(_ sender: Any) {
        let vc = AddProductViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
// MARK: - UICollectionView DataSource
extension AvailableProductsVC:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productviewModel.getNumberOfProduct() ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = availableProductsCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.availableProductsCell, for: indexPath) as! AvailableProductsCell
        
        cell.productName.text = productviewModel.getTitle(index: indexPath.row)
        cell.productImage.downloadImageFrom(productviewModel.getid(index: indexPath.row))
        
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor;
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        let vc = ProductInfoViewController()
        vc.setID(id: productviewModel.getProductID(index: indexPath.item))
        navigationController?.pushViewController(vc, animated: true)
        
    }
}


// MARK: - UICollectionView Delegate
extension AvailableProductsVC: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        return CGSize(width: availableProductsCollectionView.frame.width - 20  , height: availableProductsCollectionView.frame.height/4)
        
    }
}


