//
//  NearByFriendViewController.swift
//  DemoInstagram
//
//  Created by MacStudent on 2018-04-02.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NearByFriendViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    //Class Variable
    var nearByFriends = [NearByFriend]()
    //Getting Data From Seague
    var userFriends = [Friend]()
    
    
    @IBOutlet weak var mapView: MKMapView!
    var manager : CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
print("==============Friend=========",userFriends.count)
        
        
        // set up your CoreLocation manager variable
        
        // 1. intialize our core location variable
        manager = CLLocationManager()
        manager.delegate = self
        
        // 2. tell your phone how accurate you want the location to be
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 3. Ask the user for permission to get their location
        manager.requestAlwaysAuthorization()
        
        // 4. Get the user's actual position
        manager.startUpdatingLocation()
        
        
        // Setup your map to show stuff
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        mapView.showsUserLocation = true
        // Do any additional setup after loading the view.

        loadFriend()
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // get the most recent position
       
        
        // ui nonsense - update the map
        // to show the proper zoom level
        
        let coordinate = mapView.userLocation.coordinate
        print("=============Latitude=========",coordinate.latitude)
        print("=============Longitude=========",coordinate.longitude)
        let span = MKCoordinateSpanMake(50, 50)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        
        let myLocation = locations.last
        
        for nearByFriend in nearByFriends {
            let myBuddysLocation = CLLocation(latitude: nearByFriend.lat!, longitude: nearByFriend.long!)
            let distance = (myLocation?.distance(from: myBuddysLocation))! / 100
            nearByFriend.distance = distance
        }
        
    // Sort Data by distance
       let newNearBY = nearByFriends.sorted(by: {$0.distance ?? 0.0 < $1.distance ?? 0.0})
       
        for (item,nearByFriend) in newNearBY.enumerated() {
            if(item<5){
            print("============New Nearby Friend=========", nearByFriend.distance!)
            
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(nearByFriend.lat!, nearByFriend.long!)
            pin.title = nearByFriend.name
            self.mapView.addAnnotation(pin)
            }
        }
        
        mapView.setRegion(region, animated: true)
        
        
    }
    func loadFriend()  {
        for friend in userFriends {
            
            let nearByFriend = NearByFriend(name: friend.name!, lat: friend.latitude, long: friend.longitude, distance: 0.00)
            nearByFriends.append(nearByFriend)
        }
    }
    

}

class NearByFriend {
    var name: String?
    var lat : Double?
    var long : Double?
    var distance : Double? = 0.00
    
    init(name : String, lat : Double, long : Double, distance : Double) {
        self.name = name
        self.lat = lat
        self.long = long
        self.distance = distance
    }
}
