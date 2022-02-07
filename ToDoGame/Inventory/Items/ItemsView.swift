//
//  ItemsView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 23.08.2021.
//

import UIKit

class ItemsView: UIView {
    
    var items: [[InventoryItem]] = [Seed.sample, Fruit.sample] {
        didSet {
            collectionView.reloadData()
        }
    }

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
        self.pinToEdges(subview: collectionView, bottom: 10)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(InventoryItemCollectionViewCell.self, forCellWithReuseIdentifier: InventoryItemCollectionViewCell.reuseIdentifier)
        collectionView.register(InventoryCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InventoryCollectionReusableView.reuseIdentifier)
    }

}

extension ItemsView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InventoryItemCollectionViewCell.reuseIdentifier, for: indexPath) as! InventoryItemCollectionViewCell
        let item = items[indexPath.section][indexPath.row]
        cell.update(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InventoryCollectionReusableView.reuseIdentifier, for: indexPath) as! InventoryCollectionReusableView
            if items[indexPath.section].first is Seed {
                reusableview.title = Strings.seeds
            }
            else if items[indexPath.section].first is Fruit  {
                reusableview.title = Strings.fruits
            }
            else if items[indexPath.section].first is Stone {
                reusableview.title = Strings.stones
            }
            return reusableview
        default:  fatalError("Unexpected element kind")
        }
    }
}

extension ItemsView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 20) / 3 - 1
        return CGSize(width: width, height: width / 3 * 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension ItemsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let plant = plants[indexPath.section][indexPath.row]
    }
}
