//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Annie on 4/25/23.
//


import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct YourApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var locationVM = LocationViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(locationVM)
            
        }
    }
}
