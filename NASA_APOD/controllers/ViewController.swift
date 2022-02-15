//
//  ViewController.swift
//  NASA_APOD
//
//  Created by Tharani on 15/02/22.
//

import UIKit
import CoreData
import SystemConfiguration

class ViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var lastUpdatedLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!

    var nasaInfoModel : [NASA_Table]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        self.activityIndicator.hidesWhenStopped = true
        if currentReachabilityStatus == .notReachable {
            // Network Unavailable
            retrieveData { success in
            
                if let nasaInfoModel = self.nasaInfoModel {
                    let image = UIImage(data: nasaInfoModel[0].imageData!)
                    self.updateUI(title: nasaInfoModel[0].title!, date: nasaInfoModel[0].date!, explanation: nasaInfoModel[0].descriptions!, image: image!, lastUpdateDate: nasaInfoModel[0].lastUpdateDate!)
                }
            }
           
        } else {
            // Network Available
            NASAAPIClient.getDataFromAPI { (nasaData) in
           
                NASAAPIClient.downloadImage(at: nasaData.url, completion: { (success, image, imageData) in
                  
                  if success == true {
                      
                      print("got image data from URL")
                     
                      self.updateUI(title: nasaData.title, date: nasaData.date, explanation: nasaData.explanation, image: image!, lastUpdateDate: Date.now)
                      self.saveDataToCoreData(nasa: nasaData, imageData: imageData!)
                  } else {
                      print ("Error getting image")
                  }
          
                  
              })
              
              }
        }
    }

    func updateUI(title: String, date: String, explanation: String, image: UIImage, lastUpdateDate: Date) {
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
            self.dateLbl.text = date
            self.titleLbl.text = title
            self.descriptionLbl.text = explanation
            self.lastUpdatedLbl.text = "Last Synced Time: \(lastUpdateDate.formatted())"
        }
        
    }
    
    func saveDataToCoreData(nasa: NASAModel, imageData: Data) {
        deleteData()
        DispatchQueue.main.async {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;

        let nasaEntity = NSEntityDescription.entity(forEntityName: "NASA_Table", in: context)!
        let nasaTable = NSManagedObject(entity: nasaEntity, insertInto: context)
        
        nasaTable.setValue(nasa.date, forKeyPath: "date")
        nasaTable.setValue(nasa.explanation, forKey: "descriptions")
        nasaTable.setValue(nasa.title, forKey: "title")
        nasaTable.setValue(Date.now, forKey: "lastUpdateDate")
        nasaTable.setValue(imageData, forKey: "imageData")
        // save on the context
        do {
            try context.save()
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        }
    }
    
    func retrieveData(completion: @escaping  (Bool) -> Void) {
        DispatchQueue.main.async {
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            do {
                self.nasaInfoModel = try managedContext.fetch(NASA_Table.fetchRequest())
                completion(true)
            }  catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        }
    
    
    func deleteData() {
        DispatchQueue.main.async {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            if let result = try? context.fetch(NASA_Table.fetchRequest()) {
                for object in result {
                    context.delete(object)
                }
            }
            do {
                try context.save()
            } catch {
                //Handle error
            }
        }
    }
}

