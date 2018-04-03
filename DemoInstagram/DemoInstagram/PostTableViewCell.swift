//
//  PostTableViewCell.swift
//  DemoInstagram
//
//  Created by Kane Denzil Quadras Bernard on 2018-04-02.
//  Copyright © 2018 Kane Denzil Quadras Bernard. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPostComment: UILabel!
    @IBOutlet weak var imagePost: UIImageView!
    
    func setCellDetails(post :Post){
        lblUsername.text = post.postUser?.username
        lblPostComment.text = post.comment
        lblDate.text = "Date: " + dateToString(date: post.postdate!)
        if(post.postimage != nil){
            imagePost.image = UIImage(data: post.postimage as! Data)
            
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       

        // Configure the view for the selected state
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
