//
//  MemeModel.swift
//  MeMe2
//
//  Created by Suvam Paul on 8/22/15.
//  Copyright (c) 2015 Suvam Paul. All rights reserved.
//

import Foundation


import Foundation
import UIKit

class Meme {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memeImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage, memeImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memeImage = memeImage
    }
}

