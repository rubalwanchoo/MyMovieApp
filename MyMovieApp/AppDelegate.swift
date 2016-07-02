//
//  AppDelegate.swift
//  MyMovieApp
//
//  Created by Rubal Wanchoo on 6/29/16.
//  Copyright © 2016 wanchoo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //MARK: Custom declarations
    let mySession = NSURLSession.sharedSession()
    var requestToken:String? = nil
    var sessionId:String? = nil
    var userId:Int? = nil


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

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

extension AppDelegate{
    
    func getTMDBURLWithExtension(additionalPath:String, additionalParams:[String:AnyObject])-> NSURL{
        
        
        let components = NSURLComponents()
        
        components.scheme = Constants.TMDB.ApiScheme
        components.host = Constants.TMDB.ApiHost
        components.path = Constants.TMDB.ApiPath + additionalPath
        components.queryItems=[NSURLQueryItem]()
        
        components.queryItems?.append(NSURLQueryItem(name: Constants.TMDBParameterKeys.ApiKey, value: Constants.TMDBParameterValues.ApiKey))
        
        
        for item in additionalParams{
            components.queryItems?.append(NSURLQueryItem(name:item.0, value:item.1 as? String))
        }
        
        return components.URL!
        
        
    }
}











