//
//  MeMeTableViewController.swift
//  MeMe2
//
//  Created by Suvam Paul on 8/22/15.
//  Copyright (c) 2015 Suvam Paul. All rights reserved.
//

import Foundation


import UIKit

class MeMeTableViewController: UITableViewController {
    
    var memes: [Meme]!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        tableView!.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("memeTableViewCell") as! UITableViewCell
        let meme = self.memes[indexPath.row]
        
        cell.textLabel?.text = meme.topText + "-" + meme.bottomText
        cell.imageView?.image = meme.memeImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let memedetailcontroller = storyboard?.instantiateViewControllerWithIdentifier("MeMeDetailsController") as! MemeDetailsController
        
        memedetailcontroller.memedImage = memes[indexPath.item]
        
        navigationController!.pushViewController(memedetailcontroller, animated: true)
    
    }
}