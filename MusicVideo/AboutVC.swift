//
//  AboutVC.swift
//  MusicVideo
//
//  Created by Veronica on 16/7/1.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var aboutTextView: UITextView!
    
    @IBOutlet weak var imageLeft: UIImageView!
    
    
   private var aboutText: String {
        return "This is a study project. Everything builds for testing and learning. If this APP has any bug, you can let me know with Github, and Email. Thank you for your time! I hope that we can learn together and progress together! By Yunming Shao Of 2016-07-01"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    func updateView() {
        
        aboutTextView.text = aboutText
        aboutTextView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        imageLeft.image = UIImage(named: "aboutTest")
    }
    
}
