//
//  ViewController.swift
//  NXFramework-Swift-Demo
//
//  Created by ak on 2020/10/26.
//  Copyright © 2020 NXOrganization. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logger = NXLogger.shared
        #if DEBUG
            logger.level = .info
            logger.ouput = .debugerConsoleAndFile
            #endif
            logger.d("App Started....")
    }


}

