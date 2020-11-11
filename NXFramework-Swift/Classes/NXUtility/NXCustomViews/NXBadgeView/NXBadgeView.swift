//
//  NXBadgeView.swift.swift
//  NXFramework-Swift
//
//  Created by ak on 2020/11/11.
//


import UIKit

public struct NX<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public extension NSObjectProtocol {
    var nx: NX<Self> {
        return NX(self)
    }
}

public enum NXBadgeViewFlexMode {
    case head    // 左伸缩 Head Flex    : <==●
    case tail    // 右伸缩 Tail Flex    : ●==>
    case middle  // 左右伸缩 Middle Flex : <=●=>
}
