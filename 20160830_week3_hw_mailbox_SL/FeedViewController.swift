//
//  FeedViewController.swift
//  20160830_week3_hw_mailbox_SL
//
//  Created by Leung, Shelley on 8/30/16.
//  Copyright © 2016 Leung, Shelley. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var feedScrollView: UIScrollView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rescheduleImageView: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    
    
    var messageOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedScrollView.contentSize = CGSize(width: 320, height: 1288)
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func didPanMessasge(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
        let location = sender.locationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began{
            
            messageOriginalCenter = messageView.center
        }
            
        else if sender.state == UIGestureRecognizerState.Changed{
            
            messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)

            print("Your location is: \(location)")
            
            // pan left 60pts, change color to yellow
            if messageView.center.x >= -100 && messageView.center.x < 100 {
                
                UIView.animateWithDuration(0.2, animations: { 
                    self.rightImageView.backgroundColor = UIColorFromRGB(0xF8E71C)
                    self.listIcon.alpha = 0
                    self.laterIcon.alpha = 1
                })
            }
            
            // pan left 260pts, change color to brown
            else if messageView.center.x < -100{
                
                UIView.animateWithDuration(0.2, animations: { 
                    self.rightImageView.backgroundColor = UIColorFromRGB(0x8B572A)
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 1
                })
            }
            
            // pan between left 60pts and center
            else if messageView.center.x >= 100 && messageView.center.x < 160 {
                
                UIView.animateWithDuration(0.2, animations: {
                    self.rightImageView.backgroundColor = UIColorFromRGB(0xD8D8D8)
                    self.laterIcon.alpha = 0.25

                    }, completion: { (Bool) in
                        
                })
            }
                
            // pan right 60pts, change color to green
            else if messageView.center.x >= 220 && messageView.center.x < 320 {
                
                UIView.animateWithDuration(0.2, animations: { 
                    self.leftImageView.backgroundColor = UIColorFromRGB(0x5EE375)
                    self.archiveIcon.alpha = 1
                    self.deleteIcon.alpha = 0
                    
                })
            }
            
            // pan right 260pts, change color to red
            else if messageView.center.x >= 320 {
                
                UIView.animateWithDuration(0.2, animations: { 
                    self.leftImageView.backgroundColor = UIColorFromRGB(0xC24141)
                    self.deleteIcon.alpha = 1
                    self.archiveIcon.alpha = 0
                })
            }
            
            // pan between right 60pts and center
            else if messageView.center.x >= 160 && messageView.center.x < 220 {
                
                UIView.animateWithDuration(0.2, animations: { 
                     self.leftImageView.backgroundColor = UIColorFromRGB(0xD8D8D8)
                    self.archiveIcon.alpha = 0.25
                })
            }
            
        }

    else if sender.state == UIGestureRecognizerState.Ended{
 
            // stop before left 60pts, return to original position
            if messageView.center.x >= 100 && messageView.center.x < 160{
                print("Your translation is: \(messageOriginalCenter.x - messageView.center.x), gray")
                
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.messageView.center = CGPoint(x: 160, y: 43)
                }, completion: { (Bool) in

                    
                })
            }
            
            // stop after left 60pts, display reschedule
            else if messageView.center.x >= -100 && messageView.center.x < 100{
            print("Your translation is: \(messageOriginalCenter.x - messageView.center.x),yellow")
                
            UIView.animateWithDuration(0.2, animations: {
                self.rightImageView.backgroundColor = UIColorFromRGB(0xF8E71C)
                self.messageView.center = CGPoint(x: -160, y: 43)
                self.laterIcon.alpha = 0
                }, completion: { (Bool) in
                self.rescheduleImageView.alpha = 1
             })
            }
        
            // stop after left 260pts, display list
            else if messageView.center.x < -100
            {
                 print("Your translation is: \(messageOriginalCenter.x - messageView.center.x),brown")
                
                UIView.animateWithDuration(0.2, animations: {
                    self.rightImageView.backgroundColor = UIColorFromRGB(0x8B572A)
                    self.messageView.center = CGPoint(x: -160, y: 43)
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 1
                    }, completion: { (Bool) in
                        self.listImageView.alpha = 1
                })
            }
            
            // stop before right 60pts, return to original position
            else if messageView.center.x >= 160 && messageView.center.x < 220{
                
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.messageView.center = CGPoint(x: 160, y: 43)
                    }, completion: { (Bool) in
                        
                        
                })
            
            }
            
            // stop after right 60pts, hide the message
            else if messageView.center.x >= 220 && messageView.center.x < 320{
                
                UIView.animateWithDuration(0.5, animations: {
                    self.rightImageView.backgroundColor = UIColorFromRGB(0x5EE375)
                    self.messageView.center = CGPoint(x: 480, y: 43)
                    self.archiveIcon.alpha = 0
                    self.feedScrollView.center.y -= 86
                    }, completion: { (Bool) in
                        self.rightImageView.backgroundColor = UIColorFromRGB(0xFFFFFF)
                })
            
            }
            
            // stop after right 260pts, hide the message
            else if messageView.center.x >= 320{
                
                UIView.animateWithDuration(0.5, animations: {
                    self.rightImageView.backgroundColor = UIColorFromRGB(0xC24141)
                    self.messageView.center = CGPoint(x: 480, y: 43)
                    self.deleteIcon.alpha = 0
                    self.feedScrollView.center.y -= 86
                    }, completion: { (Bool) in
                        self.rightImageView.backgroundColor = UIColorFromRGB(0xFFFFFF)
                })

            
            }
        }
        
    }
    
    
    @IBAction func didTapReschedule(sender: UITapGestureRecognizer) {
        self.rescheduleImageView.alpha = 0
        UIView.animateWithDuration(0.2) { 
            
            self.feedScrollView.center.y -= 86
            self.rightImageView.backgroundColor = UIColorFromRGB(0xFFFFFF)
        }
    }
    
    
    @IBAction func didTapList(sender: UITapGestureRecognizer) {
        self.listImageView.alpha = 0
        UIView.animateWithDuration(0.2) {
            
            self.feedScrollView.center.y -= 86
            self.rightImageView.backgroundColor = UIColorFromRGB(0xFFFFFF)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
