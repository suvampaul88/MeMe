//
//  MeMeCollectionViewController.swift
//  MeMe2
//
//  Created by Suvam Paul on 8/22/15.
//  Copyright (c) 2015 Suvam Paul. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!
    
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        
        let space: CGFloat = 3.0
        let wDimension = ((view.frame.size.width) - (2 * space)) / 3
        let hDimension = ((view.frame.size.height) - (2 * space)) / 4
        
        flowlayout.minimumInteritemSpacing = space
        flowlayout.minimumLineSpacing = space
        flowlayout.itemSize = CGSizeMake(wDimension, hDimension)
    }
    
        
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionViewCell", forIndexPath: indexPath) as! UICollectionViewCell
        let meme = memes[indexPath.row]
        let image = UIImageView(image: meme.memeImage)
        
        cell.backgroundView = image
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let memedetailcontroller = self.storyboard!.instantiateViewControllerWithIdentifier("MeMeDetailsController") as! MemeDetailsController
        
        memedetailcontroller.memed  = memes[indexPath.item]
        
        navigationController!.pushViewController(memedetailcontroller, animated: true)
    }
    
    
}
