//
//  ActivityDetailViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/20.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/****************************************************************************************************/
/*
**
** 这是活动详情视图（进入H5页面）
** 从这里可以进入H5页面，现在的APP大多开始流行H5混合开发
** 这样大大减少移动端的开发压力，减少bug，缩短开发流程，页面加载跟快，更流畅，更好维护，缩小APP的大小
** 各方面效果都不错，用户体验也不错，只是烧流量，当然还与网络有关
**
*/
/****************************************************************************************************/


import UIKit

class ActivityDetailViewController: BaseViewController, UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var URLString: String!
    private var webView: UIWebView!
    private var activityView: UIActivityIndicatorView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        //------------------------------------------//
//        self.view.backgroundColor = BACKGROUNDCOLOR
//        setupNavigationBar()
//        setupWebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
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
        let rBtn = UIButton(type: UIButtonType.System)
        rBtn.frame = CGRectMake(0, 0, 70, 35)
        rBtn.setTitle("适应屏幕", forState: UIControlState.Normal)
        rBtn.addTarget(self, action: Selector("adjustDisplay:"), forControlEvents: UIControlEvents.TouchUpInside)
        let rightItem = UIBarButtonItem(customView: rBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
        let backBtn = UIButton(frame: CGRectMake(0, 0, 30, 30))
        backBtn.setImage(UIImage(named: "back@2x.png"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backBtnAction"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        
    }
    
    func backBtnAction() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func adjustDisplay(btn: UIButton) {
        btn.selected = !btn.selected
        webView.autoresizesSubviews = btn.selected
        webView.scalesPageToFit = btn.selected
        loadWebViewData()//reload
    }
    
    func setupWebView() {
        webView = UIWebView(frame: CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 - 49))
        self.view.addSubview(webView)
        webView.delegate = self
        
        loadWebViewData()
        
        activityView = UIActivityIndicatorView(frame: CGRectMake(SCREENWIDTH/2-15, SCREENHEIGHT/2-15, 30, 30))
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        self.view.bringSubviewToFront(activityView)
    }
    
    func loadWebViewData() {
        let URL = NSURL(string: URLString)
        let req = NSURLRequest(URL: URL!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 6000)
        webView.loadRequest(req, progress: AutoreleasingUnsafeMutablePointer<NSProgress?>(), success: {
            
            (response: NSHTTPURLResponse, str: String) -> String in
            
            return "加载成功：" + "\(response.statusCode)"
            
            }) { (error: NSError) -> Void in
                print(error.localizedDescription)
        }
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        activityView.startAnimating()
        return true
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        activityView.stopAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityView.stopAnimating()
        let theTitle = webView.stringByEvaluatingJavaScriptFromString("document.title")
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
