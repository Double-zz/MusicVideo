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

class MusicVideoDetailVC: UIViewController {

    var videos:Videos?
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
    
    @IBAction func shareSocialMedia(sender: UIBarButtonItem) {
        
        shareWithSocialMedia()
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
