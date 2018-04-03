//
//  ViewPostViewController.swift
//  DemoInstagram
//
//  Created by MacStudent on 2018-04-02.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//

import UIKit
import CoreData

class ViewPostViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellComment", for: indexPath)
        
        let comment = comments[indexPath.row]
        
        cell.textLabel?.text = "@" + comment.username! + "  Date:" + dateToString(date: comment.postDate!)
        cell.detailTextLabel?.text = comment.text
        return cell
    }
    
    
    let myContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var comments = [Comment]()
    
//    var user : User?
    var post : Post?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        loadCommentData()
        postImage.image = UIImage(data: post?.postimage as! Data)
        
        print("==============Post Location Latitude==================",post?.latitude)
        print("==============Post Location Longitude==================",post?.latitude)
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var tableViewComment: UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnAddComment(_ sender: UIButton) {
        let alertBox = UIAlertController(title: "Add Comment", message: "Post Comment", preferredStyle:.alert)
        
        alertBox.addTextField()
        let saveButton = UIAlertAction(title: "OK", style: .default, handler: {
           action in
            let commentText = alertBox.textFields?[0].text
            if commentText!.isEmpty == true {
                return
            }
            
            let comment = Comment(context: self.myContext)
            
            comment.username = self.post?.postUser?.username
            comment.postDate = NSDate()
            comment.commentUser = self.post
            comment.text = commentText
            
            self.comments.append(comment)
            self.saveData()
            self.tableViewComment.reloadData()
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertBox.addAction(saveButton)
        alertBox.addAction(cancelButton)
        
        present(alertBox, animated:true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadCommentData() {
        let request : NSFetchRequest<Comment> = Comment.fetchRequest()
        
        let predicate = NSPredicate(format: "commentUser == %@", (post?.objectID)!)
        request.predicate = predicate
        do {
            self.comments = try myContext.fetch(request)
            if(comments.count == 0){
                loadDemo()
            }
        }
        catch {
            print("An error occured: \(error)")
        }
    }
    func saveData() {
        do {
            try myContext.save()
            print("===============Post Data Saved===========")
        }
        catch {
            print("An error occured: \(error)")
        }
    }
    
    func loadDemo(){
        for index in 1...5 {
            let commment = Comment(context: self.myContext)
            
            // set the name of the category
            commment.username = "username_" + String(index)
            commment.postDate = NSDate()
            commment.commentUser = post
            commment.text = "This is Demo Comment ______ #" + String(index)
            // add the Category to the categories array
            self.comments.append(commment)
            // save the data and reload the table view
            self.saveData()
        }
    }
    
    func dateToString(date:NSDate) -> String{
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: date as Date)
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
        
        
    }
    

}
