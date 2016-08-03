//
//  SettingVC.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/30.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit
import MessageUI

class SettingTVC: UITableViewController,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var feedbackDisplay: UILabel!

    @IBOutlet weak var securityDisplay: UILabel!
    
    @IBOutlet weak var touchID: UISwitch!
    
    @IBOutlet weak var bestImageDisplay: UILabel!
    
    @IBOutlet weak var APICountDisplay: UILabel!
    
    @IBOutlet weak var sliderValue: UISlider!
    
    @IBOutlet weak var numberOfMusicVideos: UILabel!
    
    @IBOutlet weak var dragTheSlider: UILabel!
   
    @IBOutlet weak var imageQualitySwitch: UISwitch!
    
    private var fontStyle: UIFont {
        return UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.alwaysBounceVertical = false
        
        title = "Setting"
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        imageQualitySwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("BestImage")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.changeFontStyle) , name: UIContentSizeCategoryDidChangeNotification , object: nil)
        
        if NSUserDefaults.standardUserDefaults().objectForKey("sliderValue") != nil {
            
            let value = NSUserDefaults.standardUserDefaults().objectForKey("sliderValue") as! Int
            APICountDisplay.text = "\(value)"
            sliderValue.value = Float(value)
        } else {
            sliderValue.value = 10.0
            APICountDisplay.text = "\(Int(sliderValue.value))"
        }
        
    }
    
    func changeFontStyle() {
        aboutDisplay.font = fontStyle
        feedbackDisplay.font = fontStyle
        securityDisplay.font = fontStyle
        bestImageDisplay.font = fontStyle
        APICountDisplay.font = fontStyle
        numberOfMusicVideos.font = fontStyle
        dragTheSlider.font = fontStyle
    }
    
    @IBAction func touchIDSecurity(sender: UISwitch) {
        if NSUserDefaults.standardUserDefaults().boolForKey("ToucnIDChecked") {
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if touchID.on == true {
                defaults.setBool(true, forKey: "SecSetting")
                
            } else {
                defaults.setBool(false, forKey: "SecSetting")
                
            }
        } else {
            let alert = UIAlertController(title: "Wrong", message: "TouchID can not use in this device",preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: {[unowned self] in self.touchID.on = false})
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(false, forKey: "SecSetting")
            
        }
        
        
    }
    
    

    @IBAction func valueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(sliderValue.value, forKey: "sliderValue")
        
        APICountDisplay.text = "\(Int(sliderValue.value))"
        
    }
    
    // switch image quality
    @IBAction func imageQualitySwitch(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if imageQualitySwitch.on == true {
            defaults.setBool(true, forKey: "BestImage")
            print("High qulity image been set")
        } else {
            defaults.setBool(false, forKey: "BestImage")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 1 {
            let mailComposeViewController = confighureMall()
            
            if MFMailComposeViewController.canSendMail() {
                
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                mailAlert()
            }
        }
    }
    
    func confighureMall() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["ffxdz123@gmail.com"])
        mailComposeVC.setSubject("Music Video App Feedback")
        mailComposeVC.setMessageBody("Hi, developer, \n\nI would like to share the following feedback ...\n", isHTML: false)
        return mailComposeVC
        
    }
    
    func mailAlert() {
        let alertController:UIAlertController = UIAlertController(title: "Alert", message: "No e-mail Account setup for phoe", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) {
            actoion  -> Void in
            // add action code here
        }
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail failed")
        default:
            print("UNKnow Issue")
        }
        
        self.dismissViewControllerAnimated(true, completion: {print("dismiss mail view")})
        
    }
        
 
        
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil )
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showAbout" {
            print("Just push about view to main window")
            
        }
    }
    
}
