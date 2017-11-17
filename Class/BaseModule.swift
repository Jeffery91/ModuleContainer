//
//  BaseModule.swift
//  Pods
//
//  Created by jeffery on 2017/8/21.
//
//

import UIKit

public protocol BaseModule {
    
    var flowLayout: UICollectionViewFlowLayout { get }
    
    var classIdentifiers: [(cls: Swift.AnyClass?, id: String)] { get }
    
    var nibIdentifiers: [(nib: UINib?, id: String)] { get }
    
    var supplementaryClassIdentifiers: [(cls: Swift.AnyClass?, kind: String, id: String)] { get }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    
    func layoutAttributesForItem(flowLayout: BaseFlowLayout, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
    
    func moduleDidLoad()
    func moduleWillAppear(_ animated: Bool)
    func moduleDidAppear(_ animated: Bool)
    func moduleWillDisappear(_ animated: Bool)
    func moduleDidDisappear(_ animated: Bool)
}
