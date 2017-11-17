//
//  ViewController.swift
//  ModuleContainerExample
//
//  Created by jeffery on 2017/11/15.
//  Copyright © 2017年 com.yy.jeffery. All rights reserved.
//

import UIKit
import ModuleContainer
import SnapKit

class ViewController: ModuleContainerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        contentView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func moduleList() -> [UIViewController & BaseModule] {
        return [Module1(), Module2(), Module3(), Module4()]
    }
}
