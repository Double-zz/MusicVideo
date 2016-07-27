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
    
    // activityCategory 有两个状态share 和 action， share 主要是分享有可能要打开弹窗，action主要是对数据的操作
    override class func activityCategory() -> UIActivityCategory {
        return .Action
    }
    
    override func activityTitle() -> String? {
        return  "Open in Safari"
    }
    
    override func activityImage() -> UIImage? {
        return UIImage(named:"Redesign-Safari")
    }
    
    // 检查数据类型是否匹配能否启用此activity
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
       
        for item in activityItems{
            
            if let _  = item as? NSURL {
                return true
            }
            
        }
        return false
    }
    
    // 准备数据
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        
        for item in activityItems {
            if let url = item as? NSURL {
                
                OpenURL = url
            } else {
              //  print("Can't find url in itmes")
            }
        }
    }
    
    //处理数据
    override func performActivity() {
        super.performActivity()
        if  let URL = OpenURL {
            UIApplication.sharedApplication().openURL(URL)
            
        }
        //操作完成标记操作结束
        self.activityDidFinish(true)
    }
    
    

}