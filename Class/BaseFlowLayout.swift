//
//  BaseFlowLayout.swift
//  Pods
//
//  Created by jeffery on 2017/8/21.
//
//

import UIKit

public class BaseFlowLayout: UICollectionViewFlowLayout {
    
    var modules = [BaseModule]()

    var attrsArray: [UICollectionViewLayoutAttributes]?

    override public func prepare() {
        super.prepare()
        guard collectionView != nil else { return }
        var tempArr = [UICollectionViewLayoutAttributes]()
        let section = collectionView!.numberOfSections
        for index in 0..<section {
            let count = collectionView!.numberOfItems(inSection: index)
            for i in 0 ..< count {
                let indexpath = IndexPath(item: i, section:index)
                let attrs = layoutAttributesForItem(at: indexpath)
                if let att = attrs{
                    tempArr.append(att)
                }
            }
        }
        attrsArray = tempArr
    }
}

extension BaseFlowLayout {
    
    override public func layoutAttributesForElements(in rect:CGRect) -> [UICollectionViewLayoutAttributes]? {
        if attrsArray == nil {
            return super.layoutAttributesForElements(in: rect)
        }
        return attrsArray
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let section  = indexPath.section
        guard section < modules.count else {
            return super.layoutAttributesForItem(at: indexPath)
        }
        let m = self.modules[section]
        let attributes = m.layoutAttributesForItem(flowLayout: self, at: indexPath)
        if attributes != nil {
            return attributes
        } else {
            return super.layoutAttributesForItem(at: indexPath)
        }
    }
    
    public func superLayoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForItem(at: indexPath)
    }
    
    override public var collectionViewContentSize: CGSize{
        if attrsArray == nil {
            return super.collectionViewContentSize
        }
        guard attrsArray!.count > 0 else {
            return .zero
        }
        let h1 = attrsArray!.last!.frame.maxY
        let h2 = (attrsArray!.count > 2) ? attrsArray![attrsArray!.count - 2].frame.maxY : h1
        return CGSize(width:0,height:max(h1, h2) + 10)
    }
}
