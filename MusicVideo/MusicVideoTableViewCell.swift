//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/22.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var videos: Videos? {
        didSet {
            updateCell()
        }
    }
    
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell() {
        musicImage.image = UIImage(named: "imageNotAvailable")
        rank.text = ("\(videos!.vrank)")
        musicTitle.text = videos?.vName
        
    }
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
