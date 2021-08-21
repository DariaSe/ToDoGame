//
//  ShopCoordinator.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 02.08.2021.
//

import UIKit

class ShopCoordinator {
    
    let shopVC = ShopViewController()
    
    func start() {
        shopVC.coordinator = self
        shopVC.tabBarItem = UITabBarItem(title: "Shop", image: UIImage(named: "Shop"), tag: 2)
        getShopItems()
    }
    
    func getShopItems() {
        let plants = PlantSpecies.plants
//        shopVC.shopItems = [plants]
    }
    
    func buyItemGold(itemID: Int) {
        
    }
    
    func buyItemDonation(itemID: Int) {
        
    }
}
