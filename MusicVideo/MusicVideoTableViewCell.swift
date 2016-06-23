//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/22.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var video: Videos? {
        didSet {
            updateCell()
        }
    }
    
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell() {
        rank.text = ("\(video!.vrank)")
        musicTitle.text = video?.vName
        
        if video!.vImageData != nil {
            print("get image from local data")
            musicImage.image = UIImage(data: video!.vImageData!)
        } else {
            getImageData(video!, imageView: musicImage)
        }
    }
    
    
    
    
    
    func getImageData(video: Videos, imageView: UIImageView) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            
            var image: UIImage?
            
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            dispatch_async(dispatch_get_main_queue()) {
                // rprint("get image from url")
                imageView.image = image
            }
        }
        
    }
    
        
        
        
        
        
//        if let imageURL = NSURL(string: urlString) {
//            if let data = NSData(contentsOfURL: imageURL){
//                video?.vImageData = data
//                let image = UIImage(data: data)
//                imageView.image = image
//            } else {
//                print("image data was error")
//            }
//        } else {
//            print("image url is error")
//        }
//    }
    
    
    
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
