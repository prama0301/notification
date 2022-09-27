//
//  ViewController.swift
//  notification
//
//  Created by Capgemini-DA164 on 9/6/22.
//

import UIKit
import UserNotifications
class ViewController: UIViewController{
    let notificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setNotification()
        
        NotificationCenter.default.addObserver(self, selector: #selector(UserLogin), name: Notification.Name("UserLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(IgnoreLogin), name: Notification.Name("IgnoreLogin"), object: nil)
        
    }
    
    @objc func UserLogin(_ notification: Notification){
        print("UserLogin Notification")
    }
    
    @objc func IgnoreLogin(_ notification: Notification){
        print("IgnoreLogin Notification")
    }
    func setNotification() {
         //Notification conent
         let content = UNMutableNotificationContent()
         content.title = "Local Notification"
         content.body = "hello App"
         
       content.categoryIdentifier = "replyCategory"
       
       let userDict: [String : String] = ["notification" : "notification"]
        content.userInfo = userDict
        
        
     setUserNotificationCenter()
        
        //Notification trigger
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
         //Request
         let testNotification = UUID().uuidString
         let request = UNNotificationRequest(identifier: testNotification, content: content, trigger: trigger)
         
         notificationCenter.add(request) {
             (error) in
             if let error = error {
                 print("error: " , error)
             }
         }
     }
    func setUserNotificationCenter() {
         UNUserNotificationCenter.current().delegate = self
   let replyAction = UNNotificationAction(identifier: "replyAction", title: "reply", options: [])
   let ignoreAction = UNNotificationAction(identifier: "ignoreAction", title: "Ignore", options: [])
   let Notification = UNNotificationCategory(identifier: "replyCategory", actions: [replyAction, ignoreAction], intentIdentifiers: [], options: [])
 
   UNUserNotificationCenter.current().setNotificationCategories([Notification])
     }
}
extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
     /*   let userInfo = response.notification.request.content.userInfo
        
        let test = userInfo["notification"]
        
        if (test as! String == "notification") {
           let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let notificationVC = storyBoard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            self.navigationController?.pushViewController(notificationVC, animated: true)
        } */
       switch response.actionIdentifier {
        case "replyAction" :
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserLogin"), object: nil)
            print("Reply  button is Clicked")
        case "ignoreAction" :
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "IgnoreLogin"), object: nil)
           print("Ignore Button is clicked")
        default:
           let userInfo = response.notification.request.content.userInfo
              
              let test = userInfo["notification"]
              
              if (test as! String == "notification") {
                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                  let notificationVC = storyBoard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
                  self.navigationController?.pushViewController(notificationVC, animated: true)
              }
           break
        }
        completionHandler()
    }
}
