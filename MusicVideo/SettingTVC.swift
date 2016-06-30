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
    
    @IBOutlet weak var bestImageDisplay: UILabel!
    
    @IBOutlet weak var APICountDisplay: UILabel!
    
    private var fontStyle: UIFont {
        return UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.changeFontStyle) , name: UIContentSizeCategoryDidChangeNotification , object: nil)
    }
    
    func changeFontStyle() {
        aboutDisplay.font = fontStyle
        feedbackDisplay.font = fontStyle
        securityDisplay.font = fontStyle
        bestImageDisplay.font = fontStyle
        APICountDisplay.font = fontStyle
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil )
    }
    
}
