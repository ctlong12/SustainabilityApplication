//
//  CommunityView.swift
//  SustainabilityApplication
//
//  Created by Chandler on 8/19/18.
//  Copyright © 2018 C-LongDev. All rights reserved.
//

import UIKit

class CommunityView: UIView, UIWebViewDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        setUpWebView()
        
    }
    
    
    func setUpWebView() {
        let webV    = UIWebView()
        webV.loadRequest(NSURLRequest(url: NSURL(string: "https://www.instagram.com/explore/tags/notjustusjustice/")! as URL) as URLRequest)
        webV.delegate = self
        addSubview(webV)
        
        webV.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
