//
//  ViewController.swift
//  localNotification
//
//  Created by Bassuni on 10/26/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func runLocalNotificationAction(_ sender: Any) {

        let content = UNMutableNotificationContent()

               //adding title, subtitle, body and badge
               content.title = "Hey this is Simplified iOS"
               content.subtitle = "iOS Development is fun"
               content.body = "We are learning about iOS Local Notification"
               content.badge = 1
        content.sound = UNNotificationSound.default
               //getting the notification trigger
               //it will be called after 1 seconds
               let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
               let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
               UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
          }
        }

extension ViewController: UNUserNotificationCenterDelegate {


    //for displaying notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        //If you don't want to show notification when app is open, do something here else and make a return here.
        //Even you you don't implement this delegate method, you will not see the notification on the specified controller. So, you have to implement this delegate and make sure the below line execute. i.e. completionHandler.

        completionHandler([.alert, .badge, .sound])
    }

    // For handling tap and user actions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        completionHandler()
    }

}
