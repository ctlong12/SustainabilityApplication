//
//  BlogController.swift
//  SustainabilityApplication
//
//  Created by Chandler on 9/7/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit
import Firebase

class BlogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    var blogs = [Blog]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Blogs"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(handleDismiss))
        collectionView?.register(BlogListCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = Color.backgroundColor
        collectionView?.contentInset = UIEdgeInsetsMake(30, 0, 0, 0)
        
        getBlogs()
    }
    
    func getBlogs() {
        let ref = Database.database().reference().child("blogs").child("allBlogs")
        ref.observe(.value, with: {(snapshot) in
            self.blogs = []
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("HIII \(snap)")
                    if let blogDict = snap.value as? Dictionary<String, AnyObject> {
                        print("HIIII")

                        let key = snap.key
                        let blog = Blog(postKey: key, blogData: blogDict)

                        self.blogs.append(blog)
                    }
                }
            }
            self.collectionView?.reloadData()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 330)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blogs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let blog = blogs[indexPath.row]
        print(blog)
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? BlogListCell {
            
            cell.configureBlogCell(blog: blog)
            
            return cell
        } else {
            return BlogListCell()
        }
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}


class BlogListCell: UICollectionViewCell {
    
    var blog: Blog!
    
    func configureBlogCell(blog: Blog) {
        self.blog = blog
        self.blogTitle.text = blog.title
        self.blogAuthor.text = blog.author
        self.blogDate.text = blog.date
        self.blogText.text = blog.blogText

    }
    
    
    let blogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blankProfile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 38
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let blogTitle: UITextView = {
        let textView = UITextView()
        textView.text = "What Does Sustainbility Look Like?"
        textView.font = UIFont(name: "Avenir Next", size: 18.0)
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textColor = Color.blue
        return textView
    }()
    
    let blogAuthor: UITextView = {
        let textView = UITextView()
        textView.text = "By: Chandler Long"
        textView.font = UIFont(name: "Avenir Next", size: 14.0)
        textView.font = UIFont.italicSystemFont(ofSize: 14)
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.textColor = Color.green
        return textView
    }()
    
    let blogDate: UITextView = {
        let textView = UITextView()
        textView.text = "June 6th, 2018"
        textView.font = UIFont(name: "Avenir Next", size: 14.0)
        textView.font = UIFont.italicSystemFont(ofSize: 14)
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.textColor = Color.red
        return textView
    }()
    
    let justiceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "socialJustice")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var blogText: UILabel = {
        let textView = UILabel()
        textView.text = "Blog content..."
        textView.font = UIFont(name: "Avenir Next", size: 14.0)
        textView.backgroundColor = .clear
        textView.numberOfLines = 8
        textView.textColor = UIColor.black
        return textView
    }()
    
    let buttonLabel: UILabel = {
        let text = UILabel()
        text.text = "READ FULL BLOG POST >"
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 1
        text.textColor = Color.red
        
        return text
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "heartDull"), for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLikePost), for: .touchUpInside)
        return button
    }()
    
    let likeLabel: UILabel = {
        let text = UILabel()
        text.text = "55 likes"
        text.font = UIFont(name: "Avenir Next", size: 12)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = Color.red
        text.textAlignment = .center
        
        return text
        
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    @objc func handleLikePost() {
        print("Liking post")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Color.backgroundColor
        setUpBlogDescription()
        
    }
    
    func setUpBlogDescription() {
        addSubview(blogImageView)
        addSubview(blogTitle)
        addSubview(blogAuthor)
        addSubview(blogDate)
        addSubview(blogText)
        addSubview(buttonLabel)
        addSubview(likeButton)
        addSubview(likeLabel)
        addSubview(seperatorView)
        
        
        blogImageView.setAnchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)
        blogImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        blogImageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        blogTitle.setAnchor(top: topAnchor, left: blogImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 5)
        
        blogAuthor.setAnchor(top: blogTitle.bottomAnchor, left: blogImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: -10, paddingLeft: 8, paddingBottom: 0, paddingRight: 5)
        
        blogDate.setAnchor(top: blogAuthor.bottomAnchor, left: blogImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: -10, paddingLeft: 8, paddingBottom: 0, paddingRight: 5)
        
        blogText.setAnchor(top: blogDate.bottomAnchor, left: blogImageView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10)
        
        buttonLabel.setAnchor(top: blogText.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)
        buttonLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        buttonLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        likeButton.setAnchor(top: blogText.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15)
        likeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        likeLabel.setAnchor(top: nil, left: nil, bottom: likeButton.bottomAnchor, right: likeButton.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 3)
        
        seperatorView.widthAnchor.constraint(equalToConstant: frame.width / 1.1).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperatorView.setAnchor(top: likeLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        seperatorView.centerX(centerX: centerXAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
