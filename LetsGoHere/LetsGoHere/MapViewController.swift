//
//  MapViewController.swift
//  LetsGoHere
//
//  Created by Kahlil Yee on 11/4/19.
//  Copyright © 2019 Kahlil Yee. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var noEntry: UILabel!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var goHere: UIButton!
    @IBOutlet weak var findingPlace: UIButton!
    @IBOutlet weak var theMap: MKMapView!
    var usedNums: [Int] = []
    var getInfo = NSDictionary()
    var getInterest:String?
    var temp1: String!
    var temp2: String!
    var temp3: String!
    var temp4: String!
    var temp5: String!
    var lastNum:Int?
    var getLong:String?
    var getLat:String?
    var item: [Int:placerecord]?
var loc = ""
    var loc2 = ""
    var displayedLoc = ""
    var displayedLoc2 = ""
var interest = ""
    var establishmentDic:places = places()
        override func viewDidLoad() {
            super.viewDidLoad()
            lastNum = -1
            noEntry.isHidden = true
            emptyLabel.isHidden = true
            messageLabel.isHidden = true
            goHere.isHidden = true
            item = getInfo as! [Int : placerecord]
            loc = getLong!
            loc2 = getLat!
            interest = getInterest!
            var lon : CLLocationDegrees = Double(loc)!
            
            var lat : CLLocationDegrees = Double(loc2)!
            
            var coords = CLLocationCoordinate2D( latitude: lat, longitude: lon)
            var span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
            
            var region: MKCoordinateRegion = MKCoordinateRegion.init(center: coords, span: span)
            
            self.theMap.setRegion(region, animated: true)
            
            // add an annotation
            let pointer = MKPointAnnotation()
            pointer.coordinate = coords
            pointer.title = "You"
            
            self.theMap.addAnnotation(pointer)
            if (item!.count == 0)
            {
                emptyToBeginWith()
            }
            }

            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
    
    @IBAction func finding(_ sender: Any) {
        var randomInt = 0
        if (lastNum != -1)
        {
            removingAnnotation()
        }
        if usedNums.count == item!.count{
            findingPlace.isHidden = true
            emptyLabel.isHidden = false
        }
        else {
            randomInt = Int.random(in: 0..<item!.count)
            while usedNums.contains(randomInt)
            {
                randomInt = Int.random(in: 0..<item!.count)
            }
        }
        lastNum = randomInt
        let latt = item![randomInt]?.lat
        let long = item![randomInt]?.long
        displayedLoc = latt!
        displayedLoc2 = long!
        var lon : CLLocationDegrees = Double(long!)!
        var lat : CLLocationDegrees = Double(latt!)!
                   
        var coords = CLLocationCoordinate2D( latitude: lat, longitude: lon)
        var span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
                   
        var region: MKCoordinateRegion = MKCoordinateRegion.init(center: coords, span: span)
                   
        self.theMap.setRegion(region, animated: true)
                   
                   // add an annotation
        let mark = MKPointAnnotation()
        mark.coordinate = coords
        mark.title = item![randomInt]?.name
        temp1 = "\(item![randomInt]!.name!)"
        temp2 = "\(item![randomInt]!.addy!)"
        temp3 = "\(item![randomInt]!.zip!)"
        temp4 = "\(item![randomInt]!.city!)"
        temp5 = "\(item![randomInt]!.state!)"
        messageLabel.text = temp1 + "\n \(interest) \n" + temp2 + " " + temp3 + " " + temp4 + " " + temp5
        messageLabel.isHidden = false
        goHere.isHidden = false
        self.theMap.addAnnotation(mark)
        usedNums.append(randomInt)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let segueTo = segue.destination as! ResultViewController
           if (segue.identifier == "toResult")
           {
               segueTo.getName = temp1
               segueTo.getLat = displayedLoc
               segueTo.getLong = displayedLoc2
               segueTo.getInterest = interest
            segueTo.getAddress1 = temp2
            segueTo.getAddress2 = temp3
            segueTo.getAddress3 = temp4
            segueTo.getAddress4 = temp5
           }
       }
    func emptyToBeginWith(){
        noEntry.isHidden = false
        findingPlace.isHidden = true
        
    }
    func removingAnnotation()
    {
        for annotation in self.theMap.annotations {
            let theName = item![lastNum!]?.name
            if let title = annotation.title, title == theName {
                self.theMap.removeAnnotation(annotation)
            }
        }
    }
    
}
