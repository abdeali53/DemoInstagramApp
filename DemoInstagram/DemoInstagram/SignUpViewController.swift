//
//  SignUpViewController.swift
//  DemoInstagram
//
//  Created by Kane Denzil Quadras Bernard on 2018-04-01.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    // this is your database variable - it lets you access and manipulate the CoreData db
    let myContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    // data source --> array of Category objects
    var users = [User]()
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var txtDescibe: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
self.hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        if(txtPassword.text != txtConfirmPassword.text){
            print("Alert Password should match")
        }
        if(txtUsername.text != "" && txtPassword.text != ""){
            let user = User(context: self.myContext)
            
            // set the name of the category
            user.username = txtUsername.text
            user.password = txtPassword.text
            user.describe = txtDescibe.text
            // add the Category to the categories array
            self.users.append(user)
            // save the data and reload the table view
            self.saveData()
            UserDefaults.standard.set(txtUsername.text, forKey: "loginUser")
            UserDefaults.standard.set(txtPassword.text, forKey: "loginPassword")
            print("Data Saved")

        }
    }
    func saveData() {
        do {
            try myContext.save()
            print("=====================Save Data===============")
        }
        catch {
            print("An error occured: \(error)")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
