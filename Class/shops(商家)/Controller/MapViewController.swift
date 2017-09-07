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
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
private func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
private func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class MapViewController: BaseViewController,MKMapViewDelegate, CLLocationManagerDelegate, AroundMerchantAnnotationViewDelegate {
    
    var kindId: Int64!
    var kindName: String!
    
    private var locationManager: CLLocationManager!
    private var coordinate: CLLocationCoordinate2D!

    private var mapView: MKMapView!
    private var locateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()///设置导航栏
        
        loadMapView()///加载地图视图
        locating()///地位
        
        createLocateBtn()///查看当前位置按钮

    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.isHidden = true
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 64))
        bgView.backgroundColor = UIColor.clear
        
        let backBtn = UIButton(frame: CGRect(x: 10, y: 30, width: 30, height: 30))
        backBtn.setImage(UIImage(named: "back@2x.png"), for: UIControlState())
        backBtn.setTitle(kindName, for: UIControlState())
        backBtn.contentMode = .scaleAspectFit
        backBtn.addTarget(self, action: #selector(HotelViewController.backBtnAction), for: UIControlEvents.touchUpInside)
        
        let titleLB = UILabel(frame: CGRect(x: 40, y: 30, width: 70, height: 30))
        titleLB.font = UIFont.systemFont(ofSize: 13)
        titleLB.backgroundColor = UIColor.black
        titleLB.layer.cornerRadius = 5
        titleLB.clipsToBounds = true
        titleLB.text = kindName
        titleLB.textColor = UIColor.white
        titleLB.textAlignment = .center
        titleLB.alpha = 0.5
        
        if titleLB.text != nil {
            let text = NSString(string: titleLB.text!)
            let textWidth = text.boundingRect(with: CGSize(width: SCREENWIDTH, height: 30), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 13)], context: nil).width ///根据文子获取宽度
            titleLB.frame = CGRect(x: 40, y: 30, width: textWidth + 20 , height: 30)///加两边的间距
        }else {
            titleLB.frame = CGRect(x: 30, y: 30, width: 0, height: 30)
        }
        
        bgView.addSubview(titleLB)
        bgView.addSubview(backBtn)
        self.view.addSubview(bgView)
    }
    
    func backBtnAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func createLocateBtn() {
        locateBtn = UIButton(type: .custom)
        locateBtn.frame = CGRect(x: 10, y: self.view.extHeight() - 50, width: 30, height: 30)
        //locateBtn.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin
        locateBtn.backgroundColor = UIColor.white
        locateBtn.layer.cornerRadius = 5
        locateBtn.setImage(UIImage(named: "location_no"), for: UIControlState())
        locateBtn.addTarget(self, action: #selector(MapViewController.locateAction), for: .touchUpInside)
        
        self.view.addSubview(locateBtn)
    }
    
    func locateAction() {
        
        /*
         
         MKUserTrackingModeNone = 0, 不追踪，不准确
         MKUserTrackingModeFollow, 追踪并显示当前位置
         MKUserTrackingModeFollowWithHeading,  追踪并且获取用户方向
         
         */
        
        if mapView.userTrackingMode != MKUserTrackingMode.follow {///追踪模式
            mapView.setUserTrackingMode(.follow, animated: true) ///追踪并显示当前位置
        }
        
        searchNearby()///搜索附近
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
        
        mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true ///显示当前所在位置
        mapView.mapType = MKMapType.standard /// 地图类型， 卫星，标准， 混合
        mapView.delegate = self
        
        self.view.insertSubview(mapView, at: 0)
    }
    
    ///定位
    func locating() {
        locationManager = CLLocationManager()
        
        ///ios8+以上要授权，并且在plist文件中添加NSLocationWhenInUseUsageDescription，
        ///NSLocationAlwaysUsageDescription，值可以为空
        let index = IOS_VERSION.characters.index(IOS_VERSION.startIndex, offsetBy: 3)///9.3.1 to 9.3
        if (Double(IOS_VERSION.substring(to: index)) > 8.0) {
            locationManager.requestWhenInUseAuthorization()//请求授权
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest//精度(使用电池供电时的最高精度)
        locationManager.delegate = self
        locationManager.startUpdatingLocation()//开始定位
        
    }
    
    ///CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last//CLLocation ///获得经纬度
        
      
        ///获得数据
        coordinate = location?.coordinate//CLLocationCoordinate2D
        
        manager.stopUpdatingLocation()//停止定位
        
        loadAroundMerchantData()///先定位在加载数据
        
//        let center = coordinate
        let center = CLLocationCoordinate2DMake(LATITUDE_DEFAULT, LONGITUDE_DEFAULT)///test
        
        //MKCoordinateSpan
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        //MKCoordinateRegion
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
 
        
//        ///地理信息编码
//        ///CLGeocoder
//        let geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(location!) {///逆向地理编码 ///通过经纬度获取地址信息，给annotation设置标题，本app自定义annotation，用不到
//            [unowned self]
//            (placemarks: [CLPlacemark]?, error: NSError?) in
//            if error != nil {
//                print(error?.localizedDescription)
//            }else {
//                if placemarks?.count > 0 {
//                    let placemark = placemarks?.first
//                    let newLocation = placemark?.location
//                    self.coordinate = newLocation?.coordinate
//                    
//                    manager.stopUpdatingLocation()//停止定位
//                    
//                    self.loadAroundMerchantData()///先定位在加载数据
//                    
//                    //        let center = coordinate
//                    
//                    let center = CLLocationCoordinate2DMake(LATITUDE_DEFAULT, LONGITUDE_DEFAULT)///test
//                    
//                    //MKCoordinateSpan
//                    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//                    //MKCoordinateRegion
//                    let region = MKCoordinateRegion(center: center, span: span)
//                    self.mapView.setRegion(region, animated: true)
//
//                    //然后创建annotation对象，设置标题，mapview添加annotation
//                }
//            }
//        }
        
    }
    
    ///地位失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失败", error.localizedDescription)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { ///当前位置
            return nil
        }
        
        //MKPinAnnotationView （系统大头针）
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
        
        ///自定义
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "MerchantView") as? AroundMerchantAnnotationView
        if annotationView == nil {
            annotationView = AroundMerchantAnnotationView(annotation: annotation, reuseIdentifier: "MerchantView")
        }
        
        annotationView!.mMerchantAnnotation = annotation as! MerchantAnnotation
        annotationView?.delegate = self///设置代理
        
        return annotationView
        
    }
    
    ///选择某个图标
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.isSelected = true
        view.setNeedsLayout()
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.isSelected = false
        view.setNeedsLayout()
    }
    
    
    ///周边信息
    func searchNearby() {
        let center = coordinate///当前位置
        let region = MKCoordinateRegionMakeWithDistance(center!, 2000, 2000)///周围1000米的范围
        
        let adjustRegion = mapView.regionThatFits(region)///显示该区域
        
        let requst = MKLocalSearchRequest()
        requst.region = adjustRegion
        requst.naturalLanguageQuery = "place";//想要的信息
        let localSearch = MKLocalSearch(request: requst)
        
        localSearch.start {
            //[unowned self]
            (response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else {
                
                //response?.mapItems///包含所需信息
                
                //self.findRoute(fromUserLocation: (response?.mapItems.first)!, toDestination: (response?.mapItems.last)!)
            }
        }
        
    }
    
    ///改变模式
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        if mode == MKUserTrackingMode.none {
            locateBtn.setImage(UIImage(named: "location_no"), for: UIControlState())
        }else {
            locateBtn.setImage(UIImage(named: "location_yes"), for: UIControlState())
        }
    }
    
    ///查找路线的代理 ///AroundMerchantAnnotationViewDelegate
    func startFindRoute(withDestination to: CLLocationCoordinate2D) {
        ///MKPlacemark
        let fromPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        
        //let fromPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(LATITUDE_DEFAULT, LONGITUDE_DEFAULT), addressDictionary: nil)///test
        
        let toPlacemark = MKPlacemark(coordinate: to, addressDictionary: nil)
        
        ///MKMapItem
        let fromItem = MKMapItem(placemark: fromPlacemark)
        let toItem = MKMapItem(placemark: toPlacemark)
        
        self.mapView.removeOverlays(self.mapView.overlays)///先清除之前的所有路线在添加新的路线
        
        self.findRoute(fromUserLocation: fromItem, toDestination: toItem)
    }
    
    
    ///绘制导航路线///
    func findRoute(fromUserLocation from: MKMapItem, toDestination to: MKMapItem) {
        ///MKDirectionsRequest
        let request = MKDirectionsRequest()
        request.source = from
        request.destination = to
        request.transportType = MKDirectionsTransportType.automobile ///交通类型
        
        let index = IOS_VERSION.characters.index(IOS_VERSION.startIndex, offsetBy: 3)///9.3.1 to 9.3
        if (Double(IOS_VERSION.substring(to: index)) > 7.0) { ///7.0以上
            request.requestsAlternateRoutes = true ///可以绘制路线
        }
    
        ///MKDirections
        let directions = MKDirections(request: request)
        
        directions.calculate {
            [unowned self]///捕获列表
            (response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else {
                ///MKRoute
                let route = response?.routes[0]///多条路线
                
                /*
                 public class MKRoute : NSObject {
                 
                 ///路线的描述
                 public var name: String { get }
                 
                 ///通告
                 public var advisoryNotices: [String] { get }
                 
                 ///距离
                 public var distance: CLLocationDistance { get }
                 
                 ///估计用时
                 public var expectedTravelTime: NSTimeInterval { get }
                 
                 ///交通类型
                 public var transportType: MKDirectionsTransportType { get }
                 
                 ///路线
                 public var polyline: MKPolyline { get }
                 
                 ///过程
                 public var steps: [MKRouteStep] { get }
                 
                 }
                 */
                self.mapView.add((route?.polyline)!)///地图上显示路线
            }

        }
    }
    ///路线样式设置
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        ///路径的渲染对象
        let renderer = MKPolylineRenderer(overlay: overlay)///MKPolylineRenderer 注意是这个类，要不可能显示不出线路，Polyline地图上的多段线
        renderer.lineCap = .round
        renderer.lineWidth = 4.0
        renderer.strokeColor = THEMECOLOR
        
        return renderer
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
