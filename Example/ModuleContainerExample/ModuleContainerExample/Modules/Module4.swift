//
//  Module4.swift
//  ModuleContainerExample
//
//  Created by jeffery on 2017/11/15.
//  Copyright © 2017年 com.yy.jeffery. All rights reserved.
//

import UIKit
import ModuleContainer

class Module4: UIViewController {
        
    var dataSource = ["Module4 - 0", "Module4 - 1", "Module4 - 2", "Module4 - 4"]
}

extension Module4: BaseModule {
    
    var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 70)
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0)
        return layout
    }
    
    var classIdentifiers: [(cls: Swift.AnyClass?, id: String)] {
        return [(Module4Cell.self, Module4Cell.id)]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: Module4Cell.id, for: indexPath) as! Module4Cell
        cell.label.text = dataSource[indexPath.item]
        return cell
    }
    
    func layoutAttributesForItem(at indexPath: IndexPath, with layout: ContainerFlowLayout) -> UICollectionViewLayoutAttributes? {
        return nil
    }
}
