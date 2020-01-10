//
//  ViewController.swift
//  Test Burger View
//
//  Created by Michael Christie on 09/01/2020.
//  Copyright © 2020 Michael Christie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //cleans up the view did load
    let burgerView: UIImageView = {
        let imageName = "burger.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //text view
    let descriptionTextView : UITextView = {
        let textView = UITextView()
        
       let attributedText = NSMutableAttributedString(string: "This is a test LOL", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize:30 )])
        
        attributedText.append(NSAttributedString(string: "\n\n\nAre you read for loads and loads of fun? Dont wait any longer! We hope to see you in our stores soon!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),NSAttributedString.Key.foregroundColor:UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add the image to the view
        //add text
        view.addSubview(descriptionTextView)
        //call method
        setupLayout()
    }
    
    func setupLayout(){
        let topImageContainerView = UIView()
        
        view.addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        //left to right in different languages (eg = Arabic)
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        //add burger image to the top container
        topImageContainerView.addSubview(burgerView)
        
        
        //set constraints for image
        burgerView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        burgerView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        burgerView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.6).isActive = true
        
        
        //add constraints for the text
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
}

