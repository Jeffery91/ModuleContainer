//
//  BaseFlowLayout.swift
//  Pods
//
//  Created by jeffery on 2017/8/21.
//
//

import UIKit

public class ContainerFlowLayout: UICollectionViewFlowLayout {
    
    var modules = [BaseModule]()
}

extension ContainerFlowLayout {
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let section  = indexPath.section
        guard section < modules.count else {
            return super.layoutAttributesForItem(at: indexPath)
        }
        let module = modules[section]
        let attributes = module.layoutAttributesForItem(at: IndexPath(row: indexPath.row, section: 0), with: self)
        guard attributes != nil else {
            return super.layoutAttributesForItem(at: indexPath)
        }
        return attributes
    }
}
