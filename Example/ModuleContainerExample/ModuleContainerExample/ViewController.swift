//
//  ViewController.swift
//  ModuleContainerExample
//
//  Created by jeffery on 2017/11/15.
//  Copyright © 2017年 com.yy.jeffery. All rights reserved.
//

import UIKit
import ModuleContainer

class ViewController: ModuleContainerViewController {
    
    override func moduleList() -> [UIViewController & BaseModule] {
        return [Module1(), Module2(), Module3(), Module4()]
    }
}
