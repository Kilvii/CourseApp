//
//  AppDelegate.swift
//  CourseApp
//
//  Created by User on 03.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    enum StorageKey: String {
        case startDate
        case profile
        case city
        case existProfile
        case firstLaunch
        case lastLaunch
    }
    
    private let assembly = Assembly()
    
    lazy var formatter = assembly.dateFormatter(format: .HHmmss)
    lazy var dataStorage = assembly.dataStorage
    lazy var apiClient = assembly.apiClient
    lazy var bootstrapDataProvider = assembly.bootstrapDataProvider

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        bootstrapDataProvider.loadResources{
//            result in print(result)
//        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    /*
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
     */


}

