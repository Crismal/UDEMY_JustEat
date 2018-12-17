//
//  AppDelegate.swift
//  UdemyJustEat
//
//  Created by Cristian Misael Almendro Lazarte on 12/11/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //Metodo llamado automaticamente al seleccionar un SiriShorcut
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        if userActivity.activityType == "com.CristianAlmendro.UdemyJustEat.order" {
            guard let navController = window?.rootViewController as? UINavigationController else {
                fatalError("Se suponia que la app debia arrancar con un Navigation Controller");
            }
            guard let orderVC = navController.storyboard?.instantiateViewController(withIdentifier: "OrderVC") as? OrderViewController else {
                fatalError("No podermos cargar el View controler para hacer el pedido");
            }
            
            if let order = Order(from: userActivity.userInfo?["order"] as? Data) {
                orderVC.cupcake = order.cupcake;
                orderVC.toppings = order.toppings;
                
                navController.pushViewController(orderVC, animated: true);
            }
            
            
        }
        
        return true;
    }

}

