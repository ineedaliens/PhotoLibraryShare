//
//  ThirdTableViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 29.09.2020.
//

import UIKit
// ПОСЛЕ СОЗДАНИЯ МОДЕЛИ COREDATA И ОПРЕДЕЛЕНИЯ ИЗОБРАЖЕНИЯ КАК DATA BINARY - ПО ПРОЕКТУ ПРИДЕТСЯ ИСПРАВЛЯТЬ ОШИБКИ. УДАЛЯТЬ СОЗДАННЫЙ ФАЙЛ СО СТРУКТУТОРОЙ НАШИХ СВОЙСТВ. ИЗОБРАЖЕНИЯ, КОТОРЫЕ ИМЕЕЮТ ВИД UIImage(named: namefuture[indexPath.row].images) НУЖНО ПРИВОДИТЬ К ТАКОМУ ВИДУ: UIImage(data: namefuture[indexPath.row].images! as Data), ТАК КАК НАШИ ИЗОБРАЖЕНИЯ ИМЕЮТ ФОРМАТ BINARY DATA
class ThirdTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // MARK: - @IBOUTLETS - ELEMENTS
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    
    // MARK: - VAR, LET, ARRAY CONSTANT
    var isVisited = false // создаем свойсвто
   
    
    // MARK: - @IBACTION METHOD TOOGLE IS VISITED
    @IBAction func toogleIsVisited(_ sender: UIButton) {
        if sender == yesButton { // создаем условие по которому будет меняться цвет заливки кнопки в зависимости от нажатой кнопки
            sender.backgroundColor = .green
            noButton.backgroundColor = .gray
            isVisited = true
        } else {
            sender.backgroundColor = .red
            yesButton.backgroundColor = .gray
            isVisited = false
        }
    }
    
    
    // MARK: - @IBACTION METHOD SAVE BAR BUTTON IN NAVIGATION BAR FOR SAVE USER DATA THROW CONTEXT
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) { // экшн для нашей кнопки сохранить
        if textFields[0].text == "" || textFields[1].text == "" || textFields[2].text == "" {
            let allerMessage = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ОК", style: .default, handler: { _ in
            
            })
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            allerMessage.addAction(okAction)
            allerMessage.addAction(cancelAction)
            present(allerMessage, animated: true, completion: nil)
        } else {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext { // получаем констекст из (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext - выражение постоянное
                let Namefuture1 = Namefuture(context: context)
                Namefuture1.name = textFields[0].text
                Namefuture1.location = textFields[1].text
                Namefuture1.type = textFields[2].text
                Namefuture1.visited = isVisited
                if let image = imagePicker.image { // создаем константу в которую кладем изображение
                    Namefuture1.images = image.jpegData(compressionQuality: 1.0) as Data? // пофиксил ошибку таким способом
                }
                do {
                    try context.save()
                    print("Сохранение удалось!")
                } catch let error as NSError {
                    print("Не удалось сохранить данные \(error), \(error.userInfo)")
                }
            }
            
            performSegue(withIdentifier: "unwindSegueFromNew", sender: self) // делаем переход обратно к основному экрану
        }
    }
    
    
    // MARK: - METHOD VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        yesButton.backgroundColor = .green
        noButton.backgroundColor = .red
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    
    // MARK: - TABLE METHOD NUMBER OF SECTIONS
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // MARK: - TABLE METHOD NUMBER OF ROWS IN SECTION
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    // MARK: - METHOD IMAGE PICKER CONTROLLER FOR IMAGE PICKER
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage // кастим изображение из UIImage
        imagePicker.contentMode = .scaleAspectFill
        imagePicker.clipsToBounds = true // фотография будет обрезана по рамкам
        dismiss(animated: true, completion: nil) // пропуск
    }
    
    
    // MARK: - TABLE METHOD DID SELECT ROW AT
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // создаем метод выделения ячейки, по которой будет вызываться акшионшит с выбором действий
        if indexPath.row == 0 {
            let allertController = UIAlertController(title: "Выбор фотографии", message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Камера", style: .default, handler: { _ in
                self.chooseImagePickerAction(source: .camera)
            })
            let selectPhoto = UIAlertAction(title: "Выбрать из галереии", style: .default, handler: {_ in
                self.chooseImagePickerAction(source: .photoLibrary)
            })
            let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            allertController.addAction(camera)
            allertController.addAction(selectPhoto)
            allertController.addAction(cancel)
            present(allertController, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - METHOD CHOOSE IMAGE PICKER ACTION FOR IMAGE PICKER
    func chooseImagePickerAction (source: UIImagePickerController.SourceType) { //создаем метод, который будет позволять выбирать фотографии в зависимости от выбора, или снимать на камеру или выбирать из галереии
        if UIImagePickerController.isSourceTypeAvailable(source) { // проверяем есть ли у нас доступ к камере или доступ к галерее
            let imagePicker =  UIImagePickerController() //делаем экземпляр класса
            imagePicker.delegate = self // указываем, что переменная является делегатом
            imagePicker.allowsEditing = true // вызываемое свойство позволяет редактировать фотки, увеличивать масштаб или обрезать!
            imagePicker.sourceType = source // На этой строке мы попадаем либо на камеру либо в галерею
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}
