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
import AVFoundation ///用到摄像头
import CoreImage ///生成二维码


class QRCodeScanViewController: UIViewController,
                                AVCaptureMetadataOutputObjectsDelegate,
                                UINavigationControllerDelegate,
                                UIImagePickerControllerDelegate,
                                UITextFieldDelegate{
    
    fileprivate var session: AVCaptureSession!// 输入输出的中间链接
    fileprivate var maskView: UIView!//蒙版
    fileprivate var scanWindow: UIView!//扫描窗口
    fileprivate var scanNetImageView: UIImageView!//扫描的模拟图
    
    fileprivate var isOpenFlash = false
    
    fileprivate var textInfo: String?///要生成二维码的信息
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black
        
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
        //6.开始扫描
        //beginScanning()
        
    }
    
    /*********相机扫描***********/
    
    let kMargin = CGFloat(50)
    
    
    func setupMaskView() {
        
        maskView = UIView()
        maskView.layer.borderColor = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(0.7)).cgColor
        maskView.layer.borderWidth = kMargin
        
        let maskViewSize = CGSize(width: self.view.extWidth(), height: self.view.extWidth())///正方形，下面会露出来，还要添加补充遮罩
        maskView.frame = CGRect(x: 0, y: 64, width: maskViewSize.width, height: maskViewSize.height)
        self.view.addSubview(maskView)
        
        ///补充遮罩
        let mask = UIView(frame: CGRect(x: 0, y: maskView.extY() + maskView.extHeight(), width: SCREENWIDTH, height: SCREENHEIGHT - (maskView.extY() + maskView.extHeight())))
        mask.backgroundColor = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(0.7))
        self.view.addSubview(mask)
        
    }
    
    func setupTipTitleView() {
        
        ///操作提示
        let tipLabel = UILabel(frame: CGRect(x: 0, y: maskView.frame.maxY + 30, width: self.view.extWidth(), height: 100))
        tipLabel.text = "将取景框对准二维码，即可自动扫描"
        tipLabel.textColor = UIColor.white
        tipLabel.textAlignment = NSTextAlignment.center
        tipLabel.lineBreakMode = NSLineBreakMode.byCharWrapping
        tipLabel.numberOfLines = 0
        tipLabel.font=UIFont.systemFont(ofSize: 12)
        tipLabel.backgroundColor = UIColor.clear
        self.view.addSubview(tipLabel)
        
    }
    
    func setupBottomBar() {
        
        ///1.下边栏
        let bottomBar = UIView(frame: CGRect(x: 0, y: SCREENHEIGHT * 0.9, width: SCREENWIDTH, height: SCREENHEIGHT * 0.1))
        bottomBar.backgroundColor = UIColor(red:CGFloat(0), green:CGFloat(0), blue:CGFloat(0), alpha:CGFloat(0.8))
        self.view.addSubview(bottomBar)
        
        //2.我的二维码
        let myCodeBtn = UIButton(type: UIButtonType.system)
        myCodeBtn.frame = CGRect(x: 0, y: 0, width: SCREENHEIGHT * 0.1 * (35 / 49), height: SCREENHEIGHT * 0.1)
        myCodeBtn.center=CGPoint(x: SCREENWIDTH / 2, y: SCREENHEIGHT * 0.1 / 2);
        myCodeBtn.setImage(UIImage(named: "qrcode_scan_btn_myqrcode_down"), for: UIControlState())
        
        myCodeBtn.contentMode = UIViewContentMode.scaleAspectFit;
        myCodeBtn.addTarget(self, action: #selector(QRCodeScanViewController.myCodeBtnAction(_:)), for: UIControlEvents.touchUpInside)
        
        bottomBar.addSubview(myCodeBtn)
        
    }
    
    func myCodeBtnAction(_ btn: UIButton) {
        ///doing 
        ///打开图片
        
    }
    
    
    
    func setupNavView() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.title = "二维码/条形码"
        //设置标题颜色
        let navigationTitleAttribute = NSDictionary(object: UIColor.white, forKey: NSForegroundColorAttributeName as NSCopying)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
        //1.返回
        let backBtn = UIButton(type: UIButtonType.custom)
        backBtn.frame = CGRect(x: 20, y: 30, width: 25, height: 25);
        
        backBtn.setBackgroundImage(UIImage(named: "qrcode_scan_titlebar_back_nor"), for:UIControlState());
        backBtn.contentMode = UIViewContentMode.scaleAspectFit
        backBtn.addTarget(self, action: #selector(QRCodeScanViewController.backBtnAction), for: UIControlEvents.touchUpInside)
        
        let backItem = UIBarButtonItem(customView: backBtn)
        self.navigationItem.leftBarButtonItem = backItem
        
        let editItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(QRCodeScanViewController.editItemAction))
        self.navigationItem.rightBarButtonItem = editItem
        
        
        
        //  deprecated  //
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
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "从相册选取二维码", style: .default) {
            [unowned self]
            (act) in
            self.openAlbum()
        }
        
        let action2 = UIAlertAction(title: "打开闪光灯", style: .default) {
            [unowned self]
            (act) in
            self.openFlash()
        }
        
        let action3 = UIAlertAction(title: "生成二维码", style: .default) {
            [unowned self]
            (act) in
            
            let inputVC = UIAlertController(title: "输入信息", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okayAction = UIAlertAction(title: "确定", style: .default){
                [unowned self]
                (act) in
                ///生成二维码图片
                let QRCodeImage = self.createQRCodeImage(withImage: UIImage(named: "icon_mine_default_portrait")!, string: self.textInfo!)
                
                ///展示在界面上
                let imageBtn = UIButton(frame: CGRect(x: 0, y: 64, width: SCREENWIDTH, height: SCREENHEIGHT - 64))
                imageBtn.setImage(QRCodeImage, for: UIControlState())
                imageBtn.addTarget(self, action: #selector(self.imageBtnAction(_:)), for: .touchUpInside)
                imageBtn.backgroundColor = THEMECOLOR
                self.view.addSubview(imageBtn)
                
                ///保存到相册
                //UIImageWriteToSavedPhotosAlbum(QRCodeImage, self, #selector(self.image(_: didFinishSavingWithError: contextInfo: )), nil)
                
                inputVC.dismiss(animated: true, completion: { 
                    print("生成二维码")
                })
            }
            
            inputVC.addAction(cancelAction)
            inputVC.addAction(okayAction)
            
            inputVC.addTextField(configurationHandler: { (textField) in
                textField.borderStyle = .none
                textField.placeholder = "输入需要保存的信息"
                textField.delegate = self
                textField.becomeFirstResponder()
            })
            
            self.present(inputVC, animated: true, completion: {
                print("输入信息可以生成二维码")
            })
        }
        
        let action4 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(action4)
        
        self.present(actionSheet, animated: true, completion: nil)
    }

    ///UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textInfo = textField.text
    }
    
    ///QRCode imge hide
    func imageBtnAction(_ btn: UIButton) {
        btn.isHidden = true ///释放
    }
    
    ///save image to album error
    //- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
    func  image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject?){
        guard error != nil else {
            print("保存图片到相册失败！")
            return
        }
        print("保存图片到相册成功！")
    }
    
    func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
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
    
    func turnTorchOn(_ isOn: Bool) {
        
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            
        if ((device?.hasTorch)! && (device?.hasFlash)!){
            
            do{
                _ = try device?.lockForConfiguration()
                
            }catch let error as NSError {
                //出错
                print(error.localizedDescription)
            }catch {
                print("--device位知错误--")
            }
            
            if isOn {
                device?.torchMode = AVCaptureTorchMode.on
                device?.flashMode = AVCaptureFlashMode.on
                
            } else {
                device?.torchMode = AVCaptureTorchMode.off
                device?.flashMode = AVCaptureFlashMode.off
            }
            device?.unlockForConfiguration()
        }
    }
    
    func setupScanWindowView() {
        
        let scanWindowH = maskView.extWidth() - kMargin * 2 ///kMargin为黑色边框的一半，
        let scanWindowW = scanWindowH
        
        scanWindow =  UIView(frame: CGRect(x: kMargin, y: kMargin + 64, width: scanWindowW, height: scanWindowH))///隐形的框
        scanWindow.clipsToBounds = true
        self.view.addSubview(scanWindow)
        
        scanNetImageView = UIImageView(image: UIImage(named: "scan_net"))
        scanNetImageView.extSetY(-1 * scanNetImageView.extHeight())
        scanWindow.addSubview(scanNetImageView)
        
        let buttonWH = CGFloat(18)
        let topLift = UIImageView(frame: CGRect(x: 0, y: 0, width: buttonWH, height: buttonWH))
        topLift.image = UIImage(named: "scan_1")
        let topRight = UIImageView(frame: CGRect(x: scanWindowW - buttonWH, y: 0, width: buttonWH, height: buttonWH))
        topRight.image = UIImage(named: "scan_2")
        let bottomLeft = UIImageView(frame: CGRect(x: 0, y: scanWindowH - buttonWH, width: buttonWH, height: buttonWH))
        bottomLeft.image = UIImage(named: "scan_3")
        let bottomRight = UIImageView(frame: CGRect(x: topRight.frame.origin.x, y: bottomLeft.frame.origin.y, width: buttonWH, height: buttonWH))
        bottomRight.image = UIImage(named: "scan_4")
        
        scanWindow.addSubview(topLift)
        scanWindow.addSubview(topRight)
        scanWindow.addSubview(bottomLeft)
        scanWindow.addSubview(bottomRight)
        
        self.view.addSubview(scanWindow)
    }
    
    func beginScanning() {///要真机///注意plist文件添加属性授权访问摄像头，
        ///模拟图片动起来
        ///way 1、UIView Animation
        UIView.animate(withDuration: 1.5, delay: 0, options: UIViewAnimationOptions.repeat, animations: {
            [unowned self] in
            self.scanNetImageView.transform = self.scanNetImageView.transform.translatedBy(x: 0, y: self.scanWindow.extHeight())
            }, completion: nil)
        
        ///way 2、coreAnimation
        
        
        //初始化链接对象
        session = AVCaptureSession()
        //高质量采集率
        session.sessionPreset = AVCaptureSessionPresetHigh
        
        let preLayer = AVCaptureVideoPreviewLayer(session: session)///注意session存放的地方
        preLayer?.frame = self.view.bounds
        self.view.layer.insertSublayer(preLayer!, at: 0)
        
        /*
         * AVCaptureDevice 获取摄像设备
         * AVCaptureDeviceInput 创建输入流
         * AVCaptureMetadataOutput 创建输出了
         */
        
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        var input: AVCaptureDeviceInput?
        do {
            
            input = try AVCaptureDeviceInput(device: device)
            ///add input
            
        }catch let error as NSError {
            // 发生了错误
            print(error.localizedDescription)
        }
        catch {
            print("--input未知错误--")
        }
        ///add input
        session.addInput(input)
        
        let output = AVCaptureMetadataOutput()
        ///add delegate
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)//主队列（主线程）
        
        ///设置“感兴趣”区域（敏感区域）
        let interestRect = preLayer?.metadataOutputRectOfInterest(for: scanWindow.frame)///扫描区 到 metadata输出区
        ///值等于CGRectMake(scanWindow.extY() / SCREENHEIGHT, scanWindow.extX() / SCREENWIDTH, scanWindow.extHeight() / SCREENHEIGHT, scanWindow.extWidth() / SCREENWIDTH)
        ///把一个在 preview layer 坐标系中的rect 转换成一个在 metadata output 坐标系中的rect
        
        output.rectOfInterest = interestRect! ///注意，这个并不是扫描区的坐标尺寸
        
        session.addOutput(output)
        
        //设置扫码支持的类型
        output.metadataObjectTypes = [AVMetadataObjectTypeDataMatrixCode,
                                      AVMetadataObjectTypeAztecCode,
                                      AVMetadataObjectTypeQRCode,
                                      AVMetadataObjectTypePDF417Code, 
                                      AVMetadataObjectTypeEAN13Code,
                                      AVMetadataObjectTypeEAN8Code,
                                      AVMetadataObjectTypeCode128Code]
        
        ///常用的码制有：PDF417二维条码、Datamatrix二维条码、QR Code、Code 49、Code 16K、Code one等，
        ///除了这些常见的二维条码之外，还有Vericode条码、Maxicode条码、CP条码、Codablock F条码、 Ultracode条码及Aztec条码。
        
        
        
        ///start grab
        session.startRunning()
   
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects.count > 0 {
            session.stopRunning()
            
            let metadataObject = metadataObjects.last! as! AVMetadataMachineReadableCodeObject
            print(metadataObject.stringValue)
            
            ///退出
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    /***********照片读取**************/
    
    func openAlbum(){//相册
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)){
        
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
            pikController.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
            //4.随便给他一个转场动画
            pikController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
            self.present(pikController, animated: true, completion: nil)
            
        }else{
            
            let alertVC = UIAlertController(title: "提示", message: "设备不支持访问相册，请在设置->隐私->照片中进行设置！", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertVC.addAction(action)
            
            self.present(alertVC, animated: true, completion: nil)
        
        }
        
    }
    
    ///imagePickerControllerdelegate func
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        ///1.获取选择的图片
        let image = info[UIImagePickerControllerOriginalImage]
        ///2.初始化一个监测器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [ CIDetectorAccuracy : CIDetectorAccuracyHigh ])
        picker.dismiss(animated: true) { () -> Void in
            ///监测到的结果数组
            let features = detector?.features(in: CIImage(cgImage: ((image as AnyObject).cgImage)!!))
            
            if (features?.count)! >= 1 {
                /**结果对象 */
                ///CIQRCodeFeature
                let feature = features?[0] as! CIQRCodeFeature
                let scannedResult = feature.messageString
                
                let alertVC = UIAlertController(title: "提示", message: scannedResult, preferredStyle: UIAlertControllerStyle.alert)
                self.present(alertVC, animated: true, completion: nil)

            }else {
                let alertVC = UIAlertController(title: "提示", message: "该图片没有包含一个二维码！", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(action)
                
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    
    
    /***********生成二维码图片**************/ ///coreImage
    
    func createQRCodeImage(withImage image: UIImage, string: String) -> UIImage {
        
        /// 1. 实例化二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")///CICode128BarcodeGenerator ///条形码
        ///注意
        
        /// 2. 恢复滤镜的默认属性
        filter?.setDefaults()
        
        /// 3. 将字符串转换成二进制数据，（生成二维码所需的数据）
        let data = string.data(using: String.Encoding.utf8)
        
        /// 4. 通过KVO把二进制数据添加到滤镜inputMessage中
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        
        /// 5. 获得滤镜输出的图像
        let outputImage = filter?.outputImage ///CIImage
        
        /// 6. 将CIImage转换成UIImage，并放大显示
        //let originQRCodeImage = UIImage(CIImage: outputImage!, scale: 0.07, orientation: UIImageOrientation.Up) ///原生二维码图片 ///这样将图片放大会变得模糊
        //return originQRCodeImage
        
        ///进行重绘
        let newQRCodeImage = createUIimageWithCGImage(ciImage: outputImage!, widthAndHeightValue: 300)
        
        return newQRCodeImage
    }
    
    func createUIimageWithCGImage(ciImage image: CIImage, widthAndHeightValue wh: CGFloat) -> UIImage {
        let ciRect = image.extent.integral///根据容器得到适合的尺寸
        let scale = min(wh / ciRect.width, wh / ciRect.height)
        
        ///获取bitmap
        
        let width  = size_t(ciRect.width * scale)
        let height  = size_t(ciRect.height * scale)
        let cs = CGColorSpaceCreateDeviceGray()///灰度颜色通道 ///CGColorSpaceRef
        
        let info_UInt32 = CGImageAlphaInfo.none.rawValue
        let bitmapRef = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: info_UInt32)
        
        let contex = CIContext(options: nil)
        let bitmapImageRef = contex.createCGImage(image, from: CGRect(x: ciRect.origin.x, y: ciRect.origin.y, width: ciRect.size.width, height: ciRect.size.height)) ///CGImageRef
        
        bitmapRef!.interpolationQuality = CGInterpolationQuality.high///写入质量高，时间长
        bitmapRef?.scaleBy(x: scale, y: scale) ///调整“画布”的缩放
        bitmapRef?.draw(bitmapImageRef!, in: ciRect) ///绘制图片
        
        ///保存
        let scaledImage = bitmapRef?.makeImage()
        
        ///bitmapRef和bitmapImageRef不用主动释放，Core Foundation自动管理
        
        //let originImage = UIImage(CGImage: scaledImage!) ///原生灰度图片（灰色）
        
        let ciImage = CIImage(cgImage: scaledImage!)
        
        ///添加滤镜
        let colorFilter = CIFilter(name: "CIFalseColor")///颜色滤镜
        colorFilter!.setDefaults()
        colorFilter!.setValue(ciImage, forKey:kCIInputImageKey)
        
        colorFilter!.setValue(CIColor(red: 33.0 / 225.0, green: 192.0 / 225.0, blue: 174.0 / 225.0, alpha: 1.0), forKey:"inputColor0")///二维码元素（像素）
        colorFilter!.setValue(CIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1), forKey:"inputColor1")///背景
        
        let colorImgae = colorFilter!.outputImage
        let newQRCodeImage = UIImage(ciImage: colorImgae!)
        
        return newQRCodeImage
        
    }
    
    /***********长按识别二维码**************/
    ///更从相册中的读取的二维码类似，这里不测试了，学习者可以在需要的地方调用该方法
    func recognizeQRCode(withLongPress lpGesture: UIGestureRecognizer) {
        
        if lpGesture.state == .began {
            
            let tpImageView = lpGesture.view as! UIImageView
            if tpImageView.image != nil {
                ///1 初始化扫描仪，设置设备类型和识别质量 ///CIDetector
                let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
                
                ///2、扫描获取的特征组
                let features = detector?.features(in: CIImage(cgImage: (tpImageView.image?.cgImage)!))
                
                ///3、获取扫描结果 ///CIQRCodeFeature
                let  feature = features?.first as! CIQRCodeFeature
                let scannedResult = feature.messageString
                
                print("扫描结果是：", scannedResult as Any)
                
                let ac = UIAlertController(title: "扫描结果", message: scannedResult, preferredStyle: .alert)
                self.navigationController?.pushViewController(ac, animated: true)
            }else {
                let ac = UIAlertController(title: "错误提示", message: "没法识别图片", preferredStyle: .alert)
                self.navigationController?.pushViewController(ac, animated: true)
            }
        }
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
