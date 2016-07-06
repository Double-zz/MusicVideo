//
//  SettingVC.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/30.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit

class SettingTVC: UITableViewController {
    
    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var feedbackDisplay: UILabel!

    @IBOutlet weak var securityDisplay: UILabel!
    
    @IBOutlet weak var touchID: UISwitch!
    
    @IBOutlet weak var bestImageDisplay: UILabel!
    
    @IBOutlet weak var APICountDisplay: UILabel!
    
    @IBOutlet weak var sliderValue: UISlider!
    
    @IBOutlet weak var numberOfMusicVideos: UILabel!
    
    @IBOutlet weak var dragTheSlider: UILabel!
    
    private var fontStyle: UIFont {
        return UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.alwaysBounceVertical = false
        
        title = "Setting"
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
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
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if touchID.on == true {
            defaults.setBool(true, forKey: "SecSetting")
        
        } else {
            defaults.setBool(false, forKey: "SecSetting")
            
        }
        
    }

    @IBAction func valueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(sliderValue.value, forKey: "sliderValue")
        
        APICountDisplay.text = "\(Int(sliderValue.value))"
        
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
