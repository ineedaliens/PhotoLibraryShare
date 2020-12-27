//
//  ThirdTableViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 29.09.2020.
//

import UIKit

class ThirdTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
   
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    
    
    var isVisited = false 
   
    
    
    @IBAction func toogleIsVisited(_ sender: UIButton) {
        if sender == yesButton { 
            sender.backgroundColor = .green
            noButton.backgroundColor = .gray
            isVisited = true
        } else {
            sender.backgroundColor = .red
            yesButton.backgroundColor = .gray
            isVisited = false
        }
    }
    
    
    
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) { 
        if textFields[0].text == "" || textFields[1].text == "" || textFields[2].text == "" {
            let allerMessage = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ОК", style: .default, handler: { _ in
            
            })
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            allerMessage.addAction(okAction)
            allerMessage.addAction(cancelAction)
            present(allerMessage, animated: true, completion: nil)
        } else {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext { 
                let Namefuture1 = Namefuture(context: context)
                Namefuture1.name = textFields[0].text
                Namefuture1.location = textFields[1].text
                Namefuture1.type = textFields[2].text
                Namefuture1.visited = isVisited
                if let image = imagePicker.image {
                    Namefuture1.images = image.jpegData(compressionQuality: 1.0) as Data? 
                }
                do {
                    try context.save()
                    print("Сохранение удалось!")
                } catch let error as NSError {
                    print("Не удалось сохранить данные \(error), \(error.userInfo)")
                }
            }
            
            performSegue(withIdentifier: "unwindSegueFromNew", sender: self) 
        }
    }
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        yesButton.backgroundColor = .green
        noButton.backgroundColor = .red
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage 
        imagePicker.contentMode = .scaleAspectFill
        imagePicker.clipsToBounds = true 
        dismiss(animated: true, completion: nil) 
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
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
    
    
   
    func chooseImagePickerAction (source: UIImagePickerController.SourceType) { 
        if UIImagePickerController.isSourceTypeAvailable(source) { 
            let imagePicker =  UIImagePickerController() 
            imagePicker.delegate = self 
            imagePicker.allowsEditing = true 
            imagePicker.sourceType = source 
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}
