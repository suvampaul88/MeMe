//
//  MemeDetailsController.swift
//  MeMe2
//
//  Created by Suvam Paul on 8/22/15.
//  Copyright (c) 2015 Suvam Paul. All rights reserved.
//


import UIKit

class MemeDetailsController: UIViewController {
    
    var memed : Meme!
    
    @IBOutlet weak var selectedMemedImage: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
      selectedMemedImage.image = memed.memeImage
        
        
    }

}
