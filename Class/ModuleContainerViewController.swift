//
//  ModuleContainerViewController.swift
//  Pods
//
//  Created by jeffery on 2017/8/21.
//
//

import UIKit
import RxSwift

open class ModuleContainerViewController: UIViewController {
    
    open func moduleList() -> [UIViewController & BaseModule] {
        fatalError("moduleList has not been implemented")
    }
    
    public var messageBus = MessageBus()
    
    var hoverVariable: (Hoverable & UIView)?
    
    var modules = [UIViewController & BaseModule]()
    
    var wrapperCells = [Int: ModuleWrapperCell]()
    
    lazy var contentView: UICollectionView = {
        var layout = ContainerFlowLayout()
        layout.modules = self.modules
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        var idx = 0
        self.modules.forEach { (module) in
            if module.flowLayout.scrollDirection == .horizontal {
                view.register(ModuleWrapperCell.self, forCellWithReuseIdentifier: "\(ModuleWrapperCell.id)\(idx)")
                module.registerIdenfiers(in: view, supplementaryStatus: .only)
            } else {
                module.registerIdenfiers(in: view)
            }
            idx += 1
        }
        return view
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        moduleList().forEach { (module) in
            addChildViewController(module)
            modules.append(module)
            module.moduleDidLoad()
        }
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        contentView.backgroundColor = .white
        
//        addObserver(for: contentView)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        modules.forEach { (moduel) in
            moduel.moduleWillAppear(animated)
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        modules.forEach { (moduel) in
            moduel.moduleDidAppear(animated)
        }
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        modules.forEach { (moduel) in
            moduel.viewWillDisappear(animated)
        }
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        modules.forEach { (moduel) in
            moduel.viewDidDisappear(animated)
        }
    }
    
    var isInserting = false
    var shouldReload = false
}

extension ModuleContainerViewController {
    
    public func scrollToModule(_ module: UIViewController & BaseModule) {
        guard let section = (modules as [UIViewController]).index(of: module) else { return }
        let count = module.collectionView(contentView, numberOfItemsInSection: 0)
        guard count > 0 else { return }
        contentView.scrollToItem(at: IndexPath(row: 0, section: section),
                                 at: .top,
                                 animated: true)
    }
    
    public func reloadModule(_ module: UIViewController & BaseModule) {
        guard let section = (modules as [UIViewController]).index(of: module) else { return }
        let count = contentView.numberOfSections
        guard count > section else { return }
        contentView.reloadSections([section])
    }
}

extension ModuleContainerViewController {
    
    fileprivate func moduleIndexPath(_ indexPath: IndexPath) -> IndexPath {
        return IndexPath(row: indexPath.row, section: 0)
    }
    
    fileprivate func setupWrapperCell(_ cell: ModuleWrapperCell, with module: UIViewController & BaseModule) {
        module.registerIdenfiers(in: cell.collection, supplementaryStatus: .no)
        cell.numberOfItems = {
            return module.collectionView(cell.collection, numberOfItemsInSection: 0)
        }
        
        cell.cellForItemAt = { indexPath in
            return module.collectionView(cell.collection, cellForItemAt: indexPath)
        }
        
        cell.sizeForItemAt = { indexPath in
            return module.flowLayout.itemSize
        }
        
        cell.minimumLineSpacing = {
            return module.flowLayout.minimumLineSpacing
        }
    }
}

extension ModuleContainerViewController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return modules.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let module = modules[section]
        if module.flowLayout.scrollDirection == .horizontal {
            return 1
        }
        return module.collectionView(collectionView, numberOfItemsInSection: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let module = modules[indexPath.section]
        if module.flowLayout.scrollDirection == .horizontal { return }
        module.collectionView(collectionView, willDisplay: cell, forItemAt: moduleIndexPath(indexPath))
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let module = modules[indexPath.section]
        if module.flowLayout.scrollDirection == .horizontal {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ModuleWrapperCell.id)\(indexPath.section)", for: indexPath) as! ModuleWrapperCell
            cell.collection.backgroundColor = collectionView.backgroundColor
            if wrapperCells[indexPath.section] == nil {
                wrapperCells[indexPath.section] = cell
                setupWrapperCell(cell, with: module)
            }
            return cell
        }
        let cell = module.collectionView(collectionView, cellForItemAt: moduleIndexPath(indexPath))
        if cell is Hoverable, hoverVariable == nil {
            hoverVariable = (cell as! (UIView & Hoverable))
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let module = modules[indexPath.section]
        let view = module.collectionView(contentView, viewForSupplementaryElementOfKind: kind, at: moduleIndexPath(indexPath))
        if view is Hoverable, hoverVariable == nil {
            hoverVariable = (view as! (Hoverable & UIView))
        }
        return view
    }
}

extension ModuleContainerViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let module = modules[indexPath.section]
        if  module.flowLayout.scrollDirection == .horizontal {
            return CGSize(width: collectionView.frame.width, height: module.flowLayout.itemSize.height)
        }
        let size = module.collectionView(collectionView,
                                         layout: collectionViewLayout,
                                         sizeForItemAt: moduleIndexPath(indexPath))
        if size != .zero {
            return size
        }
        return module.flowLayout.itemSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let module = modules[section]
        return module.flowLayout.minimumInteritemSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let module = modules[section]
        return module.flowLayout.minimumLineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let module = modules[section]
        return module.flowLayout.sectionInset
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let module = modules[section]
        return module.flowLayout.headerReferenceSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let module = modules[section]
        return module.flowLayout.footerReferenceSize
    }
}

extension ModuleContainerViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let module = modules[indexPath.section]
        module.collectionView(collectionView, didSelectItemAt: moduleIndexPath(indexPath))
    }
}
