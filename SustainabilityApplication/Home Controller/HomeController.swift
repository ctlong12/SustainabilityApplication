//
//  HomeController
//  SustainabilityApplication
//
//  Created by Chandler on 8/14/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UITableViewController {
    
    let cellId = "cellIdOne"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("USER UID: \(Auth.auth().currentUser?.uid)")
        
        checkIfUserIsLoggedIn()
        
        view.backgroundColor = Color.backgroundColor
        tableView.separatorStyle = .none
        setUpNavigationBar()

    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary  = snapshot.value as? [String: AnyObject] {
                    self.menu.nameLabel.text = dictionary["name"] as? String
                    
                    let url = dictionary["profileImageUrl"] as? String
                    if url != nil {
                        self.menu.profileImageView.loadImageUsingCacheWithUrlString(url!)
                    }
                }
                
            }, withCancel: nil)
        }
    }
    
    func refreshProfile(url: String) {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary  = snapshot.value as? [String: AnyObject] {
                
                let urlProfileBanner = dictionary["\(url)"] as? String
                if urlProfileBanner != nil {
                    self.menu.profileImageView.loadImageUsingCacheWithUrlString(urlProfileBanner!)
                }
            }
        }, withCancel: nil)
        
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventController = EventController()
        navigationController?.pushViewController(eventController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Condition for specific height
        if indexPath.section == 0 {
            return 260
        }
        else {
            tableView.estimatedRowHeight = 600 // estimate Row Height
            tableView.rowHeight = UITableViewAutomaticDimension
            return UITableViewAutomaticDimension
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.register(EventCell.self, forCellReuseIdentifier: cellId)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EventCell
            cell.selectionStyle = .none
            return cell
        } else {
            tableView.register(BlogCell.self, forCellReuseIdentifier: cellId)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BlogCell
            cell.selectionStyle = .none
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
            self.tableView.contentInset = insets
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "LATEST BLOG POST"
        } else {
            return "NEXT EVENT"
        }
    }
    
    //******Customizing the Footer******//
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 200))
            footerView.backgroundColor = Color.backgroundColor
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
            button.titleLabel?.font = UIFont(name: "Avenir Next", size: 14.0)
            button.setTitle("SEE ALL UPCOMING EVENTS >", for: .normal)
            button.titleLabel?.textAlignment = .left
            button.setTitleColor(Color.red, for: .normal)
            
            let image = UIImageView(frame: CGRect(x: 0, y: 50, width: tableView.frame.width, height: 150))
            image.image = UIImage(named: "sustainimage")
            image.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(seeThemes))
            image.addGestureRecognizer(tap)
            
            button.addTarget(self, action: #selector(seeAllEvents), for: .touchUpInside)
            
            footerView.addSubview(button)
            footerView.addSubview(image)
            
            return footerView
        } else {
            tableView.estimatedSectionFooterHeight = 600
            tableView.sectionFooterHeight = UITableViewAutomaticDimension
            let footerView = UIView(frame: CGRect(x: 0, y: UITableViewAutomaticDimension, width: tableView.frame.size.width, height: UITableViewAutomaticDimension))
            
            
            footerView.backgroundColor = Color.red
            
            return footerView
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 0
        } else {
            return 200
        }
    }
    
    @objc func seeAllEvents() {
        
        print()
        
        let totalEventsController = UINavigationController(rootViewController: TotalEventsViewController())
        let root = UIApplication.shared.keyWindow!.rootViewController!
        root.present(totalEventsController, animated: true, completion: nil)
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: #selector(displayMenu))
    }
    
    @objc func seeThemes() {
        let themeView = ThemeView(frame: UIScreen.main.bounds)
        let selectionController = UIViewController()
        selectionController.view.addSubview(themeView)
        navigationController?.pushViewController(selectionController, animated: true)
    }
    
    func displayContentController(content: UIViewController) {
        addChildViewController(content)
        self.view.addSubview(content.view)
        content.didMove(toParentViewController: self)
    }
    
    func displayController(menuOption: MenuOption, view: UIView) {
        let selectionController = UIViewController()
        selectionController.navigationItem.title = menuOption.name
        selectionController.view.addSubview(view)
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.pushViewController(selectionController, animated: true)
        
    }
    
    lazy var menu: Menu = {
        let menuLauncher = Menu()
        menuLauncher.homeController = self
        //menuLauncher.profileImageView.image =
        return menuLauncher
    }()
    
    @objc func displayMenu() {
        menu.displayMenu()
    }
}

class BlogCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Color.backgroundColor
        
        setUpBlogDescription()
        
    }
    
    let blogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "feongctllows")
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
    
    var blogText: UITextView = {
        let textView = UITextView()
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        textView.font = UIFont(name: "Avenir Next", size: 18.0)
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textColor = UIColor.black
        return textView
    }()
    
    var blogText2: UITextView = {
        let textView = UITextView()
        textView.text = "Lorem HAHHAHAHHAAH"
        textView.font = UIFont(name: "Avenir Next", size: 18.0)
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textColor = UIColor.blue
        return textView
    }()
    
    func setUpBlogDescription() {
        addSubview(blogImageView)
        addSubview(blogTitle)
        addSubview(blogAuthor)
        addSubview(blogDate)
        addSubview(blogText)
        addSubview(blogText2)

        
        blogImageView.setAnchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)
        blogImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        blogImageView.widthAnchor.constraint(equalToConstant: 75).isActive = true

        blogTitle.setAnchor(top: topAnchor, left: blogImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 5)

        blogAuthor.setAnchor(top: blogTitle.bottomAnchor, left: blogImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: -10, paddingLeft: 8, paddingBottom: 0, paddingRight: 5)

        blogDate.setAnchor(top: blogAuthor.bottomAnchor, left: blogImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: -10, paddingLeft: 8, paddingBottom: 0, paddingRight: 5)
        
        blogText.setAnchor(top: blogDate.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        
        blogText2.setAnchor(top: blogText.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: -15, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        
//        addSubview(justiceImage)
//
//        justiceImage.setAnchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: -75, paddingRight: 10)
//        justiceImage.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//**************EVENT****************\\


class EventCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpContainerView()
        backgroundColor = .white
    }
    
    
    let eventContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.red
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    let eventImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let eventImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var eventButton: UIImageView =  {
        let imageView = UIImageView()
        imageView.image =  UIImage(named: "eventButton")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        //imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleEventTap)))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    let eventDetailsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.red
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    let clipboardIconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.green
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let calendarIconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let clipboardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clipboard")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let overtimeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "overtime")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let eventNameLabel: UILabel = {
        let text = UILabel()
        text.text = "Cistern Yard Concert and Dance"
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 2
        text.textColor = UIColor.white
        
        return text
    }()
    
    let locationLabel: UILabel = {
        let text = UILabel()
        text.text = "Cistern Yard"
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 2
        text.textColor = UIColor.white
        
        return text
    }()
    
    let dateLabel: UILabel = {
        let text = UILabel()
        text.text = "Tuesday April 11th, 2018"
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 2
        text.textAlignment = .right
        text.textColor = UIColor.white
        
        return text
    }()
    
    let timeLabel: UILabel = {
        let text = UILabel()
        text.text = "8:00pm"
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 2
        text.textAlignment = .right
        text.textColor = UIColor.white
        
        return text
    }()
    
    func setUpContainerView() {
        addSubview(eventContainerView)
        
        eventContainerView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        setUpEventBanner()
        
    }
    
    func setUpEventBanner() {
        eventContainerView.addSubview(eventImageContainerView)
        eventImageContainerView.addSubview(eventImage)
        eventImage.addSubview(eventButton)
        
        eventImageContainerView.setAnchor(top: eventContainerView.topAnchor, left: eventContainerView.leftAnchor, bottom: nil, right: eventContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        eventImageContainerView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        eventImage.setAnchor(top: eventImageContainerView.topAnchor, left: eventContainerView.leftAnchor, bottom: nil, right: eventContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        eventImage.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        eventButton.centerYAnchor.constraint(equalTo: eventImage.centerYAnchor, constant: 0).isActive = true
        eventButton.heightAnchor.constraint(equalToConstant: eventImage.frame.height / 3)

        eventButton.setAnchor(top: nil, left: nil, bottom: nil, right: eventImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: -5)
        
        setUpEventDetailsContainer()
    }
    
    func setUpEventDetailsContainer() {
        eventContainerView.addSubview(eventDetailsContainerView)
        eventDetailsContainerView.addSubview(clipboardIconContainerView)
        eventDetailsContainerView.addSubview(separatorView)
        eventDetailsContainerView.addSubview(calendarIconContainerView)
        clipboardIconContainerView.addSubview(clipboardImage)
        calendarIconContainerView.addSubview(overtimeImage)

        
        eventDetailsContainerView.setAnchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        eventDetailsContainerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        clipboardIconContainerView.setAnchor(top: eventDetailsContainerView.topAnchor, left: eventDetailsContainerView.leftAnchor, bottom: eventDetailsContainerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        clipboardIconContainerView.widthAnchor.constraint(equalToConstant: frame.width / 5).isActive = true
        
        separatorView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.centerX(centerX: eventDetailsContainerView.centerXAnchor)
        separatorView.centerY(centerY: eventDetailsContainerView.centerYAnchor)
        
        calendarIconContainerView.setAnchor(top: eventDetailsContainerView.topAnchor, left: nil, bottom: eventDetailsContainerView.bottomAnchor, right: eventDetailsContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        calendarIconContainerView.widthAnchor.constraint(equalToConstant: frame.width / 5).isActive = true
        
        clipboardImage.setAnchor(top: clipboardIconContainerView.topAnchor, left: clipboardIconContainerView.leftAnchor, bottom: clipboardIconContainerView.bottomAnchor, right: clipboardIconContainerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)
        
        overtimeImage.centerX(centerX: calendarIconContainerView.centerXAnchor)
        overtimeImage.centerY(centerY: calendarIconContainerView.centerYAnchor)
        
        setUpLabels()

    }
    
    func setUpLabels() {
        eventDetailsContainerView.addSubview(eventNameLabel)
        eventDetailsContainerView.addSubview(locationLabel)
        eventDetailsContainerView.addSubview(dateLabel)
        eventDetailsContainerView.addSubview(timeLabel)

        eventNameLabel.setAnchor(top: eventDetailsContainerView.topAnchor, left: clipboardIconContainerView.rightAnchor, bottom: nil, right: separatorView.leftAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 2)
        
        locationLabel.setAnchor(top: nil, left: clipboardIconContainerView.rightAnchor, bottom: eventDetailsContainerView.bottomAnchor, right: separatorView.leftAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 5, paddingRight: 2)
        
        dateLabel.setAnchor(top: eventDetailsContainerView.topAnchor, left: separatorView.rightAnchor, bottom: nil, right: calendarIconContainerView.leftAnchor, paddingTop: 5, paddingLeft: 2, paddingBottom: 0, paddingRight: 5)
        
        timeLabel.setAnchor(top: nil, left: separatorView.rightAnchor, bottom: eventDetailsContainerView.bottomAnchor, right: calendarIconContainerView.leftAnchor, paddingTop: 0, paddingLeft: 2, paddingBottom: 5, paddingRight: 5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
