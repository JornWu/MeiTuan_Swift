//
//  AppDelegate.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate{

    var window: UIWindow?
    
    ///默认位置
    var latitude = LATITUDE_DEFAULT //纬度
    var longitude = LONGITUDE_DEFAULT //经度
    
    ///定位manager
    var locationManager: CLLocationManager!//用于获取位置    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        if self.window != nil {
            self.window!.rootViewController = RootTabBarController()
            self.window!.makeKeyAndVisible()
        }else {
            self.window = UIWindow(frame: CGRectMake(CGFloat(0), CGFloat(0), SCREENWIDTH, SCREENHEIGHT))
            self.window!.rootViewController = RootTabBarController()
            self.window!.makeKeyAndVisible()
            
        }
        
        ///定位
       locating()
        
        return true
    }
    
    func locating() {
        locationManager = CLLocationManager()
        
        ///ios8+以上要授权，并且在plist文件中添加NSLocationWhenInUseUsageDescription，
        ///NSLocationAlwaysUsageDescription，值可以为空
        if (Double(IOS_VERSION) > 8.0) {
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
        latitude = (coordinate?.latitude)!
        longitude = (coordinate?.longitude)!
        
    }

    
    
    
    
    

    
    
    
    
    
/****************************************************************************************************/

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

