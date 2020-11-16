//
//  NSMutableArray+NXExtension.swift
//  SwiftKit
//
//  Created by 袁涛 on 2020/10/10.
//  Copyright © 2020 Y_T. All rights reserved.
//

import Foundation

// MARK:- 添加操作
extension NSMutableArray {
    /// 添加解包后的元素
    /// - Parameter anObject: 添加的元素
    func nx_safeAdd(_ anObject: Any?) -> Bool {
        guard let object = anObject else {
            return false
        }
        add(object)
        return true
    }
 
}

extension NSMutableArray {
    /// 插入解包后元素 成功true
    /// - Parameter anObject: 插入元素
    /// - Parameter index: 插入位置
    func nx_safeInsert(_ anObject: Any?, at index: Int) -> Bool {
        guard let object = anObject else {
            return false
        }
        
        if self.count <= index {
            return false
        }
        
        insert(object, at: index)
        return true
    }
}

