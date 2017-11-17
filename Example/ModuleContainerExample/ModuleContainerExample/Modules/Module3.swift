//
//  Module3.swift
//  ModuleContainerExample
//
//  Created by jeffery on 2017/11/15.
//  Copyright © 2017年 com.yy.jeffery. All rights reserved.
//

import UIKit
import ModuleContainer

class Module3: UIViewController {
    
    var dataSource = ["Module3 - 0", "Module3 - 1", "Module3 - 2", "Module3 - 4", "Module3 - 5", "Module3 - 6", "Module3 - 7", "Module3 - 8"]
}

extension Module3: BaseModule {
    
    var classIdentifiers: [(cls: Swift.AnyClass?, id: String)] {
        return [(Module3Cell.self, Module3Cell.id)]
    }
    
    var supplementaryClassIdentifiers: [(cls: Swift.AnyClass?, kind: String, id: String)] {
        return [
            (Module3Header.self, UICollectionElementKindSectionHeader, Module3Header.id),
            (Module3Footer.self, UICollectionElementKindSectionFooter, Module3Footer.id)
        ]
    }
    
    var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        let width = UIScreen.main.bounds.width
        layout.headerReferenceSize = CGSize(width: width, height: 30)
        layout.footerReferenceSize = CGSize(width: width, height: 30)
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: Module3Cell.id, for: indexPath) as! Module3Cell
        cell.label.text = dataSource[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Module3Header.id, for: indexPath)
        } else {
            return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Module3Footer.id, for: indexPath)
        }
    }
}
