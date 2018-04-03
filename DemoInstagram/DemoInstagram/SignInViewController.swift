//
//  SignInViewController.swift
//  DemoInstagram
//
//  Created by Kane Denzil Quadras Bernard on 2018-04-01.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//

import UIKit
import CoreData
class SignInViewController: UIViewController {

    var username: String = ""
    var isRememberCredential : Bool = false
    var password: String = ""
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var switchRemember: UISwitch!
    
    // this is your database variable - it lets you access and manipulate the CoreData db
    let myContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // data source --> array of Category objects
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
             self.navigationItem.hidesBackButton = true
        self.tabBarController?.tabBar.isHidden = true
        
        switchRemember.isOn = checkIsRememberCredential()
        
        if switchRemember.isOn == true {
            self.username = UserDefaults.standard.value(forKey: "username") as! String
            
            self.password = UserDefaults.standard.value(forKey: "password") as! String
            
            txtUsername.text = username
            txtPassword.text = password
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnSignIn(_ sender: UIButton) {
        
        self.username = txtUsername.text!
        self.password = txtPassword.text!
        
        print(self.username,self.password)
        
        
        if switchRemember.isOn{
            addCredentials(email: self.username,password: self.password, isRemember: true)
            
        }
            
        else{
            
            removeCredentials(isRemember: false)
            
        }
        loadData(username: self.username, password: self.password)
        if(users.count != 0)
        {
            print("User Found")
            UserDefaults.standard.set(self.username, forKey: "loginUser")
            UserDefaults.standard.set(self.password, forKey: "loginPassword")
        }
        else{
            print("No User Found")
        }
        print("Success to VC")
        
       self.performSegue(withIdentifier: "signInToTabbarVC", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func checkIsRememberCredential() -> Bool {
        
        if let rememberCredential = UserDefaults.standard.value(forKey: "isRememberCredential"){
            
            isRememberCredential = rememberCredential as! Bool
            
        }
        
        return isRememberCredential
        
    }
    
    
    
    func addCredentials(email:String,password:String,isRemember:Bool) {
        
        UserDefaults.standard.set(email, forKey: "username")
        
        UserDefaults.standard.set(password, forKey: "password")
        
        
        UserDefaults.standard.set(isRemember, forKey: "isRememberCredential")
        
    }
    
    
    
    func removeCredentials(isRemember:Bool) {
        
        UserDefaults.standard.removeSuite(named: "username")
        
        UserDefaults.standard.removeSuite(named: "password")
        
        UserDefaults.standard.set(isRemember, forKey: "isRememberCredential")
        
    }
    
    
    
    // --- Core Data functions ----- //
    
    func loadData(username:String, password:String) {
        let request : NSFetchRequest<User> = User.fetchRequest()
        print("======================UserName=================",username)
        print("======================UserName=================",password)
        
        request.predicate = NSPredicate(format: "username == %@ && password == %@", username, password)
        
        do {
            users = try myContext.fetch(request)
            print("===================data===============",users.count)
        }
        catch {
            print("An error occured: \(error)")
        }
    }


}
