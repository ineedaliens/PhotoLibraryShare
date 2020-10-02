//
//  PageViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 30.09.2020.
//

import UIKit

class PageViewController: UIPageViewController {
    
    
    // MARK: - VAR, LET, ARRAY CONSTANT
    var headerArray = ["Фотографируйте","Находите"]
    var subHeadersArray = ["Создайте список своих любимых фотографий с разных уголков планеты","Находите и отмечайте на карте места, в которых вы были"]
    var imagesArray = ["logo", "unnamed"]
    
    
    // MARK: - METHOD VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstViewController = displayController(atIndex: 0) {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil) // Метод позволяет загружать наш ViewController
        }
    }
    
    
    // MARK: - METHOD DISPLAY CONTROLLER FOR PAGE CONTROLLER
    func displayController(atIndex Index: Int) -> ContentViewController? { //создаем метод, которые будет возвращать контентвьюконтроллер
        guard Index >= 0 else { return nil }
        guard Index < headerArray.count else { return nil }
        guard let contentViewController = storyboard?.instantiateViewController(identifier: "contentViewController") as? ContentViewController else { return nil } // делаем проверку и делаем передачу данных в наш ContentViewController , а также кастим до ContentViewController
        contentViewController.imageFile = imagesArray[Index] // передаемданные с этого контроллера в ContentViewController и кладем в нашу переменную там
        contentViewController.header =  headerArray[Index] // передаемданные с этого контроллера в ContentViewController и кладем в нашу переменную там
        contentViewController.subHeader = subHeadersArray[Index] // передаемданные с этого контроллера в ContentViewController и кладем в нашу переменную там
        contentViewController.index = Index // передаемданные с этого контроллера в ContentViewController и кладем в нашу переменную там
        
        return contentViewController
    }
    
    // MARK: - METHOD NEXT VIEW CONTROLLER FOR PAGE VIEW CONTROLLER
    func nextVC(atIndex index: Int ) {
        if let contenVC = displayController(atIndex: index + 1) {
            setViewControllers([contenVC], direction: .forward, animated: true, completion: nil)
        }
    }
}


// MARK: - EXTENSION PAGE VIEW CONTROLLER AND HIS METHODS
extension PageViewController: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index // получаем индекс из ContentViewController (переменная)
        index -= 1 // устанавливаем index -= 1
        return displayController(atIndex: index) // возвращаем наш метод, который возрващает индекс
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index // получаем индекс из ContentViewController (переменная)
        index += 1 // устанавливаем index += 1
        return displayController(atIndex: index) // возвращаем наш метод, который возрващает индекс
    }
    
    
}
