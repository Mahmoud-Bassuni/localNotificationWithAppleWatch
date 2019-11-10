//
//  ExtensionDelegate.swift
//  PssosmtWatch Extension
//
//  Created by Bassuni on 10/31/19.
//  Copyright © 2019 futureface. All rights reserved.
//


import WatchKit
import UserNotifications
import AVFoundation
class ExtensionDelegate: NSObject, WKExtensionDelegate  {


    var player: AVAudioPlayer?
    func playSound() {
        guard let url = Bundle.main.url(forResource: "mahmoud", withExtension: "mpeg") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

    func fireaction()
    {
       let firedate = Date(timeIntervalSinceReferenceDate: 60)

        WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: firedate, userInfo: nil) { (Error) in
            if Error == nil{
                self.playSound()
            }
        }
    }
    func applicationDidFinishLaunching() {
        UNUserNotificationCenter.current().delegate = self
        setUpNotificationPreferences()
        // Perform any final initialization of your application.
    }
    func applicationDidBecomeActive() {


        // SoundManagement.shared.stopSound()
        //player?.stop()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    //    func applicationWillResignActive() {
    //        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    //        // Use this method to pause ongoing tasks, disable timers, etc.
    //    }
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
       // for task in backgroundTasks {
             playSound()
            // Use a switch statement to check the task type
//            switch task {
//            case let backgroundTask as WKApplicationRefreshBackgroundTask:
//                  playSound()
//                // Be sure to complete the background task once you’re done.
//            //    backgroundTask.setTaskCompletedWithSnapshot(false)
//            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
//                 playSound()
//                // Snapshot tasks have a unique completion call, make sure to set your expiration date
//                //snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
//
//
//            // SoundManagement.shared.playSound()
//            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
//                  playSound()
//                // Be sure to complete the connectivity task once you’re done.
//             //   connectivityTask.setTaskCompletedWithSnapshot(false)
//            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
//                  playSound()
//                // Be sure to complete the URL session task once you’re done.
//              //  urlSessionTask.setTaskCompletedWithSnapshot(false)
//            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
//                  playSound()
//                // Be sure to complete the relevant-shortcut task once you're done.
//             //   relevantShortcutTask.setTaskCompletedWithSnapshot(false)
//            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
//                  playSound()
//                // Be sure to complete the intent-did-run task once you're done.
//            //    intentDidRunTask.setTaskCompletedWithSnapshot(false)
//            default:
//                // make sure to complete unhandled task types
//                  playSound()
//               // task.setTaskCompletedWithSnapshot(false)
//            }
       // }
    }

}
extension ExtensionDelegate : UNUserNotificationCenterDelegate{
    // recive notification
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler(.alert)
        playSound()
        // SoundManagement.shared.playSound()
    }
    func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Swift.Void) {
        playSound()
        //SoundManagement.shared.playSound()
    }

    // recive notification with data
    func didReceiveRemoteNotification(_ userInfo: [AnyHashable : Any],
                                      fetchCompletionHandler completionHandler: @escaping (WKBackgroundFetchResult) -> Void)
    {
        playSound()
        //SoundManagement.shared.playSound()
        completionHandler(.newData)
    }



    func application(_ notification: UNNotification, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (WKBackgroundFetchResult) -> Void) {
 playSound()


    }

    // user open notification
    // MARK: UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        NSLog("\(#function)")

        player?.stop()
        // SoundManagement.shared.stopSound()
        //completionHandler()

    }


    func setUpNotificationPreferences() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                let category = UNNotificationCategory(identifier: "GENERAL", actions: [], intentIdentifiers: [], options: [])
                center.setNotificationCategories(Set([category]))
            } else {
                print("No permission" + error.debugDescription)
            }
        }
    }

}

