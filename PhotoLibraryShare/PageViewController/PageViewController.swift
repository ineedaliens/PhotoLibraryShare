//
//  PageViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 30.09.2020.
//

import UIKit

class PageViewController: UIPageViewController {
    
    
   
    var headerArray = ["Фотографируйте","Находите"]
    var subHeadersArray = ["Создайте список своих любимых фотографий с разных уголков планеты","Находите и отмечайте на карте места, в которых вы были"]
    var imagesArray = ["logo", "unnamed"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstViewController = displayController(atIndex: 0) {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil) 
        }
    }
    
    
    
    func displayController(atIndex Index: Int) -> ContentViewController? { 
        guard Index >= 0 else { return nil }
        guard Index < headerArray.count else { return nil }
        guard let contentViewController = storyboard?.instantiateViewController(identifier: "contentViewController") as? ContentViewController else { return nil } 
        contentViewController.imageFile = imagesArray[Index] 
        contentViewController.header =  headerArray[Index] 
        contentViewController.subHeader = subHeadersArray[Index] 
        contentViewController.index = Index 
        
        return contentViewController
    }
    
    
    func nextVC(atIndex index: Int ) {
        if let contenVC = displayController(atIndex: index + 1) {
            setViewControllers([contenVC], direction: .forward, animated: true, completion: nil)
        }
    }
}



extension PageViewController: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index 
        index -= 1 
        return displayController(atIndex: index) 
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index 
        index += 1 
        return displayController(atIndex: index) 
    }
    
    
}
