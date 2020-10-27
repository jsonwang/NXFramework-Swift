//
//  NXLoggerVC.swift
//  NXFramework-Swift-Demo
//
//  Created by ak on 2020/10/26.
//  Copyright © 2020 NXFramework-Swift. All rights reserved.
//
 
import UIKit
import MessageUI
import WebKit


private let screenWidth = UIScreen.main.bounds.width
private let screenHeight = UIScreen.main.bounds.height
private let keyWindow = UIApplication.shared.keyWindow

let themeColor: UIColor = UIColor.hex(hex: 0x00B3C4)

class NXLoggerVC: UIViewController {

    var delegate: LoggerAction?
    
    var data: String = "" {
        didSet {
            loadWebView()
        }
    }
    //日志文件本地地址
    var logFilePath:URL?

    var webView: WKWebView = {
        
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=0.6, maximum-scale=0.8, user-scalable=yes';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);";
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController: WKUserContentController = WKUserContentController()
        let conf = WKWebViewConfiguration()
        conf.userContentController = userContentController
        userContentController.addUserScript(script)
        let view = WKWebView(frame: CGRect.zero, configuration: conf)
   
        return view
    }()
    
    var textView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    var btnSend: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = themeColor
        button.setTitleColor(.white, for: .normal)
        button.roundedCorners(cornerRadius: 5)
        button.setTitle("分享日志", for: .normal)
        button.addTarget(self, action: #selector(btnSendPressed(_:)), for: .touchUpInside)
        
        return button
    }()
    
    var btnRemove: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = themeColor
        button.setTitleColor(.white, for: .normal)
        button.roundedCorners(cornerRadius: 5)
        button.setTitle("清空日志", for: .normal)
        button.addTarget(self, action: #selector(btnRemovePressed(_:)), for: .touchUpInside)
        return button
    }()
    var btnCancel: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = themeColor
        button.setTitleColor(.white, for: .normal)
        button.roundedCorners(cornerRadius: 5)
        button.setTitle("取消", for: .normal)
        button.addTarget(self, action: #selector(btnCancelPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubViews()
        
        loadWebView()

    }
    
    private func addSubViews() {
        self.view.backgroundColor = UIColor.white
        
        [webView, btnSend, btnRemove, btnCancel].forEach { (subView: UIView) in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        let views: [String:UIView] = ["webView": webView, "btnSend": btnSend, "btnRemove": btnRemove, "btnCancel": btnCancel]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[webView]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(16)-[btnSend]-(16)-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(16)-[btnRemove]-(16)-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(16)-[btnCancel]-(16)-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(20)-[webView]-[btnSend(==32)]-[btnRemove(==32)]-[btnCancel(==32)]-(8)-|", options: [], metrics: nil, views: views))
    }
    
    @objc func btnCancelPressed(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnSendPressed(_ button: UIButton) {
 
        let activityViewController = UIActivityViewController(activityItems: [logFilePath as Any] , applicationActivities: nil)

        present(activityViewController,
            animated: true,
            completion: nil)
    }
    
    @objc func btnRemovePressed(_ button: UIButton) {
        delegate?.removeAll()
    }
  
    private func loadWebView() {
        webView.loadHTMLString(data, baseURL: nil)
   
 
    }
}
    
extension NXLoggerVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
            case .cancelled:
                self.showAlert(withTitle: "Cancel", message: "Send email canceled")
                break
            case .sent:
                break
            case .failed:
                self.showAlert(withTitle: "Failed", message: "Send email failed")
                break
            case .saved:
                break
        @unknown default:
            fatalError("default ")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
