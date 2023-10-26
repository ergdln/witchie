//
//  witchieApp.swift
//  witchie
//
//  Created by egln on 20/07/23.
//

import SwiftUI
//import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    
       @ObservedObject var notificationManager = NotificationManager.shared
    
      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
          notificationManager.requestNotificationAuthorization()
        //FirebaseApp.configure()
        return true
      }
    }

@main
struct witchieApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject var notificationManager = NotificationManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { newScenePhase in
                    switch newScenePhase {
                    case .active:
                        notificationManager.clearNotifications(notificationIdentifier: "Inactivity")
                        print("App is active")
                    case .inactive:
                        notificationManager.scheduleNotifications()
                        print("App is inactive")
                    case .background:
                        print("App is in background")
                    @unknown default:
                        print("Oh - interesting: I received an unexpected new value.")
                    }
                }
    }
}
