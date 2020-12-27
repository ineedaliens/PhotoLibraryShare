//
//  ContentViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 30.09.2020.
//

import UIKit

class ContentViewController: UIViewController {
    
    
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var button: UIButton!
    
    
    
    var header = ""  
    var subHeader = ""
    var imageFile = ""
    var index = 0
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = header
        subHeaderLabel.text = subHeader
        imageHeader.image = UIImage(named: imageFile)
        imageHeader.contentMode = .scaleAspectFill
        imageHeader.clipsToBounds = true
        pageControll.numberOfPages = 2
        pageControll.currentPage = index
        pageControll.backgroundColor = .gray
        pageControll.tintColor = .white
        pageControll.pageIndicatorTintColor = .black
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.backgroundColor = .white
        button.layer.borderColor = (#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).cgColor
        
        
        
        switch index {
        case 0: button.setTitle("Дальше", for: .normal)
        case 1: button.setTitle("Открыть", for: .normal)
        default: break
        }
    }
    
    
    
    @IBAction func actionButton(_ sender: UIButton) { 
        switch index {
        case 0: let pageVC = parent as! PageViewController
            pageVC.nextVC(atIndex: index)
        case 1:
            let userDefaults = UserDefaults.standard 
            userDefaults.set(true, forKey: "wasIntroWatch") 
            userDefaults.synchronize() 
            dismiss(animated: true, completion: nil)
        default: break
        }
    }
}
