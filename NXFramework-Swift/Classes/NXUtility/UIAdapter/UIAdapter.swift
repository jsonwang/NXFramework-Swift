//
//  UIAdatper.swift
//  WJLiveDemo
//
//  Created by liuming on 2021/7/22.
//

import Foundation
import UIKit
public enum AdapterMode {
    case i_6s
    case i_6plus
    case i_6sPlus
    case i_SE
    case i_7
    case i_7Plus
    case i_8
    case i_8Plus
    case i_x
    case i_xs
    case i_xsMax
    case i_xr
    case i_11
    case i_11Pro
    case i_11ProMax
    case i_12
    case i_12Pro
    case i_12ProMax
}

let deviceSizeMap: [AdapterMode: CGSize] = [
    AdapterMode.i_6s: CGSize(width: 750 / 2, height: 1334 / 2),
    AdapterMode.i_6plus: CGSize(width: 441, height: 736),
    AdapterMode.i_SE: CGSize(width: 320, height: 568),
    AdapterMode.i_7: CGSize(width: 375, height: 667),
    AdapterMode.i_7Plus: CGSize(width: 414, height: 736),
    AdapterMode.i_8: CGSize(width: 375, height: 667),
    AdapterMode.i_8Plus: CGSize(width: 414, height: 736),
    AdapterMode.i_x: CGSize(width: 375, height: 812),
    AdapterMode.i_xs: CGSize(width: 375, height: 812),
    AdapterMode.i_xsMax: CGSize(width: 414, height: 896),
    AdapterMode.i_xr: CGSize(width: 414, height: 896),
    AdapterMode.i_11: CGSize(width: 375, height: 896),
    AdapterMode.i_11Pro: CGSize(width: 375, height: 812),
    AdapterMode.i_11ProMax: CGSize(width: 414, height: 896),
    AdapterMode.i_12: CGSize(width: 390, height: 844),
    AdapterMode.i_12Pro: CGSize(width: 390, height: 844),
    AdapterMode.i_12ProMax: CGSize(width: 428, height: 926),
]

func getStandardSize(adaptMode: AdapterMode, defaultMode: AdapterMode = .i_6s) -> CGSize {
    guard let size = deviceSizeMap[adaptMode] else {
        return deviceSizeMap[defaultMode]!
    }
    return size
}

public protocol AdapterEable {
    static func * (lsh: Self, rsh: CGFloat) -> Self
    var adpaptValue: Self { get }
}

public extension AdapterEable {
    var adpaptValue: Self {
        return UIAdapter.adapter(element: self)
    }
}

public enum UIAdapter {
    public static var standardMode: AdapterMode = .i_6s
    static var scale: CGFloat {
        let standardSize = getStandardSize(adaptMode: standardMode)
        let width = UIScreen.main.bounds.width
        return width / standardSize.width
    }
    
    static func adapter<T>(element: T) -> T where T: AdapterEable {
        return element * scale
    }
}

extension CGSize: AdapterEable {
    public static func * (lsh: CGSize, rsh: CGFloat) -> CGSize {
        return CGSize(width: lsh.width * rsh, height: lsh.height * rsh)
    }
}

extension CGPoint: AdapterEable {
    public static func * (lsh: CGPoint, rsh: CGFloat) -> CGPoint {
        return CGPoint(x: lsh.x * rsh, y: lsh.y * rsh)
    }
}

extension CGRect: AdapterEable {
    public static func * (lsh: CGRect, rsh: CGFloat) -> CGRect {
        return CGRect(origin: lsh.origin * rsh, size: lsh.size * rsh)
    }
}

extension CGFloat: AdapterEable {}
extension Float: AdapterEable {
    public static func * (lsh: Float, rsh: CGFloat) -> Float {
        return lsh * Float(rsh)
    }
}

extension Double: AdapterEable {
    public static func * (lsh: Double, rsh: CGFloat) -> Double {
        return lsh * Double(rsh)
    }
}

extension UIEdgeInsets: AdapterEable {
    public static func * (lsh: UIEdgeInsets, rsh: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: lsh.top * rsh, left: lsh.left * rsh, bottom: lsh.bottom * rsh, right: lsh.right * rsh)
    }
}
