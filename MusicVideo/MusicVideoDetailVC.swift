//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Veronica on 16/6/28.
//  Copyright © 2016年 Veronica. All rights reserved.
//

import UIKit

class MusicVideoDetailVC: UIViewController {

    var videos:Videos?
    
    @IBOutlet weak var vImage: UIImageView!
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vRights: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
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
}
