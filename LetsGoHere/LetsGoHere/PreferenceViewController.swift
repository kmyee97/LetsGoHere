//
//  PreferenceViewController.swift
//  LetsGoHere
//
//  Created by Kahlil Yee on 11/4/19.
//  Copyright © 2019 Kahlil Yee. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class PreferenceViewController: UIViewController, CLLocationManagerDelegate {
    var manager:CLLocationManager!
    @IBOutlet weak var locationInfo: UITextField!
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var proceeding: UIButton!
    @IBOutlet weak var interestInfo: UITextField!
    var names: [String] = []
    var latt: [String] = []
    var longi: [String] = []
    var thePlaces:places = places()
    override func viewDidLoad() {
        super.viewDidLoad()
        proceedBtn.isHidden = true
    }
    @IBAction func getMyLoc(_ sender: Any) {
        manager = CLLocationManager()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
          manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    class func LocationEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                print("Error")
                return false
            }
        } else {
            print("Please enable your location services")
            return false
        }
    }
    
    //NOTE: [AnyObject] changed to [CLLocation]
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations TheLocation: [CLLocation]) {
        
        let userLoc:CLLocation = TheLocation[0]
        
        lat.text = "\(userLoc.coordinate.latitude)"
        locationInfo.text = "\(userLoc.coordinate.longitude)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueTo = segue.destination as! MapViewController
        if (segue.identifier == "toMap")
        {
            let item = thePlaces.getDict()
//            print(item.count)
//            print(thePlaces.places)
//            let counting = thePlaces.getCount()
//            print(counting)
//            print(names)
            segueTo.getInfo = item as NSDictionary
            segueTo.getLong = locationInfo.text
            segueTo.getLat = lat.text
            segueTo.getInterest = interestInfo.text
        }
    }

    
    
    @IBAction func testing(_ sender: Any) {
        thePlaces.places.removeAll()
        DispatchQueue.main.async(execute: {
            self.getAPIData()})
        proceedBtn.isHidden = false
        }
        
        
        func getAPIData() {
            let gettingInterest = interestInfo.text!
            let loc1 = locationInfo.text!
            let loc2 = lat.text!
            let data = gettingInterest.filter { !$0.isWhitespace }
            let urlAsString = "https://api.foursquare.com/v2/venues/search?client_id=20CNZ5OMAZEWN4AANPI2ES5YLSWKGJKSX4UE3OCBGHHCY5UJ&client_secret=UHLEPAKC4WRX3ZP23J1UDEVKGZD31GIGDZ4R0TAPUEFWBHZD&v=20191117&ll=\(loc2),\(loc1)&query=\(data)&radius=8046.72"
                       
                       let url = URL(string: urlAsString)!
                       let urlSession = URLSession.shared
                       
                       let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                           if (error != nil) {
                               print(error!.localizedDescription)
                           }
                        var err: NSError?
                        
                        
                        var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                        if (err != nil) {
                            print("JSON Error \(err!.localizedDescription)")
                        }
                        let setOne = jsonResult as? [String: Any]
                        let resp = setOne!["response"] as! NSDictionary
                        let ven = resp["venues"]! as! NSArray
//                        let theVen = ven[0] as? [String: Any]
//                        let name = theVen!["name"]
//                        print(name!)
//                        let coords = theVen!["location"] as? NSDictionary
//                        let coord1 = coords!["lat"]
//                        let coord2 = coords!["lng"]
//                        print(coord1!)
//                        print(coord2!)
                        for i in 0..<ven.count{
                            let theVen = ven[i] as? [String: Any]
                            var name = theVen!["name"]
                            print(name!)
                            let coords = theVen!["location"] as? NSDictionary
                            let coord1 = coords!["lat"]
                            let coord2 = coords!["lng"]
                            let ad = coords!["address"]
                            let zipcode = coords!["postalCode"]
                            let city = coords!["city"]
                            let st = coords!["state"]
                            print(coord1!)
                            print(coord2!)
                            var lat = "\(coord1!)"
                            var lng = "\(coord2!)"
                            self.thePlaces.add(name as! String, lat, lng, i, ad as? String ?? "Not Available", zipcode as? String ?? "Not Available", city as? String ?? "Not Available", st as? String ?? "Not Available")
                            self.names.append(name as! String)
                            self.latt.append(lat)
                            self.longi.append(lng)
                        }
                   })
            jsonQuery.resume()
}
}
