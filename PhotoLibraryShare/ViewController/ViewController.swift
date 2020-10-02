//
//  ViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 27.09.2020.
//

import UIKit
// ПОСЛЕ СОЗДАНИЯ МОДЕЛИ COREDATA И ОПРЕДЕЛЕНИЯ ИЗОБРАЖЕНИЯ КАК DATA BINARY - ПО ПРОЕКТУ ПРИДЕТСЯ ИСПРАВЛЯТЬ ОШИБКИ. УДАЛЯТЬ СОЗДАННЫЙ ФАЙЛ СО СТРУКТУТОРОЙ НАШИХ СВОЙСТВ. ИЗОБРАЖЕНИЯ, КОТОРЫЕ ИМЕЕЮТ ВИД UIImage(named: namefuture[indexPath.row].images) НУЖНО ПРИВОДИТЬ К ТАКОМУ ВИДУ: UIImage(data: namefuture[indexPath.row].images! as Data), ТАК КАК НАШИ ИЗОБРАЖЕНИЯ ИМЕЮТ ФОРМАТ BINARY DATA
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Table view data source
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    
    // MARK: - Table view data source
    @IBAction func UnwindSegue(segue: UIStoryboardSegue) {
        guard let svc = segue.source as? SecondViewController else { return } // делаем проверку, если иначе метод не сработает
        guard let rating = svc.restRating else { return } // делаем проверку 
        rateButton.setTitle(rating, for: .normal) // присваиваем заголовок нашей кнопке из нашей переменной
    }
    
    
    // MARK: - Table view data source
    var nameofsfuture: Namefuture! // создаем экземпляр класса! который находится в struct!
    
    
    // MARK: - Table view data source
    override func viewWillAppear(_ animated: Bool) { // создаем метод, который пишется до загрузки экрана, так как он стартует раньше. В методе мы прописываем свойство скрытия навбара.
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Table view data source
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons = [rateButton, mapButton] // cjplftv vfcсив кнопок
        for button in buttons { // cоздаем цикл
            guard let button = button else { break } // делаем проверку и помещаем нашу кнопку в созданую константу, затем уже отрисовываем рамку кнопоко
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
        }
        img.contentMode = .scaleAspectFill // растягиваем наше изображение
        img.clipsToBounds = true // свойство, которое ограничевает изображение нашими рамками экрана, то есть изображение будет граничить с экраном и не будет растягиваться, как будто граница у изображения где за пределами экрана
        img.image = UIImage(data: nameofsfuture.images! as Data)
        tableView.backgroundColor = .white
        tableView.separatorColor = .black // цвет разделителя в таблице
        tableView.tableFooterView = UIView(frame: CGRect.zero) //чтоб снизу нашей таблички не было никаких строк!
        title = nameofsfuture.name // делаем заголовок навбара по названию
        tableView.estimatedRowHeight = 38 // присваиваем высоту ячейки
        tableView.rowHeight = UITableView.automaticDimension // автоматическое опеределение высоты ячейки
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // возвращаем количество столбцов ячейки
        return 4
    }
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // метод, в котором мы настраиваем нашу ячейку!
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! SecondTableViewCell
        cell1.keyLabel.textColor = .black
        cell1.valueLabel.textColor = .black
        switch indexPath.row { // делаем конструкцию свитч, в которой мы проверяем, если наша строка равна 0 то в лейблах пишем ... и т д.
        case 0: cell1.keyLabel.text = "Имя"
            cell1.valueLabel.text = nameofsfuture.name
        case 1:
            cell1.keyLabel.text = "Тип"
            cell1.valueLabel.text = nameofsfuture.type
        case 2:
            cell1.keyLabel.text = "Адрес"
            cell1.valueLabel.text = nameofsfuture.location
        case 3:
            cell1.keyLabel.text = "Я был тут?"
            cell1.valueLabel.text = nameofsfuture.visited ? "Да" : "Нет"
        default:
            break
        }
        cell1.backgroundColor = .clear // делаем цвет заливки нашей ячейки прозрачной
        return cell1
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // метод, который работает при нажатии на ячейку, при выделении ячкейки
        tableView.deselectRow(at: indexPath, animated: true) // метод, который скрывает выделение ячейки после нажатия на саму ячейку
    }
    
    
    // MARK: - Table view data source
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // создаем метод сегвея
        if segue.identifier == "show3" {
            let dvc = segue.destination as? ThirdViewController
            dvc?.namefutures = self.nameofsfuture // передаем данные в наш созданный экземпляр класса из этого контроллера
        }
    }
}


