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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
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
        
        memedetailcontroller.memed  = self.memes[indexPath.item]
        
        self.navigationController!.pushViewController(memedetailcontroller, animated: true)
    }
    
    
}
