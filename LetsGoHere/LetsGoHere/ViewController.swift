//
//  ViewController.swift
//  LetsGoHere
//
//  Created by Kahlil Yee on 11/4/19.
//  Copyright © 2019 Kahlil Yee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var findPlace: UIButton!
    
    @IBOutlet weak var favorite: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                     if (segue.identifier == "toTable")
                     {
                         let segueTo = segue.destination as! TableViewController
                        segueTo.getBool = false
                     }
        
        else if (segue.identifier == "toPrepare")
        {
            let segueTo = segue.destination as! PreferenceViewController
        }
                 }
    @IBAction func toHome(segue: UIStoryboardSegue)
    {
      
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

