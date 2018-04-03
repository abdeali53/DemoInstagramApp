//
//  ProfileViewController.swift
//  DemoInstagram
//
//  Created by Kane Denzil Quadras Bernard on 2018-04-02.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("==========Call Collection=======", posts.count)
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell1", for: indexPath) as! CollectionViewCell
        if(posts[indexPath.row].postimage != nil){
            cell.setCellView(image: posts[indexPath.row].postimage!)
            
        }
        return cell
    }

    
    @IBOutlet weak var txtDescribe: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var txtUsername: UILabel!
    @IBOutlet weak var btnFriend: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let myContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var users = [User]()
    var posts = [Post]()
    var userFriends =  [Friend]()
    
    let username = UserDefaults.standard.value(forKey: "loginUser") as! String
    let password = UserDefaults.standard.value(forKey: "loginPassword") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Make profile pic circular
//        profilePhoto.layer.borderWidth = 1
//        profilePhoto.layer.masksToBounds = false
//        profilePhoto.layer.borderColor = UIColor.lightGray.cgColor
//        profilePhoto.layer.cornerRadius = profilePhoto.frame.height/2
//        profilePhoto.clipsToBounds = true
        //Load user
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;


        collectionView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadData(username:username, password: password)
        if(users.count != 0){
            txtUsername.text = users[0].username
            if(users[0].describe != ""){
                txtDescribe.text = users[0].describe
            }
        }
        self.loadData()
        self.addFriend()
        btnFriend.setTitle("Friends (" + String(userFriends.count) + ")", for: .normal)
        collectionView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findNearByFriend(_ sender: UIButton) {
        performSegue(withIdentifier: "nearByFriend", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewImageDetails", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "viewImageDetails"){
        print(segue.destination)
        if let destination = segue.destination as? ViewPostViewController {
            
            destination.post = posts[sender as! Int]
//            destination.user = users[0]
            }
        }
        if(segue.identifier == "nearByFriend"){
            if let destination = segue.destination as? NearByFriendViewController {
                destination.userFriends = self.userFriends
                
            }
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
    func loadData(username:String, password:String) {
        let request : NSFetchRequest<User> = User.fetchRequest()
//        print("======================UserName=================",username)
//        print("======================UserName=================",password)
        
        request.predicate = NSPredicate(format: "username == %@ && password == %@", username, password)
        do {
            users = try myContext.fetch(request)
            print("===================Login Data===============",users.count)
        }
        catch {
            print("An error occured: \(error)")
        }
    }
    
    func loadData() {
        let request : NSFetchRequest<Post> = Post.fetchRequest()
        let predicate = NSPredicate(format: "postUser == %@", users[0].objectID)
        request.predicate = predicate
        do {
            posts = try myContext.fetch(request)
            print("===================Post Data===============",posts.count)
        }
        catch {
            print("An error occured: \(error)")
        }
    }
    
  // Friends Auto AddAn
    func addFriend(){
        let request : NSFetchRequest<Friend> = Friend.fetchRequest()
        let predicate = NSPredicate(format: "friendUser == %@", users[0].objectID)
        request.predicate = predicate
        do {
            userFriends = try myContext.fetch(request)
            
            if(userFriends.count == 0){
                let friend = Friend(context: self.myContext)
                friend.name = "Richard"
                friend.latitude = 43.772628
                friend.longitude = -79.328327
                friend.friendUser = users[0]
                self.userFriends.append(friend)
                self.saveFriend()
                
//                Second Friend
                let friend2 = Friend(context: self.myContext)
                friend2.name = "Angel"
                friend2.latitude = 43.774841
                friend2.longitude = -79.334345
                friend2.friendUser = users[0]
                self.userFriends.append(friend2)
                self.saveFriend()
//              Third
                let friend3 = Friend(context: self.myContext)
                friend3.name = "Marcus"
                friend3.latitude = 43.77441
                friend3.longitude = -79.331084
                friend3.friendUser = users[0]
                self.userFriends.append(friend3)
                self.saveFriend()
                
//                Fourth
                let friend4 = Friend(context: self.myContext)
                friend4.name = "Racheal"
                friend4.latitude = 43.77183
                friend4.longitude = -79.330859
                friend4.friendUser = users[0]
                self.userFriends.append(friend4)
                self.saveFriend()
                
//                Fifth
                let friend5 = Friend(context: self.myContext)
                friend5.name = "Ross"
                friend5.latitude = 43.774784
                friend5.longitude = -79.322152
                friend5.friendUser = users[0]
                self.userFriends.append(friend5)
                self.saveFriend()
                
//                six
                let friend6 = Friend(context: self.myContext)
                friend6.name = "Joey"
                friend6.latitude = 43.775494
                friend6.longitude = -79.325709
                friend6.friendUser = users[0]
                self.userFriends.append(friend6)
                self.saveFriend()
                
//                seven
                let friend7 = Friend(context: self.myContext)
                friend7.name = "Steve"
                friend7.latitude = 43.775479
                friend7.longitude = -79.329292
                friend7.friendUser = users[0]
                self.userFriends.append(friend7)
                self.saveFriend()
                
//                eight
                let friend8 = Friend(context: self.myContext)
                friend8.name = "Rob Harty"
                friend8.latitude = 43.776795
                friend8.longitude = -79.333541
                friend8.friendUser = users[0]
                self.userFriends.append(friend8)
                self.saveFriend()
            }

        }
        catch {
            print("An error occured: \(error)")
        }
        
        
    }
    func saveFriend(){
        do {
            try myContext.save()
            print("===============Post Data Saved===========")
        }
        catch {
            print("An error occured: \(error)")
        }
    }
    
    
}
