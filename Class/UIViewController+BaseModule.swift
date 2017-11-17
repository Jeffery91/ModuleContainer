//
//  UIViewController+MBaseModule.swift
//  Pods
//
//  Created by jeffery on 2017/8/21.
//
//

import UIKit

private let defaultClassIdentifier = "_default_class_identifier"
private let defaultSupplementaryClassIdentifier = "_default_supplementary_class_identifier"

extension BaseModule where Self: UIViewController  {
    
    public func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        let container = moduleContainer()
        if flowLayout.scrollDirection == .horizontal {
            let index = (container.modules as [UIViewController]).index(of: self)
            let wrapper = container.wrapperCells[index!]
            return wrapper!.collection.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        } else {
            let containerIndex = containerIndexPath(of: indexPath)
            return moduleContainer().contentView.dequeueReusableCell(withReuseIdentifier: identifier, for: containerIndex)
        }
    }
    
    public func dequeueReusableSupplementaryView(ofKind elementKind: String, withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionReusableView {
        let containerIndex = containerIndexPath(of: indexPath)
        return moduleContainer().contentView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identifier, for: containerIndex)
    }
    
    public func reload() {
//        guard collectionView == nil else {
//            collectionView?.reloadData()
//            collectionView?.setNeedsLayout()
//            collectionView?.layoutIfNeeded()
//            return
//        }
//        guard let container = moduleContainer() else { return }
//        guard !container.isInserting else {
//            container.shouldReload = true
//            return
//        }
//        container.contentView.reloadData()
//        container.contentView.setNeedsLayout()
//        container.contentView.layoutIfNeeded()
    }
    
    public func reloadItem(at indexPath: IndexPath) {
//        guard collectionView == nil else {
//            if collectionView?.cellForItem(at: indexPath) != nil{
//                collectionView?.reloadItems(at: [indexPath])
//            }
//            return
//        }
//        guard let container = moduleContainer() else { return }
//        var containerIndexPaths = [containerIndexPath(of: indexPath)]
//        if container.contentView.cellForItem(at: containerIndexPath(of: indexPath)) != nil{
//            container.contentView.reloadItems(at: containerIndexPaths)
//        }
    }
    
    public func reloadContainer() {
        
    }
    
    public func insertItems(at indexPaths: [IndexPath]) {
//        guard collectionView == nil else {
//            collectionView?.insertItems(at: indexPaths)
//            return
//        }
//        guard let container = moduleContainer() else { return }
//        var containerIndexPaths = [IndexPath]()
//        indexPaths.map { (indexPath) in
//            let containerIndex = containerIndexPath(of: indexPath)
//            containerIndexPaths.append(containerIndex)
//        }
//        container.isInserting = true
//        let collectionView = container.contentView
//        collectionView.performBatchUpdates({
//            collectionView.insertItems(at: containerIndexPaths)
//        }, completion: { (_) in
//            container.isInserting = false
//            if container.shouldReload {
//                self.reloadCollectionView()
//                container.shouldReload = false
//            }
//        })
    }
    
    public var messageBus: MessageBus {
        return moduleContainer().messageBus
    }
    
    // extension for protocol
    
    public var nibIdentifiers: [(nib: UINib?, id: String)] {
        return [(UINib?, String)]()
    }
    
    public var classIdentifiers: [(cls: Swift.AnyClass?, id: String)] {
        return [(UICollectionViewCell.self, defaultClassIdentifier)]
    }

    public var supplementaryClassIdentifiers: [(cls: Swift.AnyClass?, kind: String, id: String)] {
        return [(UICollectionReusableView.self, UICollectionElementKindSectionHeader, defaultSupplementaryClassIdentifier)]
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: defaultClassIdentifier, for: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: defaultSupplementaryClassIdentifier, for: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .zero
    }
    
    public func layoutAttributesForItem(flowLayout: BaseFlowLayout, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {}
    public func moduleDidLoad() {}
    public func moduleWillAppear(_ animated: Bool) {}
    public func moduleDidAppear(_ animated: Bool) {}
    public func moduleWillDisappear(_ animated: Bool) {}
    public func moduleDidDisappear(_ animated: Bool) {}
    
    fileprivate func moduleContainer() -> ModuleContainerViewController {
        let container = parent as? ModuleContainerViewController
        guard container != nil else {
            fatalError("module should be used in container")
        }
        return container!
    }
    
    fileprivate func containerIndexPath(of indexPath: IndexPath) -> IndexPath {
        let container = moduleContainer()
        let index = (container.modules as [UIViewController]).index(of: self)
        return IndexPath(row: indexPath.row, section: index!)
    }
    
    internal func registerIdenfiers(in collectionView: UICollectionView, supplementaryStatus: RegisterSupplementaryStatus = .yes) {
        switch supplementaryStatus {
        case .only:
            supplementaryClassIdentifiers.forEach { (cls, kind, id) in
                collectionView.register(cls, forSupplementaryViewOfKind: kind, withReuseIdentifier: id)
            }
        case .yes:
            supplementaryClassIdentifiers.forEach { (cls, kind, id) in
                collectionView.register(cls, forSupplementaryViewOfKind: kind, withReuseIdentifier: id)
            }
            fallthrough
        case .no:
            classIdentifiers.forEach { (cls, id) in
                collectionView.register(cls, forCellWithReuseIdentifier: id)
            }
            
            nibIdentifiers.forEach { (nib, id) in
                collectionView.register(nib, forCellWithReuseIdentifier: id)
            }
        }
    }
}

enum RegisterSupplementaryStatus {
    
    case only
    case no
    case yes
}
