//
//  GardenView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 02.08.2021.
//

import UIKit

class GardenView: UIView {
    
    var plants: [[Plant]] = [Plant.sample, Plant.sample] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var delegate: GardenDelegate?
    
    let emptyView = UIView()
    let resourcesView = GardenResourcesView()
    
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
    let collectionViewLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: resourcesView, trailing: 10, bottom: nil)
        resourcesView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.pinToEdges(subview: collectionView, top: 60, bottom: 10)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(GardenCollectionViewCell.self, forCellWithReuseIdentifier: GardenCollectionViewCell.reuseIdentifier)
        collectionView.register(InventoryCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InventoryCollectionReusableView.reuseIdentifier)
    }
}

extension GardenView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return plants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GardenCollectionViewCell.reuseIdentifier, for: indexPath) as! GardenCollectionViewCell
        cell.restoreFrame()
        let plant = plants[indexPath.section][indexPath.row]
        cell.update(with: plant)
        cell.waterPressed = { [unowned self] in
            self.delegate?.water(plantID: plant.instanceID)
        }
        cell.fertilizePressed = { [unowned self] in
            self.delegate?.fertilize(plantID: plant.instanceID)
        }
        cell.pickFruitsPressed = { [unowned self] in
            self.delegate?.pickFruits(plantID: plant.instanceID)
        }
        return cell
    }
}

extension GardenView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 20) / 2 - 1
        return CGSize(width: width, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension GardenView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let plant = plants[indexPath.section][indexPath.row]
    }
}
