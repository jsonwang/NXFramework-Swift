//
//  HomeVC.swift
//  NXFramework-Swift_Example
//
//  Created by ak on 2020/11/19.
//  Copyright © 2020 NXFramework-Swift. All rights reserved.
//


import UIKit

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
//        setupViews()
        /**
         iOS11系统下 -(void)viewDidLoad中获取不到UIBarButtonItem的实例,demo为了演示效果做了0.001s的延时操作,
         在实际开发中,badge的显示是在网络请求成功/推送之后,所以不用担心获取不到UIBarButtonItem添加不了badge
         */
        if (UIDevice.current.systemVersion as NSString).doubleValue >= 11.0 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
                self.setupBadges()
            })
            return
        }
        
        setupBadges()
    }

    func setupBadges() {
        

        // 1.给UIBarButtonItem添加badge
        // 1.1 左边
        self.navigationItem.leftBarButtonItem?.nx.addBadge(number: 1)
        // 调整badge大小
//        self.navigationItem.leftBarButtonItem?.pp.setBadgeHeight(points: 21.0)
        // 调整badge的位置
//        self.navigationItem.leftBarButtonItem?.pp.moveBadge(x: -7, y: 5)
        // 自定义badge的属性: 字体大小/颜色, 背景颜色...(默认系统字体13,白色,背景色为系统badge红色)
        
        // 1.2 右边
        self.navigationItem.rightBarButtonItem?.nx.addBadge(number: 5000000)
        self.navigationItem.rightBarButtonItem?.nx.moveBadge(x: -5, y: 0)
        self.navigationItem.rightBarButtonItem?.nx.setBadge(flexMode: .head)
    }
    
//    func setupViews() {
//        self.tableView.rowHeight = 60
//        self.tableView.register(UINib.init(nibName: "PPTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .trash, target: self, action: #selector(deleteNum))
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addNum))
//    }
    
    @objc fileprivate func deleteNum() {
        self.navigationItem.leftBarButtonItem?.nx.decrease()
    }
    @objc fileprivate func addNum() {
        self.navigationItem.leftBarButtonItem?.nx.increase()
    }
    
}

extension HomeVC: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}
