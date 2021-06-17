//
//  WeekdaysView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 16.06.2021.
//

import UIKit

class WeekdaysView: UIView {
    
    var selectedWeekdays: [Int] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didSelectWeekday: ((Int) -> ())?
    
    let weekdaySymbols = Calendar.current.localWeekdaySymbols
    
    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
    }()
    
    let collectionViewLayout = UICollectionViewFlowLayout()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        collectionView.center(in: self)
        collectionView.setDimensions(width: 320, height: 40)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(WeekdayCollectionViewCell.self, forCellWithReuseIdentifier: WeekdayCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension WeekdaysView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekdaySymbols.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekdayCollectionViewCell.reuseIdentifier, for: indexPath) as! WeekdayCollectionViewCell
        let weekdaySymbol = weekdaySymbols[indexPath.row]
        let isSelected = selectedWeekdays.contains(indexPath.row)
        cell.update(with: weekdaySymbol, isSelected: isSelected)
        return cell
    }
}

extension WeekdaysView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

extension WeekdaysView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectWeekday?(indexPath.row)
    }
}
