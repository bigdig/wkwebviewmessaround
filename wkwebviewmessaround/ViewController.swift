//
//  ViewController.swift
//  wkwebviewmessaround
//
//  Created by Mark Bragg on 7/5/17.
//  Copyright © 2017 Mark Bragg. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKWebViewConfiguration()
        let source = "var video=document.getElementsByTagName(\"video\"); window.webkit.messageHandlers.movieListener.postMessage('howdy doody!!!!! ' + video[0].id); var i = 0, len = video.length; for(i = 0; i < len; i++) { video[i].addEventListener('play', function() { window.webkit.messageHandlers.movieListener.postMessage('play,' + video[0].id); }); video[i].addEventListener('pause', function() { window.webkit.messageHandlers.movieListener.postMessage('pause,' + video[0].id); }); video[i].addEventListener('seeked', function() { window.webkit.messageHandlers.movieListener.postMessage('seek,' + video[0].currentTime + ',' + video[0].id); }); video[i].addEventListener('ended', function() { window.webkit.messageHandlers.movieListener.postMessage('stop,' + video[0].id); });}"
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)
        config.userContentController = userContentController
        config.userContentController.add(self, name: "movieListener")
        
        webView = WKWebView(frame: UIScreen.main.bounds, configuration: config)
        webView.navigationDelegate = self
        view.addSubview(webView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webView.load(URLRequest(url: URL(string: "https://www.w3schools.com/tags/tryit.asp?filename=tryhtml5_av_event_playing")!))
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message: \(message.body)")
    }


}
