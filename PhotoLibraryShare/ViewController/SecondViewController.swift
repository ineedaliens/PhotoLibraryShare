//
//  SecondViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 28.09.2020.
//

import UIKit
// ПОСЛЕ СОЗДАНИЯ МОДЕЛИ COREDATA И ОПРЕДЕЛЕНИЯ ИЗОБРАЖЕНИЯ КАК DATA BINARY - ПО ПРОЕКТУ ПРИДЕТСЯ ИСПРАВЛЯТЬ ОШИБКИ. УДАЛЯТЬ СОЗДАННЫЙ ФАЙЛ СО СТРУКТУТОРОЙ НАШИХ СВОЙСТВ. ИЗОБРАЖЕНИЯ, КОТОРЫЕ ИМЕЕЮТ ВИД UIImage(named: namefuture[indexPath.row].images) НУЖНО ПРИВОДИТЬ К ТАКОМУ ВИДУ: UIImage(data: namefuture[indexPath.row].images! as Data), ТАК КАК НАШИ ИЗОБРАЖЕНИЯ ИМЕЮТ ФОРМАТ BINARY DATA
class SecondViewController: UIViewController {
    
    
    // MARK: - Table view data source
    @IBOutlet weak var imgs1: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var GoodButton: UIButton!
    @IBOutlet weak var BrilliantButton: UIButton!
    
    
    
    // MARK: - Table view data source
    var restRating: String? // создаем переменную в которую мы будем складывать наши значения кнопок
    
    
    // MARK: - Table view data source
    @IBAction func sendName(sender: UIButton) { // наш экшн по нажатию на кнопку будет передаваться то или иной значение, в зависимости которое нажали
        switch sender.tag {
        case 0: restRating = "😕"
        case 1: restRating = "🙂"
        case 2: restRating = "😍"
        default: break
        }
        performSegue(withIdentifier: "close", sender: sender)
    }
    
    
    // MARK: - Table view data source
    override func viewDidAppear(_ animated: Bool) { // метод, который срабатывает только после того как загрузится приложение и загрузится экран
        //        UIView.animate(withDuration: 0.4, animations: { // настраиваем анимацию
        //                        self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)}) // если значения 1.0 то это значит, что это реальный размер
        
        let buttonArray = [badButton, GoodButton, BrilliantButton] // создаем массив кнопок
        
        for (index, button) in buttonArray.enumerated() {
            let delay = Double(index) * 0.2 // делай наших кнопок, индекс первой кнопки равен 0, то в делей будет 0, индекс второй будет 0.2 и т д
            UIView.animate(withDuration: 0.3, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { // настраиваем анимацию
                button?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0) // собственно сама анимация, которая увеличвивается до реальных  размеров
            }, completion: nil)
        }
    }
    
    
    // MARK: - Table view data source
    override func viewDidLoad() {
        super.viewDidLoad()
        badButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        GoodButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        BrilliantButton.transform = CGAffineTransform(scaleX: 0, y: 0) // настраиваем позицию нашего стаквью. То есть, анимация заклюается в том, что сначала наш стек не имеет размера и он при загрузке экрана в 0 позиции, то есть его нет на экране вообще. Потом срабатывает наш метод, и происходит анимация увеличения до реального размера нашего стэквью
        let blurEffect = UIBlurEffect(style: .light) // создаем константу блюреффект
        let blurEffectView =  UIVisualEffectView(effect: blurEffect) // создаем еще одну конснту где прописываем наш созданный блюрэффект
        blurEffectView.frame = self.view.bounds // указываем фрейм
        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth] // закрепляем наш блюр эффект Ю чтоб во всех ориентациях было одинаково
        self.view.insertSubview(blurEffectView, at: 1) // добавляем блюр на наш вью
    }
  }
