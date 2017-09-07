//
//  H5ViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/24.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/****************************************************************************************************/
/*
**
** 这是H5页面视图，凡是要加载H5页面的只要传一个URL字符串即可
** 从这里可以进入H5页面，现在的APP大多开始流行H5混合开发
** 这样大大减少移动端的开发压力，减少bug，缩短开发流程，页面加载跟快，更流畅，更好维护，缩小APP的大小
** 各方面效果都不错，用户体验也不错，只是烧流量，当然还与网络有关
**
*/
/****************************************************************************************************/


import UIKit

class H5ViewController: BaseViewController, UIWebViewDelegate {
    
    var URLString: String!
    private var mWebView: UIWebView!
    private var activityView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    convenience init(urlString: String) {
        self.init()
        URLString = urlString
        self.view.backgroundColor = BACKGROUNDCOLOR
        setupNavigationBar()
        setupWebView()
    }
    
    func setupNavigationBar() {
        
        ///right button item
        let rBtn = UIButton(type: UIButtonType.system)
        rBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 35)
        rBtn.setTitle("适应屏幕", for: UIControlState())
        rBtn.addTarget(self, action: #selector(H5ViewController.adjustDisplay(_:)), for: UIControlEvents.touchUpInside)
        let rightItem = UIBarButtonItem(customView: rBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
        let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        backBtn.setImage(UIImage(named: "back@2x.png"), for: UIControlState())
        backBtn.addTarget(self, action: #selector(H5ViewController.backBtnAction), for: UIControlEvents.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        
    }
    
    func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func adjustDisplay(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
        mWebView.autoresizesSubviews = btn.isSelected
        mWebView.scalesPageToFit = btn.isSelected
        loadWebViewData()//reload
    }
    
    func setupWebView() {
        mWebView = UIWebView(frame: CGRect(x: 0, y: 64, width: SCREENWIDTH, height: SCREENHEIGHT - 64))
        self.view.addSubview(mWebView)
        mWebView.delegate = self
        
        loadWebViewData()
        
        activityView = UIActivityIndicatorView(frame: CGRect(x: SCREENWIDTH/2-15, y: SCREENHEIGHT/2-15, width: 30, height: 30))
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        self.view.bringSubview(toFront: activityView)
    }
    
    func loadWebViewData() {
        let url = URL(string: URLString)
        let req = URLRequest(url: url as! URL, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy,timeoutInterval: 6000)
        mWebView.loadRequest(req, progress: nil, success: {
            
            (response: HTTPURLResponse, str: String) -> String in
            
            let code = response.statusCode
            
            return "加载成功：" + "\(code)"
            
            }) { (error: Error) -> Void in
                print(error.localizedDescription)
        }
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        activityView.startAnimating()
        return true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activityView.stopAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityView.stopAnimating()
        let theTitle = webView.stringByEvaluatingJavaScript(from: "document.title")
        self.title = theTitle
    }
    
    
    
    /****************************************************************************************************/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

