//
//  SwipingController.swift
//  Test Burger View
//
//  Created by Michael Christie on 10/01/2020.
//  Copyright © 2020 Michael Christie. All rights reserved.
//

import UIKit
import Foundation
import Firebase



class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var restaurauntName = "Flipside"
    var pages: [Page] = []
    
    var imagesOne : UIImage!
    var imagesTwo : UIImage!
    var imagesThree : UIImage!
    var imagesFour : UIImage!
    var imagesFive : UIImage!
    
    //arrays of names and descriptions
    var names:[String] = []
    var descriptions: [String] = []
    
    func one(){
        
        // do your remaining work
        let url1 = URL(string: "https://\(self.restaurauntName)-space.s3-eu-west-1.amazonaws.com/one.png")
        let data1 = try? Data(contentsOf: url1!) //make sure your image in this url does exist
        self.imagesOne = UIImage(data: data1!)
        self.two()
    }
    
    func two(){
        let url1 = URL(string: "https://\(restaurauntName)-space.s3-eu-west-1.amazonaws.com/two.png")
        let data1 = try? Data(contentsOf: url1!) //make sure your image in this url does exist
        self.imagesTwo = UIImage(data: data1!)
        three()
    }
    
    func three(){
        let url1 = URL(string: "https://\(restaurauntName)-space.s3-eu-west-1.amazonaws.com/three.png")
        let data1 = try? Data(contentsOf: url1!) //make sure your image in this url does exist
        self.imagesThree = UIImage(data: data1!)
        four()
    }
    
    func four(){
        let url1 = URL(string: "https://\(restaurauntName)-space.s3-eu-west-1.amazonaws.com/four.png")
        let data1 = try? Data(contentsOf: url1!) //make sure your image in this url does exist
        self.imagesFour = UIImage(data: data1!)
        five()
    }
    
    func five(){
        let url1 = URL(string: "https://\(restaurauntName)-space.s3-eu-west-1.amazonaws.com/five.png")
        let data1 = try? Data(contentsOf: url1!) //make sure your image in this url does exist
        self.imagesFive = UIImage(data: data1!)
    }
    
    func setupImages(){
        self.one()
        print(names[0])
        
        self.pages = [
            Page(imageName: self.imagesOne, headerText: names[0], bodyText: descriptions[0]),
            
            Page(imageName: self.imagesTwo, headerText: names[1], bodyText: descriptions[1]),
    
            Page(imageName: self.imagesThree, headerText: names[2], bodyText: descriptions[2]),
            
            Page(imageName: self.imagesFour, headerText: names[3], bodyText: descriptions[3]),
            
            Page(imageName: self.imagesFive, headerText: names[4], bodyText: descriptions[4]),
        ]
        
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        self.collectionView?.isPagingEnabled = true
        
        setupBottomControls()
        setupTopControls()
        setupButton()
    }
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //https://stackoverflow.com/questions/59697407/adding-a-button-to-a-closure?noredirect=1#comment105552157_59697407
    private lazy var CloseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(closeTest), for: .touchUpInside)
        return button
    }()
    
    @objc private func closeTest(_ sender: UIButton) {
        print("Test boi")
    }
    
    private let ViewARBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View AR", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(ViewAR), for: .touchUpInside)
        return button
    }()
    
    @objc private func ViewAR(_ sender: UIButton) {
        print("AR")
    }
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 5
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .gray
        return pc
    }()
    
    fileprivate func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    fileprivate func setupTopControls() {
        let TopControlsStackView = UIStackView(arrangedSubviews: [CloseButton])
        TopControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(TopControlsStackView)
        
        NSLayoutConstraint.activate([
            TopControlsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            TopControlsStackView.heightAnchor.constraint(equalToConstant: 30),
            TopControlsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
        ])
    }
    
    fileprivate func setupButton() {
        let ButtonStackView = UIStackView(arrangedSubviews: [ViewARBtn])
        ButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ButtonStackView)
        
        NSLayoutConstraint.activate([
            
            ButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            // ButtonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ButtonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            ButtonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ButtonStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    func loadDataFromFirebase() {
       let db = Firestore.firestore()
       db.collection(restaurauntName).getDocuments { (snapshot, err) in
          if let err = err {
             print("Error getting documents: \(err)")
             return
          } else {
             for document in snapshot!.documents {
                let name = document.get("Name") as! String
                let description = document.get("Description") as! String
                self.names.append(name)
                self.descriptions.append(description)
             }
             self.setupImages() //safe to do this here as the firebase data is valid
             self.collectionView.reloadData()
          }
       }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDataFromFirebase()
        
        /*// do your remaining work
        setupBottomControls()
        setupTopControls()
        setupButton()
        setupImages()*/
        
    }
}

