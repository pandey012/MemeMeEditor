//
//  ViewController.swift
//  MemeEditor
//
//  Created by Himanshu Pandey on 6/8/16.
//  Copyright © 2016 Himanshu Pandey. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    
    let memeTextAttributes = [  NSStrokeColorAttributeName : UIColor.blackColor(),
                                NSForegroundColorAttributeName : UIColor.whiteColor() ,                               NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                                NSStrokeWidthAttributeName : -3.0
    ];
    @IBOutlet weak var imagePicker: UIBarButtonItem!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cancel: UIBarButtonItem!
    var memedImage: UIImage!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self;
        bottomTextField.delegate = self;
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        shareButton.enabled = false;
        
    }
    
    @IBAction func shareAction(sender: AnyObject) {
        
        
        let message = "Check This out";
        memedImage = generateMemedImage();
        let sharedImage = [message, memedImage];
        
        let activityController = UIActivityViewController(activityItems: sharedImage, applicationActivities: nil)
        
        
        presentViewController(activityController, animated: true, completion: nil);
        
        
        activityController.completionWithItemsHandler = {
            (s: String?, ok: Bool, items: [AnyObject]?, err:NSError?) -> Void in
            
            self.save();
            self.dismissViewControllerAnimated(true, completion: nil);
            
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated);
        
        subscribeToKeyBoardNotifications();
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        
        unsubscribeToKeyboardNotifications();
    }
    
    @IBAction func pickAnImage(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        switch(sender.tag){
            case 0:
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            case 1:
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            default:
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            
        }
        presentViewController(imagePicker, animated: true, completion: nil)
        shareButton.enabled = true
        
        
    }
    
   /* @IBAction func pickAmImageFromCamera(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        shareButton.enabled = true
        
    }
    */
    
    
    @IBAction func cancel(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil
        shareButton.enabled = false
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func keyboardWillSHow(notification : NSNotification)
    {
        if(bottomTextField.editing){
             view.frame.origin.y -= getKeyboardHeight(notification)
        }
       
        
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as!NSValue
        return keyboardSize.CGRectValue().height;
    }
    
    func subscribeToKeyBoardNotifications()
    {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillSHow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController
            .keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications()
    {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func keyboardWillHide(notification: NSNotification)
    {
        view.frame.origin.y = 0;
    }
    
    
    
    func save()
    {
        _ = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imagePickerView.image!, memeImage : memedImage);
        
        
    }
    
    func generateMemedImage() -> UIImage
    {
        // navBar.hidden = true
        toolBar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memdImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // navBar.hidden = false
        toolBar.hidden = false
        
        return memdImage
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        topTextField.resignFirstResponder();
        bottomTextField.resignFirstResponder();
        return true;
    }
    
    
    
    
}
