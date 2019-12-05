//
//  DetailViewController.swift
//  LetsGoHere
//
//  Created by Kahlil Yee on 11/4/19.
//  Copyright © 2019 Kahlil Yee. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class DetailViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var theTitle: UILabel!
    @IBOutlet weak var theInterest: UILabel!
    @IBOutlet weak var theLocation: UILabel!
    @IBOutlet weak var theMap: MKMapView!
    @IBOutlet weak var theImage: UIImageView!
    var getImage:Data?
    var getLong:String?
    var getBool:Bool?
    var getLat:String?
    var getName:String?
    var getInterest:String?
    var getAddress:String?
    var loc = ""
    var loc2 = ""
    var interest = ""
    var theName = ""
    var addy = ""
    override func viewDidLoad() {
    super.viewDidLoad()
        loc = getLong!
        loc2 = getLat!
        interest = getInterest!
        theName = getName!
        addy = getAddress!
        theTitle.text = theName
        theInterest.text = "Food Interest: " + interest
        theLocation.text = addy
        theImage.image = UIImage(data: getImage!)
        var lon : CLLocationDegrees = Double(loc2)!
        
        var lat : CLLocationDegrees = Double(loc)!
        
        var coords = CLLocationCoordinate2D( latitude: lat, longitude: lon)
        var span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        var region: MKCoordinateRegion = MKCoordinateRegion.init(center: coords, span: span)
        
        self.theMap.setRegion(region, animated: true)
        
        // add an annotation
        let marker = MKPointAnnotation()
        marker.coordinate = coords
        marker.title = theName
        
        self.theMap.addAnnotation(marker)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
