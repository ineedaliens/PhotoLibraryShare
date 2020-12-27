//
//  ThirdViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 28.09.2020.
//

import UIKit
import MapKit

class ThirdViewController: UIViewController, MKMapViewDelegate {
    
    
   
    var namefutures: Namefuture!
    
    
   
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self 
        
        
        
        let geocoder = CLGeocoder() 
        geocoder.geocodeAddressString(namefutures.location!, completionHandler: { (placemarks, error) in 
            guard error == nil else {return} 
            guard let placemarks = placemarks else {return} 
            
            let placemark = placemarks.first! 
            
            let annotation = MKPointAnnotation() 
            annotation.title = self.namefutures.name
            // annotation.subtitle = self.namefutures.type
            
            guard let location = placemark.location else {return} 
            annotation.coordinate = location.coordinate 
            self.mapView.showAnnotations([annotation], animated: true) 
            self.mapView.selectAnnotation(annotation, animated: true) 
        })
        
    }
    
    
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {return nil} 
        
        let annotationIdentifier = "restAnnotation" 
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true 
        }
        let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) 
        rightImage.image = UIImage(data: namefutures.images! as Data) 
        annotationView?.rightCalloutAccessoryView = rightImage 
        annotationView?.pinTintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) 
        return annotationView 
    }
    
}
