//
//  ThirdViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 28.09.2020.
//

import UIKit
import MapKit
// ПОСЛЕ СОЗДАНИЯ МОДЕЛИ COREDATA И ОПРЕДЕЛЕНИЯ ИЗОБРАЖЕНИЯ КАК DATA BINARY - ПО ПРОЕКТУ ПРИДЕТСЯ ИСПРАВЛЯТЬ ОШИБКИ. УДАЛЯТЬ СОЗДАННЫЙ ФАЙЛ СО СТРУКТУТОРОЙ НАШИХ СВОЙСТВ. ИЗОБРАЖЕНИЯ, КОТОРЫЕ ИМЕЕЮТ ВИД UIImage(named: namefuture[indexPath.row].images) НУЖНО ПРИВОДИТЬ К ТАКОМУ ВИДУ: UIImage(data: namefuture[indexPath.row].images! as Data), ТАК КАК НАШИ ИЗОБРАЖЕНИЯ ИМЕЮТ ФОРМАТ BINARY DATA
class ThirdViewController: UIViewController, MKMapViewDelegate {
    
    
    // MARK: - Table view data source
    var namefutures: Namefuture!
    
    
    // MARK: - Table view data source
    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: - Table view data source
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self // наш класс будет реализовывать методы делегата!
        
        
        // MARK: - Table view data source
        let geocoder = CLGeocoder() // позволяет из текста (адрес) вывести координаты
        geocoder.geocodeAddressString(namefutures.location!, completionHandler: { (placemarks, error) in // метод, в который передаем нашу локацию и пишем кложер
            guard error == nil else {return} // делаем проверку, если наша ошибка не нил то прерываем
            guard let placemarks = placemarks else {return} // проверка
            
            let placemark = placemarks.first! // извлекаем из массива первый жлемент
            
            let annotation = MKPointAnnotation() // делаем нотацию для нашей координаты
            annotation.title = self.namefutures.name
            // annotation.subtitle = self.namefutures.type
            
            guard let location = placemark.location else {return} // если такого адреса нет, то выполнение прерывается
            annotation.coordinate = location.coordinate // если координаты доступны то мы присваиваем в нашу переменую
            self.mapView.showAnnotations([annotation], animated: true) // вызываем метод, который принимает нашу анотацию в качестве координад, которые мы нашли
            self.mapView.selectAnnotation(annotation, animated: true) // метод который разворачивает нашу аннотацию
        })
        
    }
    
    
    // MARK: - Table view data source
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {return nil} // проверка на наше местоположение
        
        let annotationIdentifier = "restAnnotation" // Создаем идентификатор для метода, который снизу
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView// метод, который переиспользует нашу аннотацию. Аналогично работает как и ячейкой в тейблВью. И кастим наше переиспользованный идентификатор до класса ПИНАннотатионВью ( чтоб была видна иголочка и облачко с информацией!)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true // это свойство позволяет отображать дополнительную информацию о нашей аннотации
        }
        let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) // создали рамку, в которую будем помещшать нашу аннотацию
        rightImage.image = UIImage(data: namefutures.images! as Data) // сюда мы передаем наше изображение из структуры
        annotationView?.rightCalloutAccessoryView = rightImage // в правую часть аннотации мы помешаем нашу картинку
        annotationView?.pinTintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) // делаем цвет иголки другим
        return annotationView // возвращаем наш аннотатионвью
    }
    
}
