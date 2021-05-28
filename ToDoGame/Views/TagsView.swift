//
//  TagsView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 20.05.2021.
//

import UIKit

class TagsView: UIView {
    
    var tagsSelected: [Int] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var tags: [Tag] = Tag.sample {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didSelectTag: ((Tag) -> Void)?
    
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
        collectionView.pinToEdges(to: self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.indicatorStyle = .white
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
    }
}

extension TagsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier, for: indexPath) as! TagCollectionViewCell
        let tag = tags[indexPath.row]
        let isSelected = tagsSelected.contains(tag.id)
        cell.update(with: tag, isSelected: isSelected)
        return cell
    }
}

extension TagsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let string = tags[indexPath.row].title
        let width = string.width(withConstrainedHeight: 13, font: UIFont.systemFont(ofSize: 13)) + 30
        return CGSize(width: width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

extension TagsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        if tagsSelected.contains(tag.id) {
            tagsSelected = tagsSelected.filter { $0 != tag.id }
        }
        else {
            tagsSelected.append(tag.id)
        }
        didSelectTag?(tags[indexPath.row])
    }
}
