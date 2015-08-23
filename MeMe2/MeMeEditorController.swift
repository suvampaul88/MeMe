//
//  MeMeEditorController.swift
//  MeMe2
//
//  Created by Suvam Paul on 8/22/15.
//  Copyright (c) 2015 Suvam Paul. All rights reserved.
//

import UIKit

class MeMeEditorController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    
    @IBOutlet weak var sharememeButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    @IBOutlet weak var textfieldTop: UITextField!
    @IBOutlet weak var textfieldButtom: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view color
        view.backgroundColor = UIColor.grayColor()
        
        //sharememe button disables
        sharememeButton.enabled = false
        
        //textfield related functions
        
        formatmemeText("TOP", textfield: textfieldTop)
        formatmemeText("BUTTOM", textfield: textfieldButtom)
        
//      text alignment
        textfieldTop.textAlignment = NSTextAlignment.Center
        textfieldButtom.textAlignment = NSTextAlignment.Center
        
    }
    
    //define attributes of texts in textfields
    let memeTextArrributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 38)!,
        NSStrokeWidthAttributeName : NSNumber(float: -3.0)
    ]
    
    
    func formatmemeText(text: String, textfield: UITextField) {
        textfield.text = text
//      textfield.textAlignment = NSTextAlignment.Center---NOTE: I can never get alignment to work in the method, so placed it in viewDidLoad
        textfield.defaultTextAttributes = memeTextArrributes
        textfield.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //subscribe to notification
        self.subscribeToKeyboardNotification()
        
        //enable access to camera if available
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        //unsunscribe from notification
        self.unsubscribeFromKeyboardNotification()
    }
    
    func imagepickerSource(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func pickfromAlbum(sender: AnyObject) {
        imagepickerSource(.PhotoLibrary)
    }
    
    
    @IBAction func pickfromCamera(sender: AnyObject) {
        imagepickerSource(.Camera)
    }

    
    
    @IBAction func shareMeme(sender: AnyObject) {
        let memedImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {
            (activityItem: String!, completed: Bool, item: [AnyObject]!, error:NSError!) -> Void in
            self.save()
            
            if (!completed) {
                return
            }
            println("Shared meme activity: \(activityItem)")
        }
        
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    
    @IBAction func cancelMeme(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //choose image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
            self.imageView.contentMode = UIViewContentMode.ScaleToFill
            self.dismissViewControllerAnimated(true, completion: nil)
            
            sharememeButton.enabled = true
            
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //functions for textfield
    
    //keyboard disappears when return button is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    //dismiss keyboard
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    
    //keyboard adjustments
    
    //show keyboard
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userinfo = notification.userInfo
        let keyboardSize = userinfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if textfieldButtom.isFirstResponder(){
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    //hide keyboard
    
    func keyboardWillHide(notification: NSNotification){
        if textfieldButtom.isFirstResponder(){
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    
    //notifications for keyboard
    
    func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    
    
    func save() {
        var memedImage = generateMemedImage()
        var meme = Meme(topText: textfieldTop.text!, bottomText: textfieldButtom.text!, originalImage: imageView.image!, memeImage: generateMemedImage())
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        
    }
    
    
    func generateMemedImage() -> UIImage {
        
        self.toolBar.hidden = true
        self.navigationBar.hidden = true
        
        //render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.toolBar.hidden = false
        self.navigationBar.hidden = false
        
        
        return memedImage
        
    }
}