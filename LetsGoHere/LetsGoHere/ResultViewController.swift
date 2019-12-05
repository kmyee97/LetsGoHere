//
//  ResultViewController.swift
//  LetsGoHere
//
//  Created by Kahlil Yee on 11/4/19.
//  Copyright © 2019 Kahlil Yee. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ResultViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var theTitle: UILabel!
    var pic: Data? = nil
    var getLong:String?
    var getLat:String?
    var getName:String?
    var getInterest:String?
    var getAddress1:String?
    var getAddress2:String?
    var getAddress3:String?
    var getAddress4:String?
    var loc = ""
    var loc2 = ""
    var interest = ""
    var theName = ""
    var addy1 = ""
    var addy2 = ""
    var addy3 = ""
    var addy4 = ""
    
    override func viewDidLoad() {
    super.viewDidLoad()
        loc = getLong!
        loc2 = getLat!
        interest = getInterest!
        theName = getName!
        addy1 = getAddress1!
        addy2 = getAddress2!
        addy3 = getAddress3!
        addy4 = getAddress4!
        theTitle.text = "How was " + theName
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if (segue.identifier == "toTable")
              {
                let segueTo = segue.destination as! TableViewController
                  segueTo.getName = theName
                  segueTo.getLat = loc2
                  segueTo.getLong = loc
                  segueTo.getInterest = interest
               segueTo.getAddress1 = addy1
               segueTo.getAddress2 = addy2
               segueTo.getAddress3 = addy3
               segueTo.getAddress4 = addy4
              }
        else
              {
                let segueTo = segue.destination as! ViewController
        }
          }
}
