//
//  User.swift
//  SustainabilityApplication
//
//  Created by Chandler on 9/4/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var major: String?
    var rank: String?
    var profileImageUrl: String?
    var bannerImageUrl: String?
}

class Blog: NSObject {
    var title: String?
    var date: String?
    var author: String?
    var blogText: String?
    //var image: String?
    
    init(blogTitle: String, blogAuthor: String, blogDate: String, blogText: String) {
        self.title = blogTitle
        self.date = blogDate
        self.author = blogAuthor
        self.blogText = blogText
    }
    
    init(postKey: String, blogData: Dictionary<String, AnyObject>) {
        
        if let blogTitle = blogData["blogTitle"] as? String {
            self.title = blogTitle
        }
        
        if let blogDate = blogData["blogDate"] as? String {
            self.date = blogDate
        }
        
        if let blogAuthor = blogData["blogAuthor"] as? String {
            self.author = blogAuthor
        }
        
        if let blogText = blogData["blogText"] as? String {
            self.blogText = blogText
        }
    }
}


