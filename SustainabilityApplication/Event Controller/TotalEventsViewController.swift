//
//  TotalEventsViewController.swift
//  SustainabilityApplication
//
//  Created by Chandler on 8/26/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit

class TotalEventsViewController: UITableViewController {
    
    let cellId = "cellIdOne"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        setUpNavigationBar()

        tableView.register(TotalEventsCell.self, forCellReuseIdentifier: cellId)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(dismissProfileController))
    }
    
    @objc func dismissProfileController() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventController = EventController()
        navigationController?.pushViewController(eventController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TotalEventsCell
        cell.selectionStyle = .none
        cell.separatorInset.top = 100
        cell.backgroundColor = Color.backgroundColor
        return cell
    }
    
    @objc func seeAllEvents() {
        print("Going to events")
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "Upcoming Events"
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
}

class TotalEventsCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpContainerView()
        backgroundColor = .white
    }
    
    
    let eventContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.backgroundColor
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
    
    let sideBarView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.blue
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
    
    let eventNameLabel: UILabel = {
        let text = UILabel()
        text.text = "Cistern Yard Concert and Dance"
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
        text.textColor = UIColor.white
        
        return text
    }()
    
    let timeLabel: UILabel = {
        let text = UILabel()
        text.text = "8:00pm"
        text.font =  UIFont(name: "Avenir Next", size: 12.0)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 2
        text.textColor = UIColor.white
        
        return text
    }()
    
    let bottomBarView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.backgroundColor
        return view
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
        eventDetailsContainerView.addSubview(sideBarView)
        clipboardIconContainerView.addSubview(clipboardImage)
        //eventContainerView.addSubview(bottomBarView)
        
        
        eventDetailsContainerView.setAnchor(top: eventImageContainerView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        eventDetailsContainerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        clipboardIconContainerView.setAnchor(top: eventDetailsContainerView.topAnchor, left: eventDetailsContainerView.leftAnchor, bottom: eventDetailsContainerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        clipboardIconContainerView.widthAnchor.constraint(equalToConstant: frame.width / 5).isActive = true
        
        sideBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        sideBarView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        sideBarView.setAnchor(top: nil, left: nil, bottom: nil, right: eventDetailsContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        sideBarView.centerY(centerY: eventDetailsContainerView.centerYAnchor)
        
        clipboardImage.setAnchor(top: clipboardIconContainerView.topAnchor, left: clipboardIconContainerView.leftAnchor, bottom: clipboardIconContainerView.bottomAnchor, right: clipboardIconContainerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)
        
//        bottomBarView.heightAnchor.constraint(equalToConstant: 15).isActive = true
//        bottomBarView.setAnchor(top: eventDetailsContainerView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        setUpLabels()
        
    }
    
    func setUpLabels() {
        eventDetailsContainerView.addSubview(eventNameLabel)
        eventDetailsContainerView.addSubview(dateLabel)
        eventDetailsContainerView.addSubview(timeLabel)
        
        eventNameLabel.setAnchor(top: eventDetailsContainerView.topAnchor, left: clipboardIconContainerView.rightAnchor, bottom: nil, right: sideBarView.leftAnchor, paddingTop: 5, paddingLeft: 8, paddingBottom: 0, paddingRight: 5)
        
        dateLabel.setAnchor(top: eventNameLabel.bottomAnchor, left: clipboardIconContainerView.rightAnchor, bottom: nil, right: sideBarView.leftAnchor, paddingTop: 5, paddingLeft: 8, paddingBottom: 0, paddingRight: 5)
        
        timeLabel.setAnchor(top: dateLabel.bottomAnchor, left: clipboardIconContainerView.rightAnchor, bottom: nil, right: sideBarView.leftAnchor, paddingTop: 5, paddingLeft: 8, paddingBottom: 0, paddingRight: 5)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
