//
//  NXLoggerManager.swift
//  NXFramework-Swift-Demo
//
//  Created by ak on 2020/10/26.
//  Copyright © 2020 NXFramework-Swift. All rights reserved.
//

import UIKit

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard NXLogger.shared.level != .none else { return }
        guard NXLogger.shared.ouput == .debugerConsoleAndFile
            || NXLogger.shared.ouput == .deviceConsoleAndFile
            || NXLogger.shared.ouput == .fileOnly else { return }
        
        NXLogger.shared.saveAsync()
        let manager = LoggerManager()
        manager.show()
    }
}

protocol LoggerAction {
    func removeAll()
}

class LoggerManager: NSObject {
    let controller = NXLoggerVC()
    public func show() {
        guard let topViewController = UIApplication.topViewController() else { return }
        guard topViewController .isKind(of: NXLoggerVC.self) == false else { return }
        
        controller.data = " \(loadLog())\(deviceInfo())"
        controller.logFilePath =  NXLogger.shared.logUrl
        controller.delegate = self
        
        topViewController.present(controller, animated: true, completion: nil)
    }
    
    private func loadLog() -> String {
        var texts: [String] = []
        
        guard let data = NXLogger.shared.load() else { return "" }
        
        data.forEach { (string) in
            texts.append("<pre style=\"line-height:8px;\">\(string)</pre>")
        }
        
        return texts.joined()
    }
    
    private func deviceInfo() -> String {
        var texts:[String] = []
        
        texts.append("<pre style=\"line-height:8px;\">==============================================</pre>")
        NXDeviceManager.info().forEach { (string) in
            texts.append("<pre style=\"line-height:8px;\">\(string)</pre>")
        }
        return texts.joined()
    }
}

extension LoggerManager: LoggerAction {
    func removeAll() {
        NXLogger.shared.removeAllAsync()
        controller.data = deviceInfo()
    }
}
