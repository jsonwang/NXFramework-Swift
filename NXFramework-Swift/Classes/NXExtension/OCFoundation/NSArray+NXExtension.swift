//
//  NSArray+NXExtension.swift
//  SwiftKit
//
//  Created by 袁涛 on 2020/10/10.
//  Copyright © 2020 Y_T. All rights reserved.
//

import Foundation


// MARK:- 修改操作
extension NSArray {
   
}

// MARK:- 访问操作
extension NSArray {
    func nx_safeObject(at index : Int) -> Element? {
        if self.count <= index {
            return nil
        }
        return object(at: index)
    }
}

// MARK:- 删除
extension NSArray {
    
}

extension NSArray {
    /// 添加元素
    /// - Parameter anObject: 被添加元素
    func nx_safeAdding(anObject : Element?) -> [Element] {
        guard let object = anObject else {
            return self as! [NSArray.Element]
        }
        return adding(object)
    }
    
    /// 拼接素组
    /// - Parameter otherArray: 被拼接的数组
    func nx_safeAddingObjects(from otherArray: [Element]?) -> [Element] {
        guard let objects = otherArray else {
            return self as! [NSArray.Element]
        }
        return addingObjects(from: objects)
    }
}

