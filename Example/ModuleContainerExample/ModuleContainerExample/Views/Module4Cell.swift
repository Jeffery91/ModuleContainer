//
//  Module4Cell.swift
//  ModuleContainerExample
//
//  Created by jeffery on 2017/11/15.
//  Copyright © 2017年 com.yy.jeffery. All rights reserved.
//

import UIKit
import SnapKit

class Module4Cell: UICollectionViewCell {
    
    static let id = "Module4Cell"
    
    lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .orange
        
        addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
