//
//  WebViewController.swift
//  KingFaisalPrice
//
//  Created by Apple on 12/13/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate,UIScrollViewDelegate  {

     @IBOutlet weak var mainContainer: UIView!
        
        var webView2: WKWebView?
        
        var overlayView = UIView()
        var activityIndicator = UIActivityIndicatorView()
        
        var refreshControl: UIRefreshControl = UIRefreshControl()
        
        var link:String?
        
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("Start to load")
        if #available(iOS 13.0, *) {
            showLoading()
        } else {
            // Fallback on earlier versions
        }
    }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("finish to load")
            hideLoading()
        }
        
        override func viewDidLoad() {
            //super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            
            webView2 = WKWebView(frame: mainContainer.bounds, configuration: WKWebViewConfiguration())
            webView2?.navigationDelegate = self
            webView2?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
            self.mainContainer.addSubview(webView2!)
            
            self.navigationItem.backBarButtonItem?.title = "رجوع"
            self.navigationController?.navigationItem.backBarButtonItem?.title = "رجوع"
            
            let url2 = URL(string: link!)!
            webView2?.load(URLRequest(url: url2))
            webView2?.allowsBackForwardNavigationGestures = true
            
            
            refreshControl.bounds = CGRect(x: 0,y: 50,width: 0,height: 0)
            
            
            refreshControl.attributedTitle = NSAttributedString(string: "")
            
            // #selector(refresh) = "refresh" function called
            refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
            
            // TintColor - Color of Activity Indicator
            refreshControl.tintColor = UIColor.white
            refreshControl.isHidden = true
            
            
            
            // Add RefreshControl to WebView
            webView2?.scrollView.addSubview(refreshControl)
            
            webView2?.scrollView.delegate = self
            
            if #available(iOS 10.0, *) {
                webView2?.configuration.dataDetectorTypes = .phoneNumber
            } else {
                // Fallback on earlier versions
            }
            
            
        }
        
        @objc func back(sender: UIBarButtonItem) {
            // Perform your custom actions
            // ...
            // Go back to the previous ViewController
            if((webView2?.canGoBack)!)
            {
                webView2?.goBack()
            }else
            {
                hideLoading()
                _ = navigationController?.popViewController(animated: true)
            }
            
        }
        
        
        @objc func refresh(refresh:UIRefreshControl) {
            webView2?.reload()
            print("refresh")
            refreshControl.endRefreshing()
        }
     
        
    @available(iOS 13.0, *)
    func showLoading() {
            if  let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let window = appDelegate.window {
                
                //            view.isUserInteractionEnabled = false
                overlayView.frame = CGRect(x:0, y:0, width:200, height:80)
                overlayView.center = CGPoint(x: window.frame.width / 2.0, y: window.frame.height / 2.0)
                overlayView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
                overlayView.clipsToBounds = true
                overlayView.layer.cornerRadius = 10
                
                activityIndicator.frame = CGRect(x:0, y:0, width:40, height:40)
                activityIndicator.style = .whiteLarge
                activityIndicator.color = UIColor.gray
                activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
                activityIndicator.center = window.center
                
                overlayView.addSubview(activityIndicator)
                window.addSubview(activityIndicator)
                activityIndicator.startAnimating()
            }
        }
        func hideLoading() {
            //        view.isUserInteractionEnabled = true
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
        
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.request.url?.scheme == "tel" {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
                    print("print 1")
                } else {
                    UIApplication.shared.openURL(navigationAction.request.url!)
                    print("print 2")
                }
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }
        
        
        
    }

