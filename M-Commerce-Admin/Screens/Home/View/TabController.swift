//
//  TabController.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 19/10/2023.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let homeController = HomeViewController()
//        let categoryController = CategoriesViewController()
        
        self.setUpTabs()
        self.tabBar.tintColor = .systemPurple
        self.tabBar.unselectedItemTintColor = .systemGray
        self.tabBar.selectedItem?.largeContentSizeImage = .add

    }
    
    private func setUpTabs(){
        let homeController = HomeViewController()
        let priceRuleViewController = PriceRulesViewController()
        let allProductViewController = AllProductViewController()

        
//        let home = UINavigationController(rootViewController: homeController)
//        let category = UINavigationController(rootViewController: categoryController)
                                              
        let homeVC = self.createNav(with: "Home", and: UIImage(named: "Home2"), vc: homeController)
        
        let priceRuleVC = self.createNav(with: "Price Rule", and: UIImage(systemName: "tag"), vc: priceRuleViewController)

        let allProductVC = self.createNav(with: "All Products", and: UIImage(systemName: "list.bullet"), vc: allProductViewController)
        
        
//        let me = self.createNav(with: "Me", and: UIImage(named: "Me"), vc: HomeViewController())
        self.setViewControllers([homeVC , allProductVC , priceRuleVC], animated: true)
        
    }
    
    private func createNav(with title:String , and image:UIImage? , vc : UIViewController)-> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
//        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: <#T##UIImage?#>, style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: Selector?)
        
        return nav
    }
}

