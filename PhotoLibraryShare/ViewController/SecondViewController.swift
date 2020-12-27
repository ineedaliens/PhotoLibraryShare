//
//  SecondViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 28.09.2020.
//

import UIKit

class SecondViewController: UIViewController {
    
    
 
    @IBOutlet weak var imgs1: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var GoodButton: UIButton!
    @IBOutlet weak var BrilliantButton: UIButton!
    
    
    
  
    var restRating: String?
    
    
    
    @IBAction func sendName(sender: UIButton) { 
        switch sender.tag {
        case 0: restRating = "😕"
        case 1: restRating = "🙂"
        case 2: restRating = "😍"
        default: break
        }
        performSegue(withIdentifier: "close", sender: sender)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) { 
        //        UIView.animate(withDuration: 0.4, animations: { 
        //                        self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)}) 
        
        let buttonArray = [badButton, GoodButton, BrilliantButton] 
        
        for (index, button) in buttonArray.enumerated() {
            let delay = Double(index) * 0.2 
            UIView.animate(withDuration: 0.3, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { 
                button?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0) 
            }, completion: nil)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        badButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        GoodButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        BrilliantButton.transform = CGAffineTransform(scaleX: 0, y: 0) 
        let blurEffect = UIBlurEffect(style: .light) 
        let blurEffectView =  UIVisualEffectView(effect: blurEffect) 
        blurEffectView.frame = self.view.bounds 
        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth] 
        self.view.insertSubview(blurEffectView, at: 1) 
    }
  }
