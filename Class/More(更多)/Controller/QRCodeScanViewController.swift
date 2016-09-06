//
//  QRCodeScanViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/14.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/****************************************************************************************************/
/*
**
** 这是二维码扫描窗口
** OC 参考：http://yimouleng.com/2016/01/13/ios-QRCode/
**
*/
/****************************************************************************************************/

import UIKit
import AVFoundation ///

class QRCodeScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    private var session: AVCaptureSession!// 输入输出的中间链接
    private var maskVeiw: UIView!//蒙版
    private var scanWindow: UIView!//扫描窗口
    private var scanNetImageView: UIImageView!//扫描的模拟图
    
    private var isOpenFlash = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.blackColor()
        
        //这个属性必须打开否则返回的时候会出现黑边
        self.view.clipsToBounds = true;
        //1.遮罩
        setupMaskView()
        //2.下边栏
        setupBottomBar()
        //3.提示文本
        setupTipTitleView()
        //4.顶部导航
        setupNavView()
        //5.扫描区域
        setupScanWindowView()
        //6.开始动画
        beginScanning()
    }
    
    /*********相机扫描***********/
    
    let kBorderW = CGFloat(100)
    let kMargin = CGFloat(30)
    
    
    func setupMaskView() {
        
        maskVeiw = UIView()
        maskVeiw.layer.borderColor = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(0.7)).CGColor
        maskVeiw.layer.borderWidth = kMargin
        
        let maskViewSize = CGSizeMake(SCREENWIDTH + (kBorderW + kMargin) , SCREENWIDTH + (kBorderW + kMargin))
        maskVeiw.center = CGPointMake(SCREENWIDTH * 0.5, SCREENHEIGHT * 0.5);
        maskVeiw.frame = CGRectMake(0, 0, maskViewSize.width, maskViewSize.height)
        
        self.view.addSubview(maskVeiw)
        
    }
    
    func setupBottomBar() {
        
        ///1.下边栏
        let bottomBar = UIView(frame: CGRectMake(0, SCREENHEIGHT * 0.9, SCREENWIDTH, SCREENHEIGHT * 0.1))
        bottomBar.backgroundColor = UIColor(red:CGFloat(0), green:CGFloat(0), blue:CGFloat(0), alpha:CGFloat(0.8))
        self.view.addSubview(bottomBar)
        
        //2.我的二维码
        let myCodeBtn = UIButton(type: UIButtonType.System)
        myCodeBtn.frame = CGRectMake(0, 0, SCREENHEIGHT * 0.1 * 35 / 49, SCREENHEIGHT * 0.1)
        myCodeBtn.center=CGPointMake(SCREENWIDTH / 2, SCREENHEIGHT * 0.1 / 2);
        myCodeBtn.setImage(UIImage(named: "qrcode_scan_btn_myqrcode_down"), forState: UIControlState.Normal)
        
        myCodeBtn.contentMode = UIViewContentMode.ScaleAspectFit;
        myCodeBtn.addTarget(self, action: #selector(QRCodeScanViewController.myCodeBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        bottomBar.addSubview(myCodeBtn)
        
    }
    
    func myCodeBtnAction(btn: UIButton) {
        //
    }
    
    func setupTipTitleView() {
        //1.补充遮罩
        let mask = UIView(frame: CGRectMake(0, maskVeiw.frame.origin.y + maskVeiw.frame.height, SCREENWIDTH, kBorderW))
        mask.backgroundColor = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(0.7))
        self.view.addSubview(mask)
        
        //2.操作提示
        let tipLabel = UILabel(frame: CGRectMake(0, self.view.bounds.height * 0.9 - kBorderW * 2, self.view.bounds.width, kBorderW))
        tipLabel.text = "将取景框对准二维码，即可自动扫描"
        tipLabel.textColor = UIColor.whiteColor()
        tipLabel.textAlignment = NSTextAlignment.Center
        tipLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        tipLabel.numberOfLines = 2
        tipLabel.font=UIFont.systemFontOfSize(12)
        tipLabel.backgroundColor = UIColor.clearColor()
        self.view.addSubview(tipLabel)
   
    }
    
    func setupNavView() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.clearColor()
        self.title = "二维码/条形码"
        //设置标题颜色
        let navigationTitleAttribute = NSDictionary(object: UIColor.whiteColor(), forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
        //1.返回
        let backBtn = UIButton(type: UIButtonType.Custom)
        backBtn.frame = CGRectMake(20, 30, 25, 25);
        
        backBtn.setBackgroundImage(UIImage(named: "qrcode_scan_titlebar_back_nor"), forState:UIControlState.Normal);
        backBtn.contentMode = UIViewContentMode.ScaleAspectFit
        backBtn.addTarget(self, action: #selector(QRCodeScanViewController.backBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        let backItem = UIBarButtonItem(customView: backBtn)
        self.navigationItem.leftBarButtonItem = backItem
        
        let editItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(QRCodeScanViewController.editItemAction))
        self.navigationItem.rightBarButtonItem = editItem
        
//        //2.相册
//        let albumBtn = UIButton(type: UIButtonType.Custom)
//        albumBtn.frame = CGRectMake(0, 0, 35, 49)
//        albumBtn.center = CGPointMake(self.view.bounds.width / 2, 20 + 49 / 2.0)
//        albumBtn.setBackgroundImage(UIImage(named: "qrcode_scan_btn_photo_down"), forState: UIControlState.Normal)
//        albumBtn.contentMode=UIViewContentMode.ScaleAspectFit
//        albumBtn.addTarget(self, action: #selector(QRCodeScanViewController.openAlbum), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(albumBtn)
//        
//        //3.闪光灯
//        let flashBtn = UIButton(type: UIButtonType.Custom)
//        flashBtn.frame = CGRectMake(self.view.bounds.width - 55, 20, 35, 49)
//        flashBtn.setBackgroundImage(UIImage(named: "qrcode_scan_btn_flash_down"), forState: UIControlState.Normal)
//        flashBtn.contentMode=UIViewContentMode.ScaleAspectFit
//        flashBtn.addTarget(self, action: #selector(QRCodeScanViewController.openFlash(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(flashBtn)
        
        
    }
    
    func editItemAction() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let action1 = UIAlertAction(title: "从相册选取二维码", style: .Default) {
            [unowned self]
            (act) in
            self.openAlbum()
        }
        
        let action2 = UIAlertAction(title: "打开闪光灯", style: .Default) {
            [unowned self]
            (act) in
            self.openFlash()
        }
        
        let action3 = UIAlertAction(title: "输入条形码", style: .Default) { (act) in
            /////
        }
        
        let action4 = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(action4)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func backBtnAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func openFlash() {
        isOpenFlash = !isOpenFlash
        
        if (isOpenFlash) {
            turnTorchOn(true)
        }
        else{
            turnTorchOn(false)
        }
    }
    
//    class func swiftClassFromString(className: String) -> AnyClass! {
//        //method1
//        //方法 NSClassFromString 在Swift中已经不起作用了no effect，需要适当更改
//        if  var appName: String? = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String? {
//            // generate the full name of your class (take a look into your "appname-swift.h" file)
//            //            let classStringName = "_TtC\(appName!.utf16Count)\(appName!)\(count(className))\(className)"//xcode 6.1-6.2 beta
//            let classStringName = "_TtC\(count(appName!))\(appName!)\(count(className))\(className)"
//            var  cls: AnyClass? = NSClassFromString(classStringName)
//            //  method2
//            //cls = NSClassFromString("\(appName!).\(className)")
//            assert(cls != nil, "class not found,please check className")
//            return cls
//            
//        }
//        return nil;
//    }
    
    func turnTorchOn(isOn: Bool) {
//        let captureDeviceClass = QRCodeScanViewController.swiftClassFromString("AVCaptureDevice") as? AVCaptureDevice
//        if captureDeviceClass != nil {
            let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            
            if (device.hasTorch && device.hasFlash){
                
                do{
                    _ = try device.lockForConfiguration()
                    
                }catch let error as NSError {
                    //出错
                    print(error.localizedDescription)
                }catch {
                    print("--device位知错误--")
                }
                
                if isOn {
                    device.torchMode = AVCaptureTorchMode.On
                    device.flashMode = AVCaptureFlashMode.On
                    
                } else {
                    device.torchMode = AVCaptureTorchMode.Off
                    device.flashMode = AVCaptureFlashMode.Off
                }
                device.unlockForConfiguration()
            }
//        }
    }

    
    
    func setupScanWindowView() {
        
        let scanWindowH = self.view.bounds.width - kMargin * 2
        let scanWindowW = self.view.bounds.width - kMargin * 2
        
        scanWindow =  UIView(frame: CGRectMake(kMargin, kBorderW, scanWindowW, scanWindowH))
        scanWindow.clipsToBounds = true
        self.view.addSubview(scanWindow)
        
        scanNetImageView = UIImageView(image: UIImage(named: "scan_net"))
        
        let buttonWH = CGFloat(18)
        let topLift = UIImageView(frame: CGRectMake(0, 0, buttonWH, buttonWH))
        topLift.image = UIImage(named: "scan_1")
        let topRight = UIImageView(frame: CGRectMake(scanWindowW - buttonWH, 0, buttonWH, buttonWH))
        topRight.image = UIImage(named: "scan_2")
        let bottomLeft = UIImageView(frame: CGRectMake(0, scanWindowH - buttonWH, buttonWH, buttonWH))
        bottomLeft.image = UIImage(named: "scan_3")
        let bottomRight = UIImageView(frame: CGRectMake(topRight.frame.origin.x, bottomLeft.frame.origin.y, buttonWH, buttonWH))
        bottomRight.image = UIImage(named: "scan_4")
        
        scanWindow.addSubview(topLift)
        scanWindow.addSubview(topRight)
        scanWindow.addSubview(bottomLeft)
        scanWindow.addSubview(bottomRight)
    }
    
    func beginScanning() {
        //setupWork() ///要真机
    }
    
    func setupWork() {
        
        /*
         * AVCaptureDevice 获取摄像设备
         * AVCaptureDeviceInput 创建输入流
         * AVCaptureMetadataOutput 创建输出了
         */
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)//Swift 2 以上 中所有的同步 Cocoa API 的 NSError 都已经被 throw 关键字取代
        let input: AVCaptureDeviceInput
        do {
            
            input = try AVCaptureDeviceInput(device: device)
            
            ///add input
            session.addInput(input)
        }catch let error as NSError {
            // 发生了错误
            print(error.localizedDescription)
        }
        catch {
            print("--input未知错误--")
        }
        
        let output = AVCaptureMetadataOutput()
        ///add delegate
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())//主队列（主线程）
        
        ///设置有效扫描区域
        let scanRect = self.getScanRect(scanWindow.bounds, readerViewBounds: self.view.frame)
        output.rectOfInterest = scanRect
        
        ///初始化链接对象
        session = AVCaptureSession()
        ///高质量采集率
        session.sessionPreset = AVCaptureSessionPresetHigh
        
        ///add output
        session.addOutput(output)
        
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
        
        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.frame = self.view.bounds
        self.view.layer.insertSublayer(layer, atIndex: 0)
        
        ///start grab
        session.startRunning()
   
    }
    
    ///设置扫描区域矩形(获取扫描区域的比例关系)
    func getScanRect(rect: CGRect, readerViewBounds: CGRect) -> CGRect {
        let x = (CGRectGetHeight(readerViewBounds) - CGRectGetHeight(rect)) / 2 / CGRectGetHeight(readerViewBounds)
        let y = (CGRectGetWidth(readerViewBounds) - CGRectGetWidth(rect)) / 2 / CGRectGetWidth(readerViewBounds)
        let width = CGRectGetHeight(rect) / CGRectGetHeight(readerViewBounds);
        let height = CGRectGetWidth(rect) / CGRectGetWidth(readerViewBounds);
        
        return CGRectMake(x, y, width, height)
    }
    
    
    
    /***********照片读取**************/
    
    func openAlbum(){//相册
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)){
        
            ///1.初始化相册拾取器
            let pikController = UIImagePickerController()
            ///2.设置代理
            pikController.delegate = self//两个代理
            //3.设置资源：
            /**
            UIImagePickerControllerSourceTypePhotoLibrary,相册
            UIImagePickerControllerSourceTypeCamera,相机
            UIImagePickerControllerSourceTypeSavedPhotosAlbum,照片库
            */
            pikController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            //4.随便给他一个转场动画
            pikController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
            self.presentViewController(pikController, animated: true, completion: nil)
            
        }else{
            ///UIAlertView ios9 已废弃
            //let alert = UIAlertView(title: "提示", message: "设备不支持访问相册，请在设置->隐私->照片中进行设置！", delegate: nil, cancelButtonTitle: "确定")
            //alert.show()
            
            let alertVC = UIAlertController(title: "提示", message: "设备不支持访问相册，请在设置->隐私->照片中进行设置！", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertVC.addAction(action)
            
            self.presentViewController(alertVC, animated: true, completion: nil)
        
        }
        
    }
    
    ///imagePickerControllerdelegate func
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        ///1.获取选择的图片
        let image = info[UIImagePickerControllerOriginalImage]
        ///2.初始化一个监测器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [ CIDetectorAccuracy : CIDetectorAccuracyHigh ])
        picker.dismissViewControllerAnimated(true) { () -> Void in
            ///监测到的结果数组
            let features = detector.featuresInImage(CIImage(CGImage: (image?.CGImage)!))
            
            if features.count >= 1 {
                /**结果对象 */
                ///CIQRCodeFeature
                let feature = features[0] as! CIQRCodeFeature
                let scannedResult = feature.messageString
                
                let alertVC = UIAlertController(title: "提示", message: scannedResult, preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(alertVC, animated: true, completion: nil)

            }else {
                let alertVC = UIAlertController(title: "提示", message: "该图片没有包含一个二维码！", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                alertVC.addAction(action)
                
                self.presentViewController(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    /*
//////////////////////////////
    #pragma mark-> 二维码生成
    -(void)create{
    
    UIImage *image=[UIImage imageNamed:@"6824500_006_thumb.jpg"];
    NSString*tempStr;
    if(self.textField.text.length==0){
    
    tempStr=@"ddddddddd";
    
    }else{
    
    tempStr=self.textField.text;
    
    }
    UIImage*tempImage=[QRCodeGenerator qrImageForString:tempStr imageSize:360 Topimg:image withColor:RandomColor];
    
    _outImageView.image=tempImage;
    
    }
    +(UIImage*)qrImageForString:(NSString *)string imageSize:(CGFloat)size Topimg:(UIImage *)topimg withColor:(UIColor*)color{
    
    if (![string length]) {
    return nil;
    }
    
    QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_L, QR_MODE_8, 1);
    if (!code) {
    return nil;
    }
    
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
    
    // draw QR on this context
    [QRCodeGenerator drawQRCode:code context:ctx size:size withPointType:0 withPositionType:0 withColor:color];
    
    // get image
    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
    UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
    
    if(topimg)
    {
    UIGraphicsBeginImageContext(qrImage.size);
    
    //Draw image2
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    
    //Draw image1
    float r=qrImage.size.width*35/240;
    [topimg drawInRect:CGRectMake((qrImage.size.width-r)/2, (qrImage.size.height-r)/2 ,r, r)];
    
    qrImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    }
    
    // some releases
    CGContextRelease(ctx);
    CGImageRelease(qrCGImage);
    CGColorSpaceRelease(colorSpace);
    QRcode_free(code);
    
    return qrImage;
    
    }
    + (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size withPointType:(QRPointType)pointType withPositionType:(QRPositionType)positionType withColor:(UIColor *)color {
    unsigned char *data = 0;
    int width;
    data = code->data;
    width = code->width;
    float zoom = (double)size / (code->width + 2.0 * qr_margin);
    CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
    
    // draw
    const CGFloat *components;
    if (color) {
    components = CGColorGetComponents(color.CGColor);
    }else {
    components = CGColorGetComponents([UIColor blackColor].CGColor);
    }
    CGContextSetRGBFillColor(ctx, components[0], components[1], components[2], 1.0);
    NSLog(@"aad :%f  bbd :%f   ccd:%f",components[0],components[1],components[2]);
    
    for(int i = 0; i < width; ++i) {
    for(int j = 0; j < width; ++j) {
    if(*data & 1) {
				rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
    if (positionType == QRPositionNormal) {
    switch (pointType) {
    case QRPointRect:
    CGContextAddRect(ctx, rectDraw);
    break;
    case QRPointRound:
    CGContextAddEllipseInRect(ctx, rectDraw);
    break;
    default:
    break;
    }
    }else if(positionType == QRPositionRound) {
    switch (pointType) {
    case QRPointRect:
    CGContextAddRect(ctx, rectDraw);
    break;
    case QRPointRound:
    if ((i>=0 && i<=6 && j>=0 && j<=6) || (i>=0 && i<=6 && j>=width-7-1 && j<=width-1) || (i>=width-7-1 && i<=width-1 && j>=0 && j<=6)) {
    CGContextAddRect(ctx, rectDraw);
    }else {
    CGContextAddEllipseInRect(ctx, rectDraw);
    }
    break;
    default:
    break;
    }
    }
    }
    ++data;
    }
    }
    CGContextFillPath(ctx);
    }
    
    
    
    
    */
    /*
    #pragma mark-> 长按识别二维码
    -(void)dealLongPress:(UIGestureRecognizer*)gesture{
    
    if(gesture.state==UIGestureRecognizerStateBegan){
    
    _timer.fireDate=[NSDate distantFuture];
    
    UIImageView*tempImageView=(UIImageView*)gesture.view;
    if(tempImageView.image){
    //1. 初始化扫描仪，设置设别类型和识别质量
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    //2. 扫描获取的特征组
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:tempImageView.image.CGImage]];
    //3. 获取扫描结果
    CIQRCodeFeature *feature = [features objectAtIndex:0];
    NSString *scannedResult = feature.messageString;
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    }else {
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:@"您还没有生成二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    }
    
    
    }else if (gesture.state==UIGestureRecognizerStateEnded){
    
    
    _timer.fireDate=[NSDate distantPast];
    }
    
    
    }
*/
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
