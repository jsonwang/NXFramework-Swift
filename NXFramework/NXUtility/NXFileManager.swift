//
//  NXFileManager.swift
//  NXFramework-Swift-Demo
//
//  Created by ak on 2020/10/26.
//  Copyright © 2020 NXOrganization. All rights reserved.
//
/*

本类功能, 文件操作.(ios, mac)

一,iOS目录结构说明
1,沙盒目录结构
├── Documents - 存储用户数据或其它应该定期备份的
├── Library
│   ├── Caches -
用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息
│   │   └── Snapshots
│   │       └── com.youyouxingyuan.re
│   │           ├── A85B73F0-26A8-44E4-A761-446CAB8DAB38@2x.png
│   │           └── BFAD5885-B767-4320-9A4B-555EC881C50D@2x.png
│   └── Preferences - 偏好设置文件 NSUserDefaults 保存的数据
└── tmp - 这个目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息

2,在iOS8之后，应用每一次重启，沙盒路径都动态的发生了变化但不用担心数据问题,苹果会把你上一个路径中的数据转移到你新的路径中。你上一个路径也会被苹果毫无保留的删除，只保留最新的路径。

@see  <Foundation/NSPathUtilities.h>

*/
import UIKit

class NXFileManager: NSObject {
    
    static var documentDirectoryURL: URL {
      return try! FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: false
      )
    }

}
