//
//  CalendarCollectionView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 17.06.2021.
//

import UIKit

class CalendarCollectionView: UIView {
    
    var dataSource: [CalendarDay] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var didSelectItemAtIndex: ((Int) -> ())?
    
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
    var collectionViewLayout = UICollectionViewFlowLayout()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.pinToEdges(subview: collectionView)
        collectionView.backgroundColor = .clear
        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension CalendarCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier, for: indexPath)
        return cell
    }
}

extension CalendarCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

extension CalendarCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let item = dataSource[indexPath.row]
        return item.belongsToMonth
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAtIndex?(indexPath.row)
    }
}
