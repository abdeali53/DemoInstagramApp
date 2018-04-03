//
//  PostViewController.swift
//  DemoInstagram
//
//  Created by Kane Denzil Quadras Bernard on 2018-04-01.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate {

    var imagePicker: UIImagePickerController!
    var locationManager:CLLocationManager!
   
    //Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var Camerabtn: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var Sharebtn: UIButton!
    
    //CoreData
    let myContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var users = [User]()
    var posts = [Post]()
    
    //Variable
    var binaryImage : NSData?
    var Latitude : Double = 0.00
    var Longitude : Double = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load user
        self.hideKeyboardWhenTappedAround() 
        let username = UserDefaults.standard.value(forKey: "loginUser") as! String
        let password = UserDefaults.standard.value(forKey: "loginPassword") as! String
        self.loadData(username:username, password: password)
        
        // Load Post
//        self.loadData()
//        if(posts.count != 0){
//            imageView.image = UIImage(data: posts[0].postimage! as Data)
//            commentTextField.text = posts[0].comment
//            print("=========Post Data=======")
//            print(posts[0].postdate!)
//            print(posts[0].longitude)
//            print(posts[0].longitude)
//
//        }
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func selectimage(_ sender: Any) {
        
        let selectSourceAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.onLoadCamera(sender)
        }
        selectSourceAlert.addAction(cameraAction)
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.onLoadPhotoLibrary(sender)
        }
        selectSourceAlert.addAction(libraryAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        selectSourceAlert.addAction(cancelAction)
        present(selectSourceAlert, animated: true)
    }
    
    @IBAction func onLoadCamera(_ sender: Any) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            onLoadPhotoLibrary(sender)
        } else {
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func onLoadPhotoLibrary(_ sender: Any) {
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func Sharebtn(_ sender: Any) {
        let post = Post(context: self.myContext)
        
          tabBarController?.selectedIndex = 2
        
        // set the name of the category
        post.postUser = users[0]
        post.latitude = 19.228825
        post.longitude = 72.854118
        post.postdate = NSDate()
        post.comment = commentTextField.text
        post.postimage = binaryImage
//        user.password = txtPassword.text
        // add the Category to the categories array
        self.posts.append(post)
        // save the data and reload the table view
        self.saveData()
        self.loadData()
}
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            
//            img = pickedImage
            imageView.image = pickedImage
            
//            let ur = User(context: self.myContext)
            
            self.binaryImage =  UIImageJPEGRepresentation(pickedImage, 1) as NSData?;
            print("============Binary Data==========")
//            print(self.binaryImage)
            
            
            
            
        }
        
        
        
        // UIImageWriteToSavedPhotosAlbum(imgView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    func loadData(username:String, password:String) {
        let request : NSFetchRequest<User> = User.fetchRequest()
        print("======================UserName=================",username)
        print("======================UserName=================",password)
        
        request.predicate = NSPredicate(format: "username == %@ && password == %@", username, password)
        
        do {
            users = try myContext.fetch(request)
            print("===================Login Data===============",users.count)
        }
        catch {
            print("An error occured: \(error)")
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
    
    func loadData() {
    let request : NSFetchRequest<Post> = Post.fetchRequest()
    
    print("======================Fetch Post=================")
    
    
    
    do {
    posts = try myContext.fetch(request)
    print("===================Post Data===============",posts.count)
    }
    catch {
    print("An error occured: \(error)")
    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
    }
    
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self; 
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        self.Latitude = userLocation.coordinate.latitude
        self.Longitude = userLocation.coordinate.longitude
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }

}
