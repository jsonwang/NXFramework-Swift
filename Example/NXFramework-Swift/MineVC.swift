//
//  MineVC.swift
//  NXFramework-Swift_Example
//
//  Created by ak on 2020/11/19.
//  Copyright © 2020 NXFramework-Swift. All rights reserved.
//

import UIKit

class MineVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = UIColor.blue
        testView.nx.addBadge(number: 10)
        view.addSubview(testView)
        
        
        let leftButton = UIButton.init(type: .custom)
        leftButton.frame = CGRect.init(x: 100, y: 100, width: 50, height:50)
        leftButton.badgeView.text = "99+"
        leftButton.backgroundColor = .yellow
        view.addSubview(leftButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
