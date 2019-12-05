//
//  TableViewController.swift
//  LetsGoHere
//
//  Created by Kahlil Yee on 11/4/19.
//  Copyright © 2019 Kahlil Yee. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var getLong:String?
    var getBool:Bool?
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
    var together = ""
    var thebool = false
    @IBOutlet weak var addingButton: UIBarButtonItem!
    @IBOutlet weak var establishmentTable: UITableView!
    
   var counter = 1
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //this is the array to store Establishment entities from the coredata
    var   fetchResults =   [Establishment]()
    
    func fetchRecord() -> Int {
        // Create a new fetch request using the Establishment
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Establishment")
        var counting   = 0
        // Execute the fetch request, and cast the results to an array of Establishment objects
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [Establishment])!
        
        
        counting = fetchResults.count
        
        // return howmany entities in the coreData
        return counting
        
        
    }
    
    override func viewDidLoad() {
        loc = getLong ?? "Not Available"
        loc2 = getLat ?? "Not Available"
        interest = getInterest ?? "Not Available"
        theName = getName ?? "Not Available"
        addy1 = getAddress1 ?? "Not Available"
        addy2 = getAddress2 ?? "Not Available"
        addy3 = getAddress3 ?? "Not Available"
        addy4 = getAddress4 ?? "Not Available"
        thebool = getBool ?? true
        together = (addy1 + " " + addy2 + " " + addy3 + " " + addy4)
        initCounter()
        updateLastRow()
        if thebool == false
        {
            addingButton.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // number of rows based on the coredata storage
        return fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // add each row from coredata fetch results
        let perfectCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        perfectCell.layer.borderWidth = 1.0
        perfectCell.textLabel?.text = fetchResults[indexPath.row].name
        perfectCell.detailTextLabel?.text = fetchResults[indexPath.row].location1
        
        if let thePic = fetchResults[indexPath.row].image {
            perfectCell.imageView?.image =  UIImage(data: thePic  as Data)
        } else {
            perfectCell.imageView?.image = nil
        }
        
        return perfectCell
    }
    
    // delete table entry
    // this method makes each row editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    // return the table view style as deletable
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    
    // implement delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == .delete
        {
            
            // delete the selected object from the managed
            // object context
            managedObjectContext.delete(fetchResults[indexPath.row])
            // remove it from the fetch results array
            fetchResults.remove(at:indexPath.row)
            
            do {
                // save the updated managed object context
                try managedObjectContext.save()
            } catch {
                
            }
            // reload the table after deleting a row
            establishmentTable.reloadData()
        }
        
    }
    
    
    @IBAction func adding(_ sender: Any) {
      
          // create a new entity object
          let ent = NSEntityDescription.entity(forEntityName: "Establishment", in: self.managedObjectContext)
          //add to the manege object context
          let newItem = Establishment(entity: ent!, insertInto: self.managedObjectContext)
          newItem.name = theName
          newItem.location1 = loc
          newItem.location2 = loc2
          newItem.image = nil
        newItem.fInterest = interest
        newItem.location3 = together
          
          // one more item added
          updateCounter()
          
          
          
          // show the alert controller to select an image for the row
          let alertController = UIAlertController(title: "Add Establishment", message: "", preferredStyle: .alert)
          
          let searchAction = UIAlertAction(title: "Picture Library", style: .default) { (aciton) in
              // load image
              let photoPicker = UIImagePickerController ()
              photoPicker.delegate = self
              photoPicker.sourceType = .photoLibrary
              // display image selection view
              self.present(photoPicker, animated: true, completion: nil)
              
          }
         let pictureAction = UIAlertAction(title: "Camera", style: .default) { (aciton) in
        //            create a constant that is equal to the UIImagePickerController ()
                    let picker = UIImagePickerController ()
                    picker.delegate = self
        //            if have access to camera do the following
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        picker.sourceType = .camera
                        picker.allowsEditing = false
                        picker.sourceType = UIImagePickerController.SourceType.camera
                        picker.cameraCaptureMode = .photo
                        picker.modalPresentationStyle = .fullScreen
                        self.present(picker, animated: true, completion: nil)
                           } else {
        //                else print no access to camera
                               print("No camera")
                    }}
          
          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
          }
          
          alertController.addAction(searchAction)
          alertController.addAction(pictureAction)
          alertController.addAction(cancelAction)
          
          self.present(alertController, animated: true, completion: nil)
          // save the updated context
          do {
              try self.managedObjectContext.save()
          } catch _ {
          }
          
        establishmentTable.reloadData()
         }
         
         func updateLastRow() {
             let indexPath = IndexPath(row: fetchResults.count - 1, section: 0)
             establishmentTable.reloadRows(at: [indexPath], with: .automatic)
         }
         
         
         func initCounter() {
             counter = UserDefaults.init().integer(forKey: "counter")
         }
         
         func updateCounter() {
             counter += 1
             UserDefaults.init().set(counter, forKey: "counter")
             UserDefaults.init().synchronize()
         }
         
         
         @IBAction func deleteAll(_ sender: UIBarButtonItem) {
             
             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Establishment")
             
             // whole fetchRequest object is removed from the managed object context
             let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
             do {
                 try managedObjectContext.execute(deleteRequest)
                 try managedObjectContext.save()
                 
                 
             }
             catch let _ as NSError {
                 // Handle error
             }
             
             establishmentTable.reloadData()
         }
         
         func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
             
             picker .dismiss(animated: true, completion: nil)

             if let Ven = fetchResults.last, let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                 Ven.image = image.pngData()! as Data
                 //update the row with image
                 updateLastRow()
                 do {
                     try managedObjectContext.save()
                 } catch {
                     print("Error while saving the new image")
                 }
                 
             }
             
         }
                override func didReceiveMemoryWarning() {
                    super.didReceiveMemoryWarning()
                    // Dispose of any resources that can be recreated.
                }
    
             override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                 if (segue.identifier == "toDetail")
                 {
                    //        created a constant that will hold the selected row
                    let selectedIndex: IndexPath = self.establishmentTable.indexPath(for: sender as! UITableViewCell)!
                    //           created a constant that will hold the object in the selected row
                    let theVen = fetchResults[(selectedIndex.row)]
                    let segueTo = segue.destination as! DetailViewController
                    segueTo.getName = theVen.name
                     segueTo.getLat = theVen.location1
                     segueTo.getLong = theVen.location2
                    segueTo.getImage = theVen.image
                    segueTo.getInterest = theVen.fInterest
                    segueTo.getAddress = theVen.location3
                 }
                 else{
                    let segueTo = segue.destination as! ViewController
                }
             }
         
         
     }

