//
//  Module1.swift
//  ModuleContainerExample
//
//  Created by jeffery on 2017/11/15.
//  Copyright © 2017年 com.yy.jeffery. All rights reserved.
//

import UIKit
import ModuleContainer

class Module1: UIViewController {
    
    var dataSource = ["Module1 - 0", "Module1 - 1", "Module1 - 2", "Module1 - 4", "Module1 - 5", "Module1 - 6"]
}

extension Module1: BaseModule {
    
    var classIdentifiers: [(cls: Swift.AnyClass?, id: String)] {
        return [(Module1Cell.self, Module1Cell.id)]
    }
    
    var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 10 ) / 2 , height: 50)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0)
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: Module1Cell.id, for: indexPath) as! Module1Cell
        cell.label.text = dataSource[indexPath.item]
        return cell
    }
}
