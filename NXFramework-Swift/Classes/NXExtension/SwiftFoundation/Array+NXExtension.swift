//
//  Array+NXExtension.swift
//  SwiftKit
//
//  Created by 袁涛 on 2020/10/10.
//  Copyright © 2020 Y_T. All rights reserved.
//

import Foundation

// MARK:- 插入操作
extension Array {
    /// 插入指定位置 成功返回 true
    /// - Parameter newElement: 指定对象
    /// - Parameter i: 指定位置
    mutating func nx_safeInsert(_ newElement: Element, at i: Int) -> Bool {
        if  self.count <= i && !self.isEmpty && i != 0  {
            return false
        }
        insert(newElement, at: i)
        return true
    }
    
    /// 插入指定位置
    /// - Parameter newElements: 指定集合类型
    /// - Parameter i: 指定位置
    mutating func nx_safeInsert<C>(contentsOf newElements: C, at i: Int) -> Bool where C : Collection, Self.Element == C.Element {
        if self.count <= i && !self.isEmpty && i != 0 {
            return false
        }
        insert(contentsOf: newElements, at: i)
        return true
    }
    
}

// MARK:- 修改操作
extension Array {
    /// 修改指定区间
    /// - Parameter subrange: 被修改区间
    /// - Parameter newElements: 替换集合
    mutating func nx_safeReplaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) -> Bool where Element == C.Element, C : Collection  {
        let selfRange = nx_bounds()
        if !selfRange.overlaps(subrange) || !(self.isEmpty && subrange.startIndex == 0) {
            return false
        }
        replaceSubrange(subrange, with: newElements)
        return true
    }
        
}

// MARK:- 访问操作
extension Array {
    mutating func nx_safeObjectOrNil(at index : Int) -> Element? {
        if self.count <= index {
            return nil
        }
        return self[index]
    }
    
    mutating func nx_safeObjectsOrNil(bounds : Range<Int>) -> ArraySlice<Element>? {
        if self.count <= bounds.startIndex || self.count <= bounds.startIndex + bounds.count {
            return nil
        }
        return self[bounds]
    }
 
    mutating func nx_safeObjectsOrNil(bounds : Range<Int>) -> Slice<Array<Element>>? {
        if self.count <= bounds.startIndex || self.count <= bounds.startIndex + bounds.count {
            return nil
        }
        return self[bounds]
    }
    
}


// MARK:- 删除
extension Array {
    /// 删除指定位置元素 成功返回 true
    /// - Parameter index: 指定位置
    mutating func nx_safeRemove(at index: Int) -> Bool {
        if self.count <= index {
            return false
        }
        remove(at: index)
        return true
    }
}

extension Array {
    mutating func nx_bounds() -> Range<Int> {
        return Range(0...(self.count-1))
    }
}
