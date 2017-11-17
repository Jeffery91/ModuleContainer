//
//  Hoverable.swift
//  Pods
//
//  Created by jeffery on 2017/8/21.
//
//

import UIKit
import SnapKit

class ModuleWrapperCell: UICollectionViewCell {
    
    static let id = "__ModuleWrapperCell__"
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collection)
        collection.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var numberOfItems: (() -> Int)!
    var cellForItemAt: ((IndexPath) -> UICollectionViewCell)!
    var sizeForItemAt: ((IndexPath) -> CGSize)!
    var minimumLineSpacing: (() -> CGFloat)!
    var didSelectItemAt: ((IndexPath) -> Void)?
}

extension ModuleWrapperCell: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellForItemAt(indexPath)
    }
}

extension ModuleWrapperCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeForItemAt(indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing()
    }
}

extension ModuleWrapperCell: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAt?(indexPath)
    }
}
