//
//  InventoryViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 02.08.2021.
//

import UIKit

class InventoryViewController: UIViewController {
    
    weak var coordinator: InventoryCoordinator?
    
    let titleLabel = UILabel()
    let segmentView = InventorySegmentView()
    
    let gardenView = GardenView()
    let itemsView = ItemsView()
    let recipesView = RecipesView()
    
    lazy var views: [UIView] = [gardenView, itemsView, recipesView]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        view.pinToLayoutMargins(subview: titleLabel, leading: nil, trailing: nil, top: 5, bottom: nil)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.font = UIFont.screenTitleFont
        titleLabel.textColor = UIColor.AppColors.darkGreen
        titleLabel.text = Strings.inventory
        
        view.pinToEdges(subview: segmentView, leading: 11, trailing: 11, top: nil, bottom: nil)
        segmentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        segmentView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        segmentView.didSelectSegment = { [unowned self] segment in
            for view in views {
                view.isHidden = segment != view.tag
            }
        }
        
        view.pinToEdges(subview: gardenView, leading: 10, trailing: 10, top: nil, bottom: nil)
        gardenView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        gardenView.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 10).isActive = true
        gardenView.tag = 0
        
        view.pinToEdges(subview: itemsView, leading: 10, trailing: 10, top: nil, bottom: nil)
        itemsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        itemsView.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 10).isActive = true
        itemsView.tag = 1
        itemsView.isHidden = true
        
        view.pinToEdges(subview: recipesView, leading: 10, trailing: 10, top: nil, bottom: nil)
        recipesView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        recipesView.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 10).isActive = true
        recipesView.tag = 2
        recipesView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gardenView.resourcesView.updateUI()
    }
}
