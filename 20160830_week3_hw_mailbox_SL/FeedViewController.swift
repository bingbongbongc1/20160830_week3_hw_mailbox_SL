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
           
            UIView.animateWithDuration(0.5, animations: {
                self.laterIcon.alpha = 1
                }, completion: { (Bool) in
                    
            })
            
            // pan left, change color to yellow
            if messageView.center.x >= -100 && messageView.center.x < 100 {
                self.rightImageView.backgroundColor = UIColor(red: 248/255, green: 231/255, blue: 28/255, alpha: 1)
                self.listIcon.alpha = 0
                self.laterIcon.alpha = 1
            }
            
            // pan more left, change color to brown
            else if messageView.center.x < -100{
                self.rightImageView.backgroundColor = UIColor(red: 182/255, green: 150/255, blue: 122/255, alpha: 1)
                self.laterIcon.alpha = 0
                self.listIcon.alpha = 1
            }
            
            // pan right, change color to green
            else if messageView.center.x >= 220 && messageView.center.x < 320 {
                self.rightImageView.backgroundColor = UIColor(red: 51/255, green: 191/255, blue: 101/255, alpha: 1)
            }
            
        }

    else if sender.state == UIGestureRecognizerState.Ended{
    
        if messageView.center.x >= 100 && messageView.center.x < 160
//            messageOriginalCenter.x - messageView.center.x < 60 && messageOriginalCenter.x - messageView.center.x >= 0 || messageOriginalCenter.x - messageView.center.x > -60 && messageOriginalCenter.x - messageView.center.x <= 0
            {
                print("Your translation is: \(messageOriginalCenter.x - messageView.center.x), gray")
                
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.messageView.center = CGPoint(x: 160, y: 43)
                }, completion: { (Bool) in
                    
                })
            }
            
            else if messageView.center.x >= -100 && messageView.center.x < 100
//            messageOriginalCenter.x - messageView.center.x < 200 && messageOriginalCenter.x - messageView.center.x >= 60
            {print("Your translation is: \(messageOriginalCenter.x - messageView.center.x),yellow")
                
            UIView.animateWithDuration(0.2, animations: {
                self.rightImageView.backgroundColor = UIColor(red: 248/255, green: 231/255, blue: 28/255, alpha: 1)
                self.messageView.center = CGPoint(x: -160, y: 43)
                self.laterIcon.alpha = 0
                }, completion: { (Bool) in
                self.rescheduleImageView.alpha = 1
             })
            }
            
            else if messageView.center.x < -100
//            messageOriginalCenter.x - messageView.center.x >= 260
            {
                 print("Your translation is: \(messageOriginalCenter.x - messageView.center.x),brown")
                
                UIView.animateWithDuration(0.2, animations: {
                    self.rightImageView.backgroundColor = UIColor(red: 182/255, green: 150/255, blue: 122/255, alpha: 1)
                    self.messageView.center = CGPoint(x: -160, y: 43)
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 1
                    }, completion: { (Bool) in
                        
                        self.listImageView.alpha = 1
                })
            }
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
