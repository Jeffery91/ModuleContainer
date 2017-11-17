//
//  Module2.swift
//  ModuleContainerExample
//
//  Created by jeffery on 2017/11/15.
//  Copyright © 2017年 com.yy.jeffery. All rights reserved.
//

import UIKit
import ModuleContainer

class Module2: UIViewController {
    
    var dataSource = ["Module2 - 0", "Module2 - 1", "Module2 - 2", "Module2 - 4"]
}

extension Module2: BaseModule {
    
    var classIdentifiers: [(cls: Swift.AnyClass?, id: String)] {
        return [(Module2Cell.self, Module2Cell.id)]
    }
    
    var supplementaryClassIdentifiers: [(cls: Swift.AnyClass?, kind: String, id: String)] {
        return [
            (Module2Header.self, UICollectionElementKindSectionHeader, Module2Header.id),
            (Module2Footer.self, UICollectionElementKindSectionFooter, Module2Footer.id)
        ]
    }
    
    var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 100)
        layout.headerReferenceSize = CGSize(width: width, height: 40)
        layout.footerReferenceSize = CGSize(width: width, height: 40)
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: Module2Cell.id, for: indexPath) as! Module2Cell
        cell.label.text = dataSource[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Module2Header.id, for: indexPath)
        } else {
            return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Module2Footer.id, for: indexPath)
        }
    }
}
