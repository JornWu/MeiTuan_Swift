//
//  BMapViewController.swift
//  MeiTuan_Swift
//
//  Created by Jorn Wu on 16/9/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/****************************************************************************************************/
/*
 **
 ** 这是地图页面
 **
 */
/****************************************************************************************************/

import UIKit
import MapKit

class MapViewController: BaseViewController,MKMapViewDelegate, CLLocationManagerDelegate {
    
    var kindId: Int64!
    var kindName: String!
    
    private var locationManager: CLLocationManager!
    private var latitude: Double! ///=CLLocationDegrees
    private var longitude: Double!

    private var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        
        loadMapView()
        locating()
        
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.hidden = true
        let barView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH, 64))
        barView.backgroundColor = UIColor.clearColor()
        
        let backBtn = UIButton(frame: CGRectMake(0, 30, 70, 30))
        backBtn.setImage(UIImage(named: "back@2x.png"), forState: UIControlState.Normal)
        backBtn.setTitle(kindName, forState: UIControlState.Normal)
        backBtn.contentMode = .ScaleAspectFit
        backBtn.addTarget(self, action: #selector(HotelViewController.backBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        barView.addSubview(backBtn)
        self.view.addSubview(barView)
    }
    
    func backBtnAction() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    ///获取附近商家数据
    func loadAroundMerchantData() {
        
        ///默认类型为全部，数量20
        let URLString = UrlStrType.xxxxxxx()
//        let URLString = UrlStrType.urlStringWithAroundMerchantData(withwithPosition: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),type: kindId, offset: 20)
        ///封装的方法
        NetworkeProcessor.loadNetworkeDate(withTarget: self, URLString: URLString) {
            [unowned self]
            (dictionary) in
            
            self.aroundMerchantModel(withDictionary: dictionary)
        }
    }
    
    func aroundMerchantModel(withDictionary dictionary: NSDictionary) {
        let aroundMerchantModel = AM_AroundMerchantModel(fromDictionary: dictionary)///数据类型是一样的
        //for index in aroundMerchantModel.data {
            let mIndex = aroundMerchantModel.data.last
                for tempModel in mIndex!.rdplocs {
                    
                    let merchantAnnotation = MerchantAnnotation(withModel: tempModel)
                    mapView.addAnnotation(merchantAnnotation)
                    
                }
       // }
    }
    

    func loadMapView() {
        
        mapView = MKMapView(frame: UIScreen.mainScreen().bounds)
        mapView.showsUserLocation = true ///
        mapView.mapType = MKMapType.Standard /// 地图类型， 卫星，标准， 混合
        mapView.delegate = self
        
        self.view.insertSubview(mapView, atIndex: 0)
    }
    
    func locating() {
        locationManager = CLLocationManager()
        
        ///ios8+以上要授权，并且在plist文件中添加NSLocationWhenInUseUsageDescription，
        ///NSLocationAlwaysUsageDescription，值可以为空
        let index = IOS_VERSION.startIndex.advancedBy(3)///9.3.1 to 9.3
        if (Double(IOS_VERSION.substringToIndex(index)) > 8.0) {
            locationManager.requestWhenInUseAuthorization()//请求授权
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest//精度(使用电池供电时的最高精度)
        locationManager.delegate = self
        locationManager.startUpdatingLocation()//开始定位
        
    }
    
    ///CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last//CLLocation
        let coordinate = location?.coordinate;//CLLocationCoordinate2D
        manager.stopUpdatingLocation()//停止定位
        
        ///获得数据
        latitude = (coordinate?.latitude)!
        longitude = (coordinate?.longitude)!
        
        loadAroundMerchantData()///先定位在加载数据
        
        let center = coordinate
        //MKCoordinateSpan
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        //MKCoordinateRegion
        let region = MKCoordinateRegion(center: center!, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { ///当前位置
            return nil
        }
        
        //MKPinAnnotationView
//        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("PinView") as? MKPinAnnotationView
//        
//        if pinView == nil {
//            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PinView")
//            pinView!.pinTintColor = UIColor.redColor()
//            pinView!.animatesDrop = true ///动画
//            pinView!.canShowCallout = true ///显示标题
//            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)///辅助视图
//        }
//        
//        return pinView
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("MerchantView") as? AroundMerchantAnnotationView
        if annotationView == nil {
            annotationView = AroundMerchantAnnotationView(annotation: annotation, reuseIdentifier: "MerchantView")
        }
        
        annotationView!.mMerchantAnnotation = annotation as! MerchantAnnotation
        
        return annotationView
        
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        ///
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
