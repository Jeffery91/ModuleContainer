//
//  Module2Cell.swift
//  ModuleContainerExample
//
//  Created by jeffery on 2017/11/15.
//  Copyright © 2017年 com.yy.jeffery. All rights reserved.
//

import UIKit
import SnapKit

class Module2Header: UICollectionReusableView {
    
    static let id = "Module2Header"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        
        let label = UILabel()
        addSubview(label)
        label.text = "Module2Header"
        label.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Module2Footer: UICollectionReusableView {
    
    static let id = "Module2Footer"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        
        let label = UILabel()
        addSubview(label)
        label.text = "Module2Footer"
        label.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Module2Cell: UICollectionViewCell {
    
    static let id = "Module2Cell"
    
    lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
        addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


