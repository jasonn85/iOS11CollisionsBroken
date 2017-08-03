//
//  ViewController.swift
//  CollisionBreaker
//
//  Created by Jason Neel on 8/3/17.
//  Copyright © 2017 Zingle. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    var fallingSquare: UIView?
    
    var animator: UIDynamicAnimator!
    
    @IBOutlet weak var greenFlash: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        animator = UIDynamicAnimator(referenceView: view)
    }
    
    @IBAction func pressedButton(_ sender: Any) {
        // Remove any previous falling thinger
        animator.removeAllBehaviors()
        fallingSquare?.removeFromSuperview()
        
        fallingSquare = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0))
        fallingSquare?.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        let myCenter = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        fallingSquare!.center = myCenter
        
        view.addSubview(fallingSquare!)
        
        let collisionBehavior = UICollisionBehavior(items: [fallingSquare!])
        collisionBehavior.collisionMode = .boundaries
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self
        
        let gravity = UIGravityBehavior(items: [fallingSquare!])
        
        animator.removeAllBehaviors()
        animator.addBehavior(collisionBehavior)
        animator.addBehavior(gravity)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print("It worked!")
        
        // Remove the square
        UIView.animate(withDuration: 0.25, animations: {
            self.fallingSquare?.alpha = 0.0
        }) { (_: Bool) in
            self.fallingSquare?.removeFromSuperview()
        }
        
        // Flash green
        UIView.animate(withDuration: 0.25, animations: {
            self.greenFlash.alpha = 1.0
        }) { (_: Bool) in
            UIView.animate(withDuration: 0.75) {
                self.greenFlash.alpha = 0.0
            }
        }
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        print("Item to item contact began.  This is unexpected.")
    }
}

