//
//  ViewController.swift
//  Lekcija3
//
//  Created by Students on 06/03/2019.
//  Copyright © 2019 students. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, ThirdViewControllerDelegate {


    var locationManager = CLLocationManager()
    var sumtingwong = [[String]]()
    
    
    @IBOutlet weak var myTextView: UITextField!
    
    
    @IBOutlet weak var Controler: MKMapView!
    var mansTexts = "Nav teksts ievadīts"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            Controler.showsUserLocation = true
            let Valmiera = MKPointAnnotation()
            Valmiera.coordinate = CLLocationCoordinate2D(latitude: 57.535067, longitude: 25.424228)
            Controler.addAnnotation(Valmiera)
            let Sigulda = MKPointAnnotation()
            Sigulda.coordinate = CLLocationCoordinate2D(latitude: 57.143337, longitude: 24.854284)
            Controler.addAnnotation(Sigulda)
            let Saulkrasti = MKPointAnnotation()
            Saulkrasti.coordinate = CLLocationCoordinate2D(latitude: 57.268759, longitude: 24.426470)
            Controler.addAnnotation(Saulkrasti)
            print("Console actually works!!!")
            
            
            
            
            locationManage()
            
        }
       
    }
    func ArrayUpdated(newArray: [[String]]) {
        for row in newArray {
            let loc = MKPointAnnotation()
            if let latt = Double(row[0]), let longg = Double(row[1]) {
                loc.coordinate = CLLocationCoordinate2D(latitude: latt, longitude: longg)
                Controler.addAnnotation(loc)
                print("This row: " + row[0])
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewAdd", let vc = segue.destination as? ThirdViewController{
            vc.delegate = self
        }
        
        if segue.identifier == "toFilterView" {
            if let secondViewController = segue.destination as? SecondViewController {
                secondViewController.mansTextsNoMainVC = mansTexts
            }
        }
  
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        for row in sumtingwong {
            let loc = MKPointAnnotation()
            if let latt = Double(row[0]), let longg = Double(row[1]) {
                loc.coordinate = CLLocationCoordinate2D(latitude: latt, longitude: longg)
                Controler.addAnnotation(loc)
                print("This row: " + row[0])
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations =\(locValue.latitude)\(locValue.longitude)")
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 105000,  longitudinalMeters: 135000)
        self.Controler.setRegion(viewRegion, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        renderer.lineWidth = 2
        return renderer
    }
    
    func locationManage(){
  
        Controler.delegate = self

        let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 57.529617 , longitude: 25.42035))
        let source = MKMapItem(placemark: sourcePlaceMark)
        let directionRequest = MKDirections.Request()

        directionRequest.source = source
        
        
        let destinationPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 57.268759, longitude: 24.426470))
        let destinationMapItem = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        let directions = MKDirections(request: directionRequest)
        directions.calculate {response, error in
            if let route = response?.routes.first{
                self.Controler.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            }
        }
    }
    
   
    
    func Controler(_ Controler: MKMapView, viewFor annotation: MKAnnotation)-> MKAnnotationView?{
        
        
        guard annotation is MKPointAnnotation else {return nil}
        let identifier = "Annotation"
        var annotationView = Controler.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        }else{
            annotationView!.annotation = annotation
        }
        return annotationView
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        mansTexts = myTextView.text ?? "Nav ievadīts"
        
        
        
    }

    @IBAction func LoadArray(_ sender: UIButton) {
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toViewAdd" {
//            if let thirdViewController = segue.destination as? ThirdViewController {
//                thirdViewController.mansTextsNoMainVC = mansTexts
//            }
//        }
//    }
}

