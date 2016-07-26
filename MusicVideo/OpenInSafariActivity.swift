//
//  File.swift
//  MusicVideo
//
//  Created by Veronica on 16/7/26.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import Foundation
import UIKit

class OpenInSafariActivity: UIActivity {
    
    var OpenURL = NSURL(string: "https://www.google.com")
    
    override class func activityCategory() -> UIActivityCategory {
        return .Action
    }
    
    override func activityTitle() -> String? {
        return  "Open in Safari"
    }
    
    override func activityImage() -> UIImage? {
        return UIImage(named:"Redesign-Safari")
    }
    
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
       
        for item in activityItems{
            
            if let _  = item as? NSURL {
                return true
            }
            
        }
        return false
    }
    
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        
        for item in activityItems {
            if let url = item as? NSURL {
                
                OpenURL = url
            } else {
              //  print("Can't find url in itmes")
            }
        }
    }
    
    override func performActivity() {
        super.performActivity()
        if  let URL = OpenURL {
            UIApplication.sharedApplication().openURL(URL)
            
        }
        self.activityDidFinish(true)
    }
    

}