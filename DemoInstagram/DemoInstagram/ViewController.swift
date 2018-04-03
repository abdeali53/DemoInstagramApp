//
//  ViewController.swift
//  DemoInstagram
//
//  Created by Kane Denzil Quadras Bernard on 2018-04-01.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    // this is your database variable - it lets you access and manipulate the CoreData db
    let myContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // data source --> array of Category objects
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func saveData() {
        do {
            try myContext.save()
        }
        catch {
            print("An error occured: \(error)")
        }
    }

}

