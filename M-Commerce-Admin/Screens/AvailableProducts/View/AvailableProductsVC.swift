//
//  AvailableProductsVC.swift
//  M-Commerce-Admin
//
//  Created by Abdallah on 26/10/2023.
//

import UIKit

class AvailableProductsVC: UIViewController, cell_delegate {
    // MARK: - Variables

    @IBOutlet weak var availableProductsCollectionView: UICollectionView!
    
    var productviewModel = ProductViewModel()
    
    var brand_title : String = "Not Set"

    
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
    
    override func viewDidAppear(_ animated: Bool) {
        
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
        vc.vendor_name = brand_title
        vc.bindresultToPreviousController = {
            self.productviewModel.getDataFromApiForProduct()
        }
//        vc.vendorTextField.text = brand_title
//        vc.vendorTextField.isEnabled = false;
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
        
        cell.productBrand.text = productviewModel.get_brand(index: indexPath.item)
//        cell.productQuantity.text = "\(productviewModel.get_quantity(index: indexPath.item)) in stock"
        
        var id = productviewModel.getProductID(index: indexPath.item)
        
        cell.productPrice.text = productviewModel.getPrice(index: indexPath.item)
        cell.productQuantity.text = "\(productviewModel.getAmount(index: indexPath.item)) in stock"
        
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor;
        
        cell.product_id = Int(productviewModel.getProductID(index: indexPath.item))
        
        print("here", "\(productviewModel.getTitle(index: indexPath.row))", Int(productviewModel.getProductID(index: indexPath.item)))
        
        
        
        cell.deletion_delegate = self
        
        
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


