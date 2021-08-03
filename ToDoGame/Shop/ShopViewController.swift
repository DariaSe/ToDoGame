//
//  ShopViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 02.08.2021.
//

import UIKit

class ShopViewController: UIViewController {
    
    weak var coordinator: ShopCoordinator?
    
    var shopItems: [[ShopItem]] = [[]] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
    let collectionViewLayout = UICollectionViewFlowLayout()
    
    let shadowingView = UIView()
    let buyAlertView = BuyAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        view.pinToLayoutMargins(subview: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.reuseIdentifier)
        collectionView.register(ShopHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ShopHeaderReusableView.reuseIdentifier)
        
        view.pinToEdges(subview: shadowingView)
        shadowingView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        buyAlertView.center(in: view)
        buyAlertView.setDimensions(width: 200, height: 300)
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(tapped))
        shadowingView.addGestureRecognizer(tapRecognizer)
        shadowingView.isUserInteractionEnabled = true
        shadowingView.isHidden = true
        buyAlertView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    @objc func tapped() {
        shadowingView.isHidden = true
        buyAlertView.isHidden = true
    }
}

extension ShopViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return shopItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopItems[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.reuseIdentifier, for: indexPath) as! ShopCollectionViewCell
        let item = shopItems[indexPath.section][indexPath.row]
        cell.update(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ShopHeaderReusableView.reuseIdentifier, for: indexPath) as! ShopHeaderReusableView
            reusableview.title = "Plants"
            return reusableview
        default:  fatalError("Unexpected element kind")
        }
    }
}

extension ShopViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 40)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margins = view.layoutMargins
        let viewWidth = view.frame.width - margins.left - margins.right
        let itemWidth = viewWidth / 3 - 1
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension ShopViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        shadowingView.isHidden = false
        buyAlertView.isHidden = false
        let item = shopItems[indexPath.section][indexPath.row]
        buyAlertView.update(with: item)
    }
}
