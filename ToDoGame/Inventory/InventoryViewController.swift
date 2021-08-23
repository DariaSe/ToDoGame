//
//  InventoryViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 02.08.2021.
//

import UIKit

class InventoryViewController: GradientViewController {
    
    weak var coordinator: InventoryCoordinator?
    
    let titleLabel = UILabel()
    let segmentView = InventorySegmentView()
    
    let gardenView = GardenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.pinToLayoutMargins(subview: titleLabel, leading: nil, trailing: nil, top: 5, bottom: nil)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.font = UIFont.screenTitleFont
        titleLabel.textColor = UIColor.AppColors.darkGreen
        titleLabel.text = Strings.inventory
        
        view.pinToEdges(subview: segmentView, leading: 11, trailing: 11, top: nil, bottom: nil)
        segmentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -5).isActive = true
        segmentView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        view.pinToEdges(subview: gardenView, leading: 10, trailing: 10, top: nil, bottom: nil)
        gardenView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 10).isActive = true
        gardenView.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: -10).isActive = true
    }
}
