//
//  AppDelegate.swift
//  ToDoListAppCoreData
//
//  Created by DeEp KapaDia on 12/07/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        do{
            _ = try Realm()

        }catch{
            print("Error \(error)")
        }
        return true
    }



}

