//
//  ViewController.swift
//  NXFramework-Swift
//
//  Created by 287971051@qq.com on 10/27/2020.
//  Copyright (c) 2020 287971051@qq.com. All rights reserved.
//

import UIKit
import NXFramework_Swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
           
            let logger = NXLogger.shared
//            #if DEBUG
                logger.level = .info
                logger.ouput = .debugerConsoleAndFile
//                #endif
                logger.d("App Started....")
        print("sadfasdfad")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

