//
//  TableViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 27.09.2020.
//

import UIKit
import CoreData
// ПОСЛЕ СОЗДАНИЯ МОДЕЛИ COREDATA И ОПРЕДЕЛЕНИЯ ИЗОБРАЖЕНИЯ КАК DATA BINARY - ПО ПРОЕКТУ ПРИДЕТСЯ ИСПРАВЛЯТЬ ОШИБКИ. УДАЛЯТЬ СОЗДАННЫЙ ФАЙЛ СО СТРУКТУТОРОЙ НАШИХ СВОЙСТВ. ИЗОБРАЖЕНИЯ, КОТОРЫЕ ИМЕЕЮТ ВИД UIImage(named: namefuture[indexPath.row].images) НУЖНО ПРИВОДИТЬ К ТАКОМУ ВИДУ: UIImage(data: namefuture[indexPath.row].images! as Data), ТАК КАК НАШИ ИЗОБРАЖЕНИЯ ИМЕЮТ ФОРМАТ BINARY DATA
class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    // MARK: - VAR, LET, ARRAY CONSTANT
    var fetchResultsController: NSFetchedResultsController<Namefuture>! // создаем переменную класса! <> угловые скобки обозначают, что это ДЖЕНЕРИК
    var searchController: UISearchController!
    var filteredResultArray: [Namefuture] = [] // создаем пустой массив, который будет отвечать критериям поиска
    var namessoffuture: [Namefuture] = []
    //    namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "1", visited: false), // создаем экземпляр нашей структуры, и делаем массив, в котором уже прописываем все наши свойства.
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "2", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "3", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "4", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "5", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "6", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "7", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "8", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "9", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "10", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "11", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "12", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "13", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "14", visited: false),
    //                                        namefuture(name: "Наталия", type: "Фотография", location: "г. Тюмень ул. Николая Семенова 31", images: "15", visited: false),
    //
    //    ]
    
    
    // MARK: - @IBACTION METHOD
    @IBAction func close(segue: UIStoryboardSegue) {
    }
    
    
    // MARK: - METHOD VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    
    // MARK: - METHOD FILTER CONTENT FOR UI SEARCH BAR IN TABLE VIEW CONTROLLER
    func filterContentFor( searchText text: String){ // метод нужен для того чтоб отфильтровать массив и поместить его в новый массив
        filteredResultArray = namessoffuture.filter( { (Namefuture) -> Bool in // мы помещаем в этот жлемент только те элементы, которые содержат тотже самый текст, что и в поисковом запросе
            return (Namefuture.name?.lowercased().contains(text.lowercased()))! }) // сравниваются символы: если текст написан большими буквами, становится маленькими буквами потом берется поисковой запрос, принудительно записанный маленькими буквами и сравнивается содержит ли имя поля ту фразу которую мы вводим Ю если содержится то возвращается true b попадает в переменную
    }
    
    
    // MARK: - METHOD VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - Table view data source
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil ,action: nil) // обращаемся к элементы нашего навбара, присваем к классу и устаналиваем новыезначения! 
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        // MARK: - Table view data source
        searchController = UISearchController(searchResultsController: nil) // создаем серчконтроллер , нил указаываем для того чтобы результаты поиска на главном экране
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false // при поиске какого либо запроса будет затемняться контроллер , поэтому выставляем в false
        tableView.tableHeaderView = searchController.searchBar // присваиваем в шапку нашей таблички СЕРЧБАР !
        searchController.delegate = self // подписываемся под делегат
        definesPresentationContext = true // свойство которое не позволяет серчбару переходить на другой контроллер
        searchController.searchBar.backgroundColor = .white // делаем цвет заливки нашего серчбара
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.tintColor = .black
    
        
        // MARK: - CONTEXT SAVE FOR SEARCH BAR
        let fetchRequest: NSFetchRequest<Namefuture> = Namefuture.fetchRequest() // создаем переменную, которая получает запрос на данные , которые мы можем получать в любом порядке !
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true) // создаем дескриптор, которые будет сортировать данные по полю и возрастанию
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext { // создаем опять же обращение
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            
            do { // пытаемся получить данные
                try fetchResultsController.performFetch()
                namessoffuture =  fetchResultsController.fetchedObjects! // если все успешно, то полученные данные сохраняются в массив
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    
    // MARK: - METHOD VIEW DID APPEAR
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let userDefaults = UserDefaults.standard // доступ к хранилищу
        let wasIntroWhatch = userDefaults.bool(forKey: "wasIntroWatch") // создаем константу, которую присваиваем к методу, который обозначает наш ключ
        guard !wasIntroWhatch else { return } // если у нас значение false то мы продолжаем смотреть ИНТРО, если значение true то выходим из ИНТРО
        if let pageViewController = storyboard?.instantiateViewController(identifier: "pageViewController") as? PageViewController { // хотим иметь доступ ко всем свойствам этого контроллера, поэтому кастим до PageViewController
            present(pageViewController, animated: true, completion: nil)
            
        }
    }
    
    
    // MARK: - FETCH RESULT CONTROLLER DELEGATE
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) { // метод
        tableView.beginUpdates() // вызываем метол, который будет делать обновление нашего табл, для того чтобы не перезагружать целиком наш проект // предупреждаем наш теблювью что мы вносим череду изменений
    }
    
    
    // MARK: - METHOD CONTROLLER FOR ARRAY ACTIONS
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) { // в этом методе мы прописываем все случаи, которые могут возникнуть с нашим массивом, то есть, это удаление, обновление, и добавление новых элементов в наш массив
        switch type {
        case .insert: guard let indexPath = newIndexPath else { break }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete: guard let indexPath = indexPath else {break}
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update: guard let indexPath = indexPath else {break}
            tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
        namessoffuture = controller.fetchedObjects as! [Namefuture]
    }
    
    
    // MARK: - METHOD CONTROLLER DID CHANGE CONTENT
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) { // а в этом методе мы говорим, что череда изменений закончилась
        tableView.endUpdates()
    }
    
    
    // MARK: - TABLE METHOD NUMBER OF SECTION
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1 // возвращаем количество столбцов
    }
    
    
    // MARK: - TABLE METHOD NUMBER OF ROWS IN SECTION
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" { // переделали возвращаемое число элементов в массиве. Теперь по условию: если у нас активно окно поиска и текст серч контроллера не равен пустой строке, то возврашается число элементов массива filteredResultArray, иначе возвращается число элементов namessoffuture
            return filteredResultArray.count // возвращаем количество элементов в массиве
        }
        return namessoffuture.count
    }
    
    
    // MARK: - METHOD NAMES TO DISPlAY FOR SEARCH BAR
    func namesToDisplay(indexPath: IndexPath) -> Namefuture {
        let namefuture: Namefuture // создаем константу в которую мы будем передавать значение либо с одного массива , либо с другого
        if searchController.isActive && searchController.searchBar.text != "" { // создаем условие, если у нас активно окно поиска и текст серч контроллера не равен пустой строке, то мы берем данные из массива filteredResultArray, иначе мы берем данные из нашего массива namessoffuture
            namefuture = filteredResultArray[indexPath.row]
        } else {
            namefuture = namessoffuture[indexPath.row]
        }
        return namefuture
    }
    
    
    // MARK: - TABLE METHOD CELL FOR ROW AT INDEX PATH
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell // явно обращаемся к нашему таблвьюселл
        let namefuture = namesToDisplay(indexPath: indexPath)
        cell.amageView.image = UIImage(data: namefuture.images! as Data) // обращаемся к нашему имейджвью, который создан в таблвьюселл и присваиваем наш массив с изображениями
        cell.amageView.layer.cornerRadius = 32.5 // выставляем у нашего имейджвью закругление углов
        cell.amageView.clipsToBounds = true // делает ограничение для изображения по границам ячейки
        cell.nameLabel.text = namefuture.name // обаращаемся к нашему лейблу и присваиваем наш массив с указанием пути индекса строк и названия свойства
        cell.locationLabel.text = namefuture.location
        cell.typeLabel.text = namefuture.type
        
        cell.accessoryType = namefuture.visited ? .checkmark : .none // тернарный оператор
        return cell // возврвщаем ячейку
    }
    
    
    // MARK: - TABLE METHOD DID SELECT ROW AT
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // метод, который предполагает действие нажатия на выбранную ячейку
    //        let ac = UIAlertController(title: nil, message: "Позвони", preferredStyle: .actionSheet) // создаем алерт
    //        let isvisitedTitle = self.visited[indexPath.row] ?  "Снять отметку" : "Отметить" // тернарный оператор
    //        let cancel = UIAlertAction(title: isvisitedTitle, style: .cancel, handler: { _ in let cell = tableView.cellForRow(at: indexPath) // в методе мы можем создать клоужер с созданием еще одного аллерта !
    //            self.visited[indexPath.row] = !self.visited[indexPath.row] // противоположное действие
    //            cell?.accessoryType = self.visited[indexPath.row] ? .checkmark : .none // тернарное выражение чекмарка,
    //        })
    //        let call = UIAlertAction(title: "Вызов", style: .default, handler: {_ in let ab = UIAlertController(title: "Невозможно сделать вызов", message: "Попробуйте еще раз", preferredStyle: .alert)
    //            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
    //            ab.addAction(ok)
    //            self.present(ab, animated: true, completion: nil)
    //        })
    //        ac.addAction(cancel)
    //        ac.addAction(call)
    //        present(ac, animated: true, completion: nil)
    //        tableView.deselectRow(at: indexPath, animated: true) // вызываем метод, который убирает выделение выбранной ячейки
    //    }
    
    
    // MARK: - TABLE METHOD COMMIT EDITING STYLE
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // метод, который позволяет по свайпу влево вывести доп.действия по удалению ячейки из нанего тэйблвью
        if editingStyle == .delete { // если едитингстайл = удален, то удаляем из нашего массива строку
            self.namessoffuture.remove(at: indexPath.row)
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext { // создаем контекст
                let objectToDelete = self.fetchResultsController.object(at: indexPath) // создаем константу обджект ту делит
                context.delete(objectToDelete)
                do {                        // пытаемся передать удаление
                    try context.save()
                } catch {
                    print(error.localizedDescription) // в случае если не получится выпадет ошибка
                }
            } // если едитингстайл = удален, то удаляем из нашего массива строку
            //            self.images.remove(at: indexPath.row)// если едитингстайл = удален, то удаляем из нашего массива строку
        }
        //        tableView.reloadData() // метод, который перезагружает нашу таблицу
        //        tableView.deleteRows(at: [indexPath], with: .fade) // метод, который удаляет выбранную строку ( с указанием пути индекса)
    }
    //    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UIContextualAction]? {
//            let share = UIContextualAction(style: .normal, title: "Поделиться", handler: { _,_,_  in let defaultText = "Я сейчас в состоянии" + self.namessoffuture[indexPath.row].name!
    //            if let  image1 = UIImage(data: self.namessoffuture[indexPath.row].images! as Data) {
    //                let activityController = UIActivityViewController(activityItems: [defaultText, image1], applicationActivities: nil)
    //                self.present(activityController, animated: true, completion: nil)
    //            }
    //        })
    //        let delete = UIContextualAction(style: .normal, title: "Удалить", handler: { _,_,_   in self.namessoffuture.remove(at: indexPath.row)
    //            self.namessoffuture.remove(at: indexPath.row)
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
    //                let objectToDelete = self.fetchResultsController.object(at: indexPath)
    //                context.delete(objectToDelete)
    //                do {
    //                    try context.save()
    //                } catch {
    //                    print(error.localizedDescription)
    //                }
    //            }
    //            })
    //        share.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
    //        delete.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    //        return [delete, share]
    //    }
    
    
    // MARK: - METHOD PREPARE FOR SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let vlc =  segue.destination as! ViewController
                vlc.nameofsfuture = namesToDisplay(indexPath: indexPath) // передаем контректный элемент массива
            }
        }
    }
}


// MARK: - EXTENSION FOR TABLE VIEW CONTROLLER WITH METHODS
extension TableViewController: UISearchResultsUpdating { // делаем расширение нашего контроллера и подписываемся под протокол!
    func updateSearchResults(for searchController: UISearchController) { // метод, который вызывается в любой момент, когда хочешь изменить поисковый запрос!
        filterContentFor( searchText: searchController.searchBar.text!) // в методе указываем свойства 
        tableView.reloadData() // перезагружаем нашу таблицу
    }
    
}


// MARK: - Table view data source
extension TableViewController: UISearchControllerDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == ""{
            navigationController?.hidesBarsOnSwipe = false
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        navigationController?.hidesBarsOnSwipe = true
    }
}
