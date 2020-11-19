//
//  TabBarController.swift
//  NXFramework-Swift_Example
//
//  Created by ak on 2020/11/19.
//  Copyright © 2020 NXFramework-Swift. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller1 = HomeVC()
        let controller2 = MineVC()
  
        
        setupChildController(controller: controller1, title: "一", image: "my", selectedImage: "my")
        setupChildController(controller: controller2, title: "二", image: "my", selectedImage: "my")
     UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .selected)
        
 
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
        
            controller1.tabBarItem.nx.addBadge(text: "99+")

            controller2.tabBarItem.nx.addDot(color: .red)

            
     
        }
        
    }
    
    func setupChildController(controller: UIViewController, title: String, image: String, selectedImage: String) {
        
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage.init(named: image)?.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.selectedImage = UIImage.init(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        self.addChild(UINavigationController.init(rootViewController: controller))
        
    }
    
 

}
