//
//  ProductInfoViewController.swift
//  E-Commerce-Project
//
//  Created by Admin on 19/10/2023.
//

import UIKit

class ProductInfoViewController: UIViewController, ProductInfoDelegate {
    
    // add image
    @IBAction func add_image_tapped(_ sender: UIButton) {
        
        //1. Create the alert controller.
        var alert = UIAlertController(title: "Add image", message: "Enter new image URL", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Enter image URL"
        })
        

        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [self, weak alert] (action) -> Void in
            let imgField = (alert?.textFields![0])! as UITextField
            
            var img_src = imgField.text ?? ""
            
            if (img_src == "") {
                let alert = UIAlertController(title: "Alert", message: "Please enter a valid URL", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.view_model.add_image(image_str: img_src)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (action) -> Void in
            // do nothing
        }))
        

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // cart code------------------------------------------------------------------------------
    @IBOutlet weak var variant_price: UILabel!
    
    @IBOutlet weak var variant_availability: UILabel!
    
    @IBAction func edit_product_pressed(_ sender: Any) {
        
        
        //1. Create the alert controller.
        var alert = UIAlertController(title: "Edit", message: "Enter new Product Data", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Title"
        })
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Tags"
        })
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Description"
        })
        
        

        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Edit", style: .destructive, handler: { [self, weak alert] (action) -> Void in
            let TitleField = (alert?.textFields![0])! as UITextField
            let TagsField = (alert?.textFields![1])! as UITextField
            let DescriptionField = (alert?.textFields![2])! as UITextField
            
            guard let title = TitleField.text else {
                return
            }
            if title.isEmpty {
                let alert = UIAlertController(title: "Alert", message: "Please enter a valid title", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            guard let tags = TagsField.text else {
                return
            }
            if tags.isEmpty {
                let alert = UIAlertController(title: "Alert", message: "Please enter valid tags", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            guard let description = DescriptionField.text else {
                return
            }
            if description.isEmpty {
                let alert = UIAlertController(title: "Alert", message: "Please enter a valid description", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            view_model.update_product(product_title: title, product_tags: tags, product_description: description)

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (action) -> Void in
            // do nothing
        }))
        

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func edit_variant_pressed(_ sender: Any) {
        
        if (variant_Unique_ID == -1) {
            
            let alert = UIAlertController(title: "Alert", message: "Please select a valid combination of options", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        //1. Create the alert controller.
        var alert = UIAlertController(title: "Edit", message: "Enter new variant Data", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Price"
        })
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Availability"
        })
        

        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Edit", style: .destructive, handler: { [self, weak alert] (action) -> Void in
            let priceField = (alert?.textFields![0])! as UITextField
            let availabilityField = (alert?.textFields![1])! as UITextField
            
            guard let price = Double(priceField.text ?? "not ok") else {
                let alert = UIAlertController(title: "Alert", message: "Please enter a valid price", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            guard let availability = Int(availabilityField.text ?? "not ok") else {
                let alert = UIAlertController(title: "Alert", message: "Please enter a valid availability", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            self.view_model.updateVariant(variant_id: self.variant_Unique_ID, inventory_item_id: self.variant_Inventory_item_ID, inventory_quantity: availability, price: "\(price)")
            
            
//            println("Text field: \(textField.text)")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (action) -> Void in
            // do nothing
        }))
        

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        print("variant exists")
    }
    
    
    var variant_available_elements : Int = 0
    
    var variant_index : Int = 0
    var variant_Unique_ID : Int = -1
    var variant_Inventory_item_ID : Int = -1
    
    func get_variant_data () {
        
        print ("get_variant_data")
        print(view_model.product)
        var all_variants : [VariantCompleteModel] = view_model.product?.variants ?? []
        
        var found : VariantCompleteModel = VariantCompleteModel()
        
        var variant_exists = false;
        
        found.price = nil
        found.inventory_quantity = nil
        if (selectedOptionsCount == get_number_of_options()) {
            for v in all_variants {
                //numOptions
                
                print(v)
                
                var equal : Bool = true
                
                if numOptions >= 1 {
                    equal = equal && (v.option1 == view_model.product?.options?[0].values?[selectedOption[0]])
                }
                if numOptions >= 2 {
                    equal = equal && (v.option2 == view_model.product?.options?[1].values?[selectedOption[1]])
                }
                if numOptions >= 3 {
                    equal = equal && (v.option3 == view_model.product?.options?[2].values?[selectedOption[2]])
                }
                
                if (equal) {
                    print("variant is found")
                    found = v;
                    variant_exists = true
                    break
                }
                else {
                    print("variant is NOT found")
                }
            }
        }
        
        variant_price.text = found.price ?? "not found"
        variant_availability.text = found.inventory_quantity != nil ? String(found.inventory_quantity!) : "not found"
        variant_available_elements = found.inventory_quantity ?? 0
        
        
        if (variant_exists) {
            variant_Unique_ID = found.id ?? -1
            variant_Inventory_item_ID = found.inventory_item_id ?? -1
        }
        else {
            variant_Unique_ID = -1
            variant_Inventory_item_ID = -1
        }
    }
    

    //------------------------------------------------------------------------------
    
    // options code------------------------------------------------------------------------------
    
    var selectedOption : [Int] = []
    var selectedOptionsCount = 0
    var numOptions = 0
    
    func get_number_of_options () -> Int{
        return numOptions
    }
    
    func reset_options () {
        selectedOptionsCount = 0
        numOptions = view_model.numberOfOptions()
        selectedOption = Array(repeating: -1, count: view_model.numberOfOptions())
    }
    
    func isOptionSelected (row : Int) -> Bool {
        return selectedOption[row] != -1
    }
    
    func setOption (row : Int, value : Int) {
        //selectedOptionsCount += (selectedOption[row] == -1) ? 1 : 0
        selectedOption[row] = value
    }
    
    func unsetOption (row : Int) {
        //selectedOptionsCount -= (selectedOption[row] != -1) ? 1 : 0
        selectedOption[row] = -1
    }
    
    func toggleOption (row : Int, value : Int) {
        
        let cell = optionsCollectionView.cellForItem(at: IndexPath(item: value, section: row)) as! OptionCollectionViewCell
        
        let old_cell : OptionCollectionViewCell? = isOptionSelected(row: row) ?
        optionsCollectionView.cellForItem(at: IndexPath(item: selectedOption[row], section: row)) as! OptionCollectionViewCell : nil
        
        
        if isOptionSelected(row: row) {
            
            if selectedOption[row] == value {
                unsetOption(row: row)
                selectedOptionsCount -= 1
                
                cell.unselect()
            }
            else {
                setOption(row: row, value: value)
                
                cell.select()
            }
            
            
        }
        else {
            selectedOptionsCount += 1
            setOption(row: row, value: value)
            
            cell.select()
            
        }
        
        if old_cell != nil {
            old_cell!.unselect()
        }
    }
    
    //------------------------------------------------------------------------------
    
    
    func viewReload () {
        optionsCollectionView.reloadData()
        productName.text = view_model.product?.title
        productTags.text = view_model.product?.tags
        productDescription.text = view_model.product?.body_html
        
        productImagesCollectionView.reloadData()
        
        reset_options()
        
        reset_height_and_options()
        
        get_variant_data()
        
    }
    
    // view_mode
    var view_model = ProductInfoViewModel()
    var product_id : Int64 = 7827742130326
    
    func setID (id: Int64) {
        print("inside set id : \(id)")
        self.product_id = id;
    }
    
    
    
  
    // outlets
    
    @IBOutlet weak var reviewsHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    
    
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    
    
    
    @IBOutlet weak var optionsHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productTags: UILabel!
    
    @IBAction func Add_variant_pressed(_ sender: Any) {
        let vc = AddVariantViewController()
        vc.add_variant_closure = {
            // TODO : dispatch
            DispatchQueue.main.async {
                self.view_model.initializeProduct()
            }
        }
        vc.product_ID = view_model.product?.id ?? 0
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBOutlet weak var productDescription: UILabel!
    
    func setproductImagesCollectionView () -> Void {
        productImagesCollectionView.delegate = self;
        productImagesCollectionView.dataSource = self;
        
        productImagesCollectionView.register(UINib(nibName: "CopounCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CopounCollectionViewCell")
    }
    
    func setReviewsView () -> Void {
        reviewsCollectionView.delegate = self;
        reviewsCollectionView.dataSource = self;
        
        let layout_ = UICollectionViewCompositionalLayout { index, env in

            let itemSize = NSCollectionLayoutSize (widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem (layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize (widthDimension: .absolute(self.reviewsCollectionView.superview!.frame.width), heightDimension: .absolute(100))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 0, bottom: 0, trailing: 0)
            
            
            section.boundarySupplementaryItems = [header]
            
            
            return section

        }
        
        reviewsCollectionView.setCollectionViewLayout(layout_, animated: true)
        
        reviewsCollectionView.register(UINib(nibName: "ReviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCollectionViewCell")
        
        reviewsCollectionView.register(sectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeader.identifier)
    }
    
    func setOptionsView () -> Void {
        optionsCollectionView.delegate = self;
        optionsCollectionView.dataSource = self;
        
        let layout_ = UICollectionViewCompositionalLayout { index, env in

            let itemSize = NSCollectionLayoutSize (widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem (layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize (widthDimension: .absolute(100), heightDimension: .absolute(100))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 0, bottom: 0, trailing: 0)
            
            
            section.boundarySupplementaryItems = [header]
            
            section.orthogonalScrollingBehavior = .continuous
            
            return section

        }
        
        optionsCollectionView.setCollectionViewLayout(layout_, animated: true)
        
        optionsCollectionView.register(UINib(nibName: "OptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OptionCollectionViewCell")
        
        optionsCollectionView.register(sectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeader.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("view did load")
        
        view_model.id = product_id
        view_model.myView = self
        
        view_model.initializeProduct()
        
        //print(view_model.product)
        
        setOptionsView ()
        setproductImagesCollectionView()
        setReviewsView()
        
    }
    
    
    func reset_height_and_options () {
        optionsCollectionView.reloadData()
        
        var height = optionsCollectionView.collectionViewLayout.collectionViewContentSize.height
        optionsHeight.constant = height
        
        height = reviewsCollectionView.collectionViewLayout.collectionViewContentSize.height
        reviewsHeight.constant = height
        
        
        
        view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //reset_height_and_options()
        
    }


}

extension ProductInfoViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if (collectionView == optionsCollectionView) {
            return view_model.numberOfOptions()
        }
        else if (collectionView == productImagesCollectionView) {
            return 1
        }
        else if (collectionView == reviewsCollectionView) {
            return 0
        }
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == optionsCollectionView) {
            return view_model.product?.options?[section].values?.count ?? 6
        }
        else if (collectionView == productImagesCollectionView) {
            return view_model.product?.images.count ?? 0
        }
        else if (collectionView == reviewsCollectionView) {
            return 3
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == optionsCollectionView) {
            let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: "OptionCollectionViewCell", for: indexPath) as! OptionCollectionViewCell
        
            //cell.setOptionValue(value: "White")
            cell.setOptionValue(value: view_model.product?.options?[indexPath.section].values?[indexPath.item] ?? "default")
            if (selectedOption[indexPath.section] == indexPath.item) {
                cell.select()
            }
            else {
                cell.unselect()
            }
            
            return cell;
        }
        else if (collectionView == productImagesCollectionView) {
            let cell = productImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "CopounCollectionViewCell", for: indexPath) as! CopounCollectionViewCell
            
            cell.configure(with: "coupon")
            
            cell.couponImageView.downloadImageFrom(view_model.product?.images[indexPath.item].src)

            
            cell.layer.cornerRadius = 30
            
            return cell;
        }
        else if (collectionView == reviewsCollectionView) {
            let cell = reviewsCollectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as! ReviewCollectionViewCell
            
            
            return cell;
        }
        
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: "OptionCollectionViewCell", for: indexPath) as! OptionCollectionViewCell
    
        cell.setOptionValue(value: "White")
        
        return cell;
    }
    
    func getOptionsCollectionViewHeaderName (indexPath: IndexPath) -> String{

        return view_model.product?.options?[indexPath.section].name ?? "Nil"
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionHeader{
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeader.identifier, for: indexPath) as! sectionHeader
                
                
                if collectionView == optionsCollectionView {
                    header.setHeaderValue(value: getOptionsCollectionViewHeaderName(indexPath: indexPath))
                }
                else if collectionView == reviewsCollectionView {
                    header.setHeaderValue(value: "Reviews")
                }
                
                return header
            }
            return UICollectionViewCell()
        }
    
}


extension ProductInfoViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == productImagesCollectionView {
            return CGSize (width:  productImagesCollectionView.frame.width, height:  productImagesCollectionView.frame.height)
        }
        else if collectionView == reviewsCollectionView {
            return CGSize (width:  reviewsCollectionView.frame.width, height:  125)
        }
        
        return CGSize (width: 100, height: 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == optionsCollectionView {
            
            let row = indexPath.section
            let value = indexPath.item
            
            
            
            toggleOption(row: row, value: value)
            
            get_variant_data()
            
            if selectedOptionsCount == get_number_of_options() {
                //get_variant_data()
                //showAddToCart()
            }
            else {
                
                //hideAddToCart()
            }
            
            print("toggle add to cart")
            
            print(selectedOptionsCount)
            
            //reset_cart()
            
            
        }
        
    }
    
    
}
