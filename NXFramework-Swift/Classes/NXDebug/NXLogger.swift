//
//  NXLogger.swift
//  NXFramework-Swift-Demo
//
//  Created by ak on 2020/10/26.
//  Copyright © 2020 NXFramework-Swift. All rights reserved.
//

import UIKit


public enum NXLoggerLevel: Int {
    case info = 1
    case debug = 2
    case warning = 3
    case error = 4
    case none = 5
    
    var name: String {
        switch self {
            case .info: return "i"
            case .debug: return "d"
            case .warning: return "w"
            case .error: return "e"
            case .none: return "N"
        }
    }
}

public enum LoggerOutput: String {
    case debuggerConsole
    case deviceConsole
    case fileOnly
    case debugerConsoleAndFile
    case deviceConsoleAndFile
}


private let fileExtension = "txt"
private let LOG_BUFFER_SIZE = 10

public class NXLogger: NSObject {

    // MARK: - Output
    public var tag: String?
    public var level: NXLoggerLevel = .none
    public var ouput: LoggerOutput = .debuggerConsole
    public var showThread: Bool = false
    
    // MARK: - Init
    private let isolationQueue = DispatchQueue(label: "com.nxframework.isolation", qos: .background, attributes: .concurrent)
    private let serialQueue = DispatchQueue(label: "com.nxframework.swiftylog")
    private let logSubdiretory = NXFileManager.documentDirectoryURL.appendingPathComponent(fileExtension)

    public static let shared = NXLogger()
    
    private var _data: [String] = []
    private var data: [String] {
        get { return isolationQueue.sync { return _data } }
        set { isolationQueue.async(flags: .barrier) { self._data = newValue } }
    }
    
    private var logUrl: URL? {
        let fileName = "NSFrameworkSwiftyLog"
        try? FileManager.default.createDirectory(at: logSubdiretory, withIntermediateDirectories: false)
        let url = logSubdiretory.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        return url
    }
    
    private override init() {
        super.init()
     
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name:  UIApplication.willResignActiveNotification, object: nil)
   
    }
    
    // MARK: - Methods
    @objc private func appMovedToBackground() {
         self.saveAsync()
    }
    
    func saveAsync() {
        guard let url = logUrl else { return }
        serialQueue.async { [weak self] in
            guard let count = self?.data.count, count > 0 else { return }

            var stringsData = Data()
            
            self?.data.forEach { (string) in
                if let stringData = (string + "\n").data(using: String.Encoding.utf8) {
                    stringsData.append(stringData)
                } else {
                    print("MutalbeData failed")
                }
            }

            do {
                try stringsData.append2File(fileURL: url)
                self?.data.removeAll()
            } catch let error as NSError {
                print("wrote failed: \(url.absoluteString), \(error.localizedDescription)")
            }
        }
    }
    
    func removeAllAsync() {
        guard let url = logUrl else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            try? FileManager.default.removeItem(at: url)
        }
    }
    
    func load() -> [String]? {
        guard let url = logUrl else { return nil }
        guard let strings = try? String(contentsOf: url, encoding: String.Encoding.utf8) else { return nil }

        return strings.components(separatedBy: "\n")
    }

    private func log(_ level: NXLoggerLevel, message: String, currentTime: Date, fileName: String , functionName: String, lineNumber: Int, thread: Thread) {
        
        guard level.rawValue >= self.level.rawValue else { return }
        
        
        let _fileName = fileName.split(separator: "/")
        let text = "\(level.name)-\(showThread ? thread.description : "")[\(_fileName.last ?? "?")#\(functionName)#\(lineNumber)]\(tag ?? ""): \(message)"
        
        switch self.ouput {
            case .fileOnly:
                addToBuffer(text: "\(currentTime.iso8601) \(text)")
            case .debuggerConsole:
                print("\(currentTime.iso8601) \(text)")
            case .deviceConsole:
                NSLog(text)
            case .debugerConsoleAndFile:
                print("\(currentTime.iso8601) \(text)")
                addToBuffer(text: "\(currentTime.iso8601) \(text)")
            case .deviceConsoleAndFile:
                NSLog(text)
                addToBuffer(text: "\(currentTime.iso8601) \(text)")
        }
    }
    
    private func addToBuffer(text: String) {
        isolationQueue.async(flags: .barrier) { self._data.append(text) }
        if data.count > LOG_BUFFER_SIZE {
            saveAsync()
        }
    }
    
}

// MARK: - Output
extension NXLogger {
    public func i(_ message: String, currentTime: Date = Date(), fileName: String = #file, functionName: String = #function, lineNumber: Int = #line, thread: Thread = Thread.current ) {
        log(.info, message: message, currentTime: currentTime, fileName: fileName, functionName: functionName, lineNumber: lineNumber, thread: thread)
    }
    public func d(_ message: String, currentTime: Date = Date(), fileName: String = #file, functionName: String = #function, lineNumber: Int = #line, thread: Thread = Thread.current ) {
        log(.debug, message: message, currentTime: currentTime, fileName: fileName, functionName: functionName, lineNumber: lineNumber, thread: thread)
    }
    public func w(_ message: String, currentTime: Date = Date(), fileName: String = #file, functionName: String = #function, lineNumber: Int = #line, thread: Thread = Thread.current ) {
        log(.warning, message: message, currentTime: currentTime, fileName: fileName, functionName: functionName, lineNumber: lineNumber, thread: thread)
    }
    public func e(_ message: String, currentTime: Date = Date(), fileName: String = #file, functionName: String = #function, lineNumber: Int = #line, thread: Thread = Thread.current ) {
        log(.error, message: message, currentTime: currentTime, fileName: fileName, functionName: functionName, lineNumber: lineNumber, thread: thread)
    }
    
    public func synchronize() {
        saveAsync()
    }
}



