//
//  ViewController.swift
//  FinalLabAssignment
//
//  Created by Anmol Sharma on 2020-01-24.
//  Copyright © 2020 anmol. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    @IBOutlet var txtProductID: UITextField!
    @IBOutlet var txtProductName: UITextField!
    @IBOutlet var txtProductPrice: UITextField!
    @IBOutlet var txtProductDesc: UITextView!
    static var id = 11
    var pid : Int = 0
    var pname = ""
    var pprice: Float = 0.0
    var pdesc = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
        
        
    }
    
    @IBAction func saveProduct(_ sender: Any) {
        saveTask()
    }
    
    func saveTask()
    {
        pid  = Int(txtProductID.text!)!
        pname = txtProductName.text!
        pprice = Float(txtProductPrice.text!)!
        pdesc = txtProductDesc.text
        //Setting up the app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        //creating context from the container
        let context = appDelegate.persistentContainer.viewContext
        let products = Products(context: context)
        products.productId = Int64(pid)
        products.productName = pname
        products.productPrice = Float(Int64(pprice))
        products.productDesc = pdesc
        do{
            try context.save()
            print("Data Saved")
            print(products)
        }catch let error as NSError{
            print("Error Could not save Data. \(error),\(error.userInfo)")
        }
    }
    
    func createData()
    {
        //First we create instance of app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        //now we will make the context from thgis container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //now we will create entity and new User records
        let userEntity = NSEntityDescription.entity(forEntityName: "Products", in: managedContext)
        
        //finally we will populate the data
        
        let product = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        product.setValue(1, forKey: "productId")
        product.setValue("Coffee", forKey: "productName")
        product.setValue(23.60, forKey: "productPrice")
        product.setValue("this is coffee", forKey: "productDesc")
        
        product.setValue(2, forKey: "productId")
        product.setValue("Ice Cream", forKey: "productName")
        product.setValue(2.60, forKey: "productPrice")
        product.setValue("this is Ice Cream", forKey: "productDesc")
        
        product.setValue(3, forKey: "productId")
        product.setValue("Tikki", forKey: "productName")
        product.setValue(5.90, forKey: "productPrice")
        product.setValue("this is Tikki", forKey: "productDesc")
        
        product.setValue(4, forKey: "productId")
        product.setValue("burger", forKey: "productName")
        product.setValue(3.20, forKey: "productPrice")
        product.setValue("this is burger", forKey: "productDesc")
        
        product.setValue(5, forKey: "productId")
        product.setValue("Subway", forKey: "productName")
        product.setValue(4.49, forKey: "productPrice")
        product.setValue("this is Subway", forKey: "productDesc")
        
        product.setValue(6, forKey: "productId")
        product.setValue("Coffee", forKey: "productName")
        product.setValue(23.60, forKey: "productPrice")
        product.setValue("this is coffee", forKey: "productDesc")
        
        product.setValue(7, forKey: "productId")
        product.setValue("Toffee", forKey: "productName")
        product.setValue(1.00, forKey: "productPrice")
        product.setValue("this is Toffee", forKey: "productDesc")
        
        product.setValue(8, forKey: "productId")
        product.setValue("chocolate", forKey: "productName")
        product.setValue(23.60, forKey: "productPrice")
        product.setValue("this is Chocolate", forKey: "productDesc")
        
        product.setValue(9, forKey: "productId")
        product.setValue("peanuts", forKey: "productName")
        product.setValue(23.60, forKey: "productPrice")
        product.setValue("this is peanuts", forKey: "productDesc")
        
        product.setValue(10, forKey: "productId")
        product.setValue("Coffee", forKey: "productName")
        product.setValue(9.30, forKey: "productPrice")
        product.setValue("this is coffee", forKey: "productDesc")
       
        //now we will save the data inside the core data
        do{
            try managedContext.save()
            print("Data Saved")
        }catch let error as NSError{
            print("Could not save.\(error),\(error.userInfo)")
        }
    }
}
