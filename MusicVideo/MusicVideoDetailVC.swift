//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/28.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import LocalAuthentication

class MusicVideoDetailVC: UIViewController {

    var videos:Videos?
    var securitySwitch = false
    
    var preferredFontStyle: UIFont {
        return UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    }
    
    @IBOutlet weak var vImage: UIImageView!
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vRights: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(self.changedFontStyle),
                                                         name: UIContentSizeCategoryDidChangeNotification, object: nil)
        updateView()
    }
    
    func changedFontStyle() {
        vName.font = preferredFontStyle
        vGenre.font = preferredFontStyle
        vRights.font = preferredFontStyle
        vPrice.font = preferredFontStyle
    }
    func updateView() {
        self.title = videos?.vArtist
        vName.text = videos?.vName
        vGenre.text = videos?.vGenre
        vRights.text = videos?.vRights
        vPrice.text = videos?.vPrice
        
        if videos?.vImageData != nil {
            self.vImage.image = UIImage(data: (self.videos?.vImageData)!)
        } else {
            vImage.image = UIImage(named: "imageNotAvailable")
            
        }
    }
    
    func shareWithSocialMedia() {
        let activity1 = "你听过这首歌吗？"
        let activity2 = "\(videos?.vName) by \(videos?.vArtist)"
        let activity3 = "试试看吧，告诉我你的感受"
        let activity4 = videos?.vLinkToiTunes
        let activity5 = "分享自：iTunes Top 音乐榜，made by Shao Yunming"
        let URLToItunse = NSURL(string: activity4!)
        
        let openInSafari = OpenInSafariActivity()
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4!, activity5,URLToItunse!], applicationActivities: [openInSafari])
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func shareSocialMedia(sender: UIBarButtonItem) {
        
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        switch securitySwitch {
        case true:
            touchIdChk()
        default:
            shareWithSocialMedia()
        }
        
    }
    
    func touchIdChk() {
        
        //Creat an alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "continue", style: UIAlertActionStyle.Cancel, handler: nil))
        
        
        //Creat the local Authentication Context
        let context = LAContext()
        var touchIDError: NSError?
        let reasonString = "Touch-Id authentication is needed to share info on Social media"
        
        //Check if we can access local device  authentication
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIDError) {
            
            //Check what the authentication reponse was
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString,
                                   reply: {(success, policyError) -> Void in
                                    if success {
                                        
                                        //User authenticated useing Local Device Authentication Successfully!
                                        dispatch_async(dispatch_get_main_queue()){
                                            [unowned self] in self.shareWithSocialMedia()
                                        }
                                    } else {
                                        
                                        alert.title = "Unsuccessful!"
                                        
                                        switch LAError(rawValue: policyError!.code)! {
                                        case .AppCancel:
                                            alert.message = "Authentication was cancelled by application"
                                        
                                        case .AuthenticationFailed:
                                            alert.message = "The user failed to provide valid credentials"
                                            
                                        case.PasscodeNotSet:
                                            alert.message = "Passcode is not set on the phone"
                                            
                                        case.SystemCancel:
                                            alert.message = "Authentication was cancelled by the system"
                                            
                                        case.TouchIDLockout:
                                            alert.message = "Too many failed attempts"
                                            
                                        case.UserCancel:
                                            alert.message = "You cancelled the request"
                                            
                                        case.UserFallback:
                                            alert.message = "Password not accepted, must use Touch-ID"
                                            
                                        default:
                                            alert.message = "Unable to Authenticate!"
                                        }
                                        
                                        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                                           self.presentViewController(alert, animated: true, completion: nil)
                                        }
                                        }
        })
        }else  {
            //Unable to access local device authentication
            
            //set the error title
            alert.title = "Error"
            
            //set the error message with more information
            switch LAError(rawValue: touchIDError!.code)! {
               
            case.TouchIDNotAvailable:
                alert.message = "TouchID is not available on the device"
                
            case.TouchIDNotEnrolled:
                alert.message = "Touch-ID is not enrolled"
                
            case .PasscodeNotSet:
                alert.message = "Passcode has not been set"
                
            case .InvalidContext:
                alert.message = "The context is invalid"
                
            default:
                alert.message = "Local Authentication not available"
            }
            
            dispatch_async(dispatch_get_main_queue()) {[unowned self] in
                self.presentViewController(alert, animated: true, completion: nil)
            }

            }
        
    
    }
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
        let url = NSURL(string: (videos?.vVideoUrl)!)
        let video = AVPlayer(URL: url!)
        let avController = AVPlayerViewController()
        avController.player = video
        
        self.presentViewController(avController, animated: true ) {
            avController.player?.play()
        }
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
}
