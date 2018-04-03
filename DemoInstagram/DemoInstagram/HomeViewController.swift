//
//  HomeViewController.swift
//  DemoInstagram
//
//  Created by Kane Denzil Quadras Bernard on 2018-04-02.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//

import UIKit
import CoreData


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableViewPost.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        cell.setCellDetails(post: posts[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "postDetails", sender: indexPath.row)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewPost.reloadData()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "postDetails"){
            print(segue.destination)
            if let destination = segue.destination as? ViewPostViewController {
                
                destination.post = posts[(self.tableViewPost.indexPathForSelectedRow?.row)!]
                //            destination.user = users[0]
            }
        }
        
        }
        
    
    // this is your database variable - it lets you access and manipulate the CoreData db
    let myContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // data source --> array of Category objects
    var users = [User]()
    var posts = [Post]()
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var tableViewPost: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        
        let username = UserDefaults.standard.value(forKey: "loginUser") as! String
        let password = UserDefaults.standard.value(forKey: "loginPassword") as! String
        loadData(username:username, password: password)
        loadPostData(comment: "")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnSearch(_ sender: UIButton) {
        loadPostData(comment: txtSearch.text!)
        self.tableViewPost.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func loadPostData(comment : String){
        let request : NSFetchRequest<Post> = Post.fetchRequest()
        if(comment != ""){
            request.predicate = NSPredicate(format: "comment CONTAINS[cd] %@", txtSearch.text!)
        }
        do {
            posts = try myContext.fetch(request)
            //            print("===================Login Data===============",users.count)
        }
        catch {
            print("An error occured: \(error)")
        }
    }
    func loadData(username:String, password:String) {
        let request : NSFetchRequest<User> = User.fetchRequest()
        
        request.predicate = NSPredicate(format: "username == %@ && password == %@", username, password)
        
        do {
            users = try myContext.fetch(request)
//            print("===================Login Data===============",users.count)
        }
        catch {
            print("An error occured: \(error)")
        }
    }

}
