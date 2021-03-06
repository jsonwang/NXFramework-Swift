
//
//  UITabBarItem+NXBadgeView.swift
//  NXFramework-Swift
//
//  Created by ak on 2020/11/11.
//

import Foundation

public extension NX where Base: UITabBarItem {
    
    var badgeView: NXBadgeControl {
        return _bottomView.nx.badgeView
    }
    
    /// 添加带文本内容的Badge, 默认右上角, 红色, 18pts
    ///
    /// Add Badge with text content, the default upper right corner, red backgroundColor, 18pts
    ///
    /// - Parameter text: 文本字符串
    func addBadge(text: String) {
        _bottomView.nx.addBadge(text: text)
        _bottomView.nx.moveBadge(x: 4, y: 3)
    }
    
    /// 添加带数字的Badge, 默认右上角,红色,18pts
    ///
    /// Add the Badge with numbers, the default upper right corner, red backgroundColor, 18pts
    ///
    /// - Parameter number: 整形数字
    func addBadge(number: Int) {
        _bottomView.nx.addBadge(number: number)
        _bottomView.nx.moveBadge(x: 4, y: 3)
    }
    
    /// 添加带颜色的小圆点, 默认右上角, 红色, 8pts
    ///
    /// Add small dots with color, the default upper right corner, red backgroundColor, 8pts
    ///
    /// - Parameter color: 颜色
    func addDot(color: UIColor?) {
        _bottomView.nx.addDot(color: color)
    }
    
    /// 设置Badge的偏移量, Badge中心点默认为其父视图的右上角
    ///
    /// Set Badge offset, Badge center point defaults to the top right corner of its parent view
    ///
    /// - Parameters:
    ///   - x: X轴偏移量 (x<0: 左移, x>0: 右移) axis offset (x <0: left, x> 0: right)
    ///   - y: Y轴偏移量 (y<0: 上移, y>0: 下移) axis offset (Y <0: up,   y> 0: down)
    func moveBadge(x: CGFloat, y: CGFloat) {
        _bottomView.nx.moveBadge(x: x, y: y)
    }
    
    /// 设置Badge伸缩的方向
    ///
    /// Setting the direction of Badge expansion
    ///
    /// PPBadgeViewFlexModeHead,    左伸缩 Head Flex    : <==●
    /// PPBadgeViewFlexModeTail,    右伸缩 Tail Flex    : ●==>
    /// PPBadgeViewFlexModeMiddle   左右伸缩 Middle Flex : <=●=>
    /// - Parameter flexMode : Default is PPBadgeViewFlexModeTail
    func setBadge(flexMode: NXBadgeViewFlexMode = .tail) {
        _bottomView.nx.setBadge(flexMode: flexMode)
    }
    
    /// 设置Badge的高度,因为Badge宽度是动态可变的,通过改变Badge高度,其宽度也按比例变化,方便布局
    ///
    /// (注意: 此方法需要将Badge添加到控件上后再调用!!!)
    ///
    /// Set the height of Badge, because the Badge width is dynamically and  variable.By changing the Badge height in proportion to facilitate the layout.
    ///
    /// (Note: this method needs to add Badge to the controls and then use it !!!)
    ///
    /// - Parameter height: 高度大小
    func setBadge(height: CGFloat) {
        _bottomView.nx.setBadge(height: height)
    }
    
    
    /// 显示Badge
    func showBadge() {
        _bottomView.nx.showBadge()
    }
    
    /// 隐藏Badge
    func hiddenBadge() {
        _bottomView.nx.hiddenBadge()
    }
    
    // MARK: - 数字增加/减少, 注意:以下方法只适用于Badge内容为纯数字的情况
    // MARK: - Digital increase /decrease, note: the following method applies only to cases where the Badge content is purely numeric
    /// badge数字加1
    func increase() {
        _bottomView.nx.increase()
    }
    
    /// badge数字加number
    func increaseBy(number: Int) {
        _bottomView.nx.increaseBy(number: number)
    }
    
    /// badge数字加1
    func decrease() {
        _bottomView.nx.decrease()
    }
    
    /// badge数字减number
    func decreaseBy(number: Int) {
        _bottomView.nx.decreaseBy(number: number)
    }
    
    /// 通过Xcode视图调试工具找到UITabBarItem原生Badge所在父视图
    private var _bottomView: UIView {
        let tabBarButton = (self.base.value(forKey: "_view") as? UIView) ?? UIView()
        for subView in tabBarButton.subviews {
            guard let superclass = subView.superclass else { return tabBarButton }
            if superclass == NSClassFromString("UIImageView") {
                return subView
            }
        }
        return tabBarButton
    }
}
