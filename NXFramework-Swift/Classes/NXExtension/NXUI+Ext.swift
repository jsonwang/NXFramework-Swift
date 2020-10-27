//
//  NXUI+Ext.swift
//  NXFramework-Swift-Demo
//
//  Created by ak on 2020/10/26.
//  Copyright © 2020 NXFramework-Swift. All rights reserved.
//

import UIKit

public extension UIViewController {
    func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}

// Shake oritention
public enum ShakeDirection: Int {
    case horizontal
    case vertical
}

public extension UIView {
    func shake(direction: ShakeDirection = .horizontal, times: Int = 5,
                      interval: TimeInterval = 0.1, delta: CGFloat = 2,
                      completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: interval, animations: { () -> Void in
            switch direction {
            case .horizontal:
                self.layer.setAffineTransform( CGAffineTransform(translationX: delta, y: 0))
                break
            case .vertical:
                self.layer.setAffineTransform( CGAffineTransform(translationX: 0, y: delta))
                break
            }
        }) { (complete) -> Void in
            if (times == 0) {
                // last shaking finish, reset location, callback
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) -> Void in
                    completion?()
                })
            }
            else {
                // not last shaking, continue
                self.shake(direction: direction, times: times - 1,  interval: interval,
                           delta: delta * -1, completion:completion)
            }
        }
    }
}


extension UIView {
    var x: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var y: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var centerX: CGFloat {
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
        get {
            return self.center.x
        }
    }
    
    var centerY: CGFloat {
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
        get {
            return self.center.y
        }
    }
    
    var width: CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    
    var size: CGSize {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return self.frame.size
        }
    }
    
    var origin: CGPoint {
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin
        }
    }
    
    var bottomY: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
        get {
            return self.height + self.y
        }
    }
    
    var rightX: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get {
            return self.width + self.x
        }
    }
    
    // MARK: - UIView round corner
    ///
    /// - Parameter cornerRadius: radius
    func roundedCorners(cornerRadius: CGFloat) {
        roundedCorners(cornerRadius: cornerRadius, borderWidth: 0, borderColor: nil)
    }
    
    ///
    /// - Parameters:
    ///   - cornerRadius:
    ///   - borderWidth:
    ///   - borderColor:
    func roundedCorners(cornerRadius: CGFloat?, borderWidth: CGFloat?, borderColor: UIColor?) {
        self.layer.cornerRadius = cornerRadius!
        self.layer.borderWidth = borderWidth!
        self.layer.borderColor = borderColor?.cgColor
        self.layer.masksToBounds = true
    }
    
    ///
    /// - Parameters:
    ///   - cornerRadius:
    ///   - rectCorner:
    func roundedCorners(cornerRadius: CGFloat?, rectCorner: UIRectCorner?) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: rectCorner!, cornerRadii: CGSize(width: cornerRadius!, height: cornerRadius!))
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.path = path.cgPath
        self.layer.mask = layer
    }
    
    ///
    /// - Parameters:
    ///   - colors:
    ///   - locations:
    ///   - startPoint: [0...1]
    ///   - endPoint: [0...1]
    func gradientColor(colors: [CGColor], locations: [NSNumber], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        /*
         // vertical
         gradientLayer.startPoint = CGPoint(x: 0, y: 0)
         gradientLayer.endPoint = CGPoint(x: 0, y: 1)
         */
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.frame
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - UIView blur
    ///
    /// - Parameter style: UIBlurEffectStyle
    func addBlurEffect(style: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = self.bounds
        self.backgroundColor = .clear
        self.addSubview(effectView)
        self.sendSubview(toBack: effectView)
    }
}
public extension UIView {
    
    /// 往当前视图添加一个子视图
    /// - Parameters:
    ///   - rect: 子视图大小
    ///   - bgColor: 子视图背景色
    /// - Returns: 子视图
    func nx_addView(rect:CGRect = .zero,bgColor:UIColor = .white) ->UIView{
        let view = UIView(frame: rect)
        view.backgroundColor = bgColor
        self.addSubview(view)
        return view
    }
    
    /// 往当前视图添加UIImageView
    /// - Parameters:
    ///   - image: 图片对象
    ///   - rect: UIImageView
    ///   - contentMode: 图片填充模式
    /// - Returns: 图片
     func nx_addImageView(image:UIImage?,rect:CGRect = .zero, contentMode:ContentMode = .scaleAspectFit)->UIImageView{
        let imageView = UIImageView(frame: rect);
        imageView.image = image
        imageView.contentMode = contentMode
        self.addSubview(imageView)
        return imageView
    }
    
    /// 添加文本控件
    /// - Parameters:
    ///   - fontSize: 文本大小
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - bgColor: 背景颜色
    /// - Returns: 文本控件
    func nx_addLabel(fontSize: CGFloat, text: String, textColor: UIColor, bgColor: UIColor) -> UILabel {
        return nx_addLabel(font: UIFont.systemFont(ofSize: fontSize),
                        text: text,
                        textColor: textColor,
                        bgColor: bgColor)
    }
    
    /// 添加文本控件
    /// - Parameters:
    ///   - font: 文本大小
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - bgColor: 背景颜色
    /// - Returns: 文本控件
    func nx_addLabel(font: UIFont, text: String, textColor: UIColor, bgColor: UIColor) -> UILabel {
        let label = UILabel(frame: .zero)
        label.font = font
        label.text = text
        label.textColor = textColor
        label.backgroundColor = bgColor
        self.addSubview(label)
        return label
    }
    
    /// 添加按钮控件
    /// - Parameters:
    ///   - rect: 控件大小
    ///   - title: 标题
    ///   - titleColor: 标题颜色
    ///   - font: 字体
    ///   - image: 图片
    ///   - bgImg: 背景图片
    ///   - target: 事件响应者
    ///   - action: 事件响应方法
    ///   - event: 响应事件
    /// - Returns: 按钮
    func nx_addButton(rect: CGRect, title: String, titleColor: UIColor, font: UIFont, image: UIImage?, bgImg: UIImage?, target: Any?, action: Selector?, event: UIControl.Event?) -> UIButton {
            let btn = UIButton(type: .custom)
            btn.frame = rect
            btn.setTitle(title, for: .normal)
            btn.setTitle(title, for: .highlighted)
            btn.setTitleColor(titleColor, for: .normal)
            btn.setTitleColor(titleColor, for: .highlighted)
            btn.setImage(image, for: .normal)
            btn.setImage(image, for: .highlighted)
            btn.setBackgroundImage(bgImg, for: .normal)
            btn.setBackgroundImage(bgImg, for: .highlighted)
            btn.titleLabel?.font = font
            if let sel = action, let e = event {
                btn.addTarget(target, action: sel, for: e)
            }
            addSubview(btn)
            return btn
        }
    
    /// 添加一个文本类型的按钮控件
    /// - Parameters:
    ///   - rect: 按钮大小
    ///   - title: 文本
    ///   - titleColor: 文本颜色
    ///   - target: 事件响应者
    ///   - action: 事件响应方法
    ///   - event:响应事件
    /// - Returns: 按钮控件
        func nx_addButton(rect: CGRect, title: String, titleColor: UIColor, target: Any?, action: Selector?, event: UIControl.Event?) -> UIButton {
            return nx_addButton(rect: rect,
                             title: title,
                             titleColor: titleColor,
                             font: UIFont.systemFont(ofSize: 14),
                             image: nil,
                             bgImg: nil,
                             target: target,
                             action: action,
                             event: event)
        }
    
    /// 添加图片类型按钮
    /// - Parameters:
    ///   - rect: 按钮大小
    ///   - image: 图片
    ///   - target: 事件响应者
    ///   - action: 事件响应方法
    ///   - event: 响应事件
    /// - Returns: 按钮控件
        func nx_addButton(rect: CGRect, image: UIImage, target: Any?, action: Selector?, event: UIControl.Event?) -> UIButton {
            return nx_addButton(rect: rect,
                             title: "",
                             titleColor: .white,
                             font: UIFont.systemFont(ofSize: 14),
                             image: image,
                             bgImg: nil,
                             target: target,
                             action: action,
                             event: event)
        }
    
    /// 添加tableView
    /// - Parameters:
    ///   - rect: 大小
    ///   - delegate: delegate对象
    ///   - dataSource: dataSource 对象
    /// - Returns: 表视图
    func nx_addTableView(rect: CGRect, delegate: UITableViewDelegate?,dataSource:UITableViewDataSource?) -> UITableView {
          let tableView = UITableView(frame: rect)
          tableView.delegate = delegate
          tableView.dataSource = dataSource
          backgroundColor = .white
          tableView.tableFooterView = UIView()
          if #available(iOS 11.0, *) {
              tableView.contentInsetAdjustmentBehavior = .never
          }
          return tableView
      }

}
 
