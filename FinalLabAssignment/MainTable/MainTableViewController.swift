//
//  MainTableViewController.swift
//  FinalLabAssignment
//
//  Created by Anmol Sharma on 2020-01-24.
//  Copyright © 2020 anmol. All rights reserved.
//

import UIKit
import CoreData
class MainTableViewController: UITableViewController {
    var product : [Products] = []
    var p = Products()
    let tableCell = MainTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
           //getting data from core data
           retrieveTask()
           //reloading the data
       // deleteData()
           tableView.reloadData()
           //deleteData()
       }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return product.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        let productdetail = product[indexPath.row]
        cell.productID.text = "Id : \(String(productdetail.productId))"
        cell.productName.text = "Name : \(productdetail.productName ?? "")"
        cell.productPrice.text = "Price : \(String(productdetail.productPrice))$"
        cell.pdesc.text =  "\(productdetail.productDesc ?? "No Description")"
        
        

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete {
            let pro = product[indexPath.row]
            context.delete(pro)
            print("Deleted the task")
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do
            {
                product = try context.fetch(Products.fetchRequest())
            }
            catch let error as NSError{
                print("Error in deleting the data. \(error),\(error.userInfo)")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    //*************************
    
   //retrieve Contact
       func retrieveTask()
       {
           
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
           
           let Context = appDelegate.persistentContainer.viewContext
           
           
           
           do{
               product = try Context.fetch(Products.fetchRequest() )
               print("Data Successfully retrieved")
           }
           catch let error as NSError{
               print("Error Could not save Data. \(error),\(error.userInfo)")
           }
           
       }
    
    func deleteData()
       {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           
           let context = appDelegate.persistentContainer.viewContext
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")
           fetchRequest.returnsObjectsAsFaults = false
           do{
               let results = try context.fetch(fetchRequest)
               
               for managedObjects in results{
                   if let managedObjectsData = managedObjects as? NSManagedObject
                   {
                       context.delete(managedObjectsData)
                    
                   }
                   
               }
            try context.save()
           }
           catch let error as NSError{
               print("Error Could not save Data. \(error),\(error.userInfo)")
           }
       }
    
     func deleteTask()
        {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
            let predicate = NSPredicate(format: "productId = %@", "\(p.productId)")
    //        tArray = try context.fetch(Tasks.fetchRequest())
           fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = predicate
            if let result = try? context.fetch(fetchRequest)
            {
                for i in result
                {
                   print(i)
                    context.delete(i as! NSManagedObject)
                    print("Task Deleted")
                    print(i)
                }
            }
            do{
                try context.save()
            }
            catch let error as NSError
            {
                print("Error Could not save Data. \(error),\(error.userInfo)")
            }
        }
    

}
