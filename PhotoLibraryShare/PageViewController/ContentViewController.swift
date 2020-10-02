//
//  ContentViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 30.09.2020.
//

import UIKit

class ContentViewController: UIViewController {
    
    
    // MARK: - @IBOUTLETS - ELEMENTS
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var button: UIButton!
    
    
    // MARK: - VAR, LET, ARRAY CONSTANT
    var header = ""  // создаем переменные для наших элементов, в которые мы будем складывать какие либо значения
    var subHeader = ""
    var imageFile = ""
    var index = 0
    
    
    // MARK: - METHOD VIEW DID LOAD
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
        
        
        // MARK: - CONSTRUCTION SWITCH FOR CONTENT VIEW CONTROLLER
        switch index { // рисуем конструкцию свитч в которой мы оторбражаем: если кейс индекса равен 0 то название кнопки меняем. Аналоично и для 1 индекса
        case 0: button.setTitle("Дальше", for: .normal)
        case 1: button.setTitle("Открыть", for: .normal)
        default: break
        }
    }
    
    
    // MARK: - @IBACTION METHOD
    @IBAction func actionButton(_ sender: UIButton) { // метод, в котором мы прописали конструкцию свитч: если индекс равен 0, то мы вызываем метод из PageViewController, которые меняет наш ContentViewController (экран). Если же индекс равен 1, то срабатываем метод, который закрывает наш ContentViewController
        switch index {
        case 0: let pageVC = parent as! PageViewController
            pageVC.nextVC(atIndex: index)
        case 1:
            let userDefaults = UserDefaults.standard // доступ к нашему хранилищу данных. Этот доступ будет предоставлять к данным, к конкретному значению: Просмотрел ли наш пользователь экран ContentViewController или нет, если просмотрел, то окно вызываться не будет
            userDefaults.set(true, forKey: "wasIntroWatch") // вываем метод, который сохраняет значения по ключу, в данном случае, если пользователь просмотрел ИНТРО, то значение будет true
            userDefaults.synchronize() // синхронизируем наши данные 
            dismiss(animated: true, completion: nil)
        default: break
        }
    }
}
