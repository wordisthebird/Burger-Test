//
//  SwipingController.swift
//  Test Burger View
//
//  Created by Michael Christie on 10/01/2020.
//  Copyright © 2020 Michael Christie. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "beard", headerText: "Join use today in our fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
        Page(imageName: "burger", headerText: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
        Page(imageName: "beard", headerText: "VIP members special services", bodyText: ""),
        Page(imageName: "burger", headerText: "Join use today in our fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
        Page(imageName: "beard", headerText: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
        Page(imageName: "burger", headerText: "VIP members special services", bodyText: "")
    ]
    
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
        print("Test")
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //https://stackoverflow.com/questions/59697407/adding-a-button-to-a-closure?noredirect=1#comment105552157_59697407
    private lazy var CloseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(closeTest), for: .touchUpInside)
        return button
    }()
    
    
    
    @objc private func closeTest(_ sender: UIButton) {
        print("Test boi")
    }
    
    
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
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
        //TopControlsStackView.alignment =
        view.addSubview(TopControlsStackView)

        NSLayoutConstraint.activate([
            TopControlsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            TopControlsStackView.heightAnchor.constraint(equalToConstant: 30),
            TopControlsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
        ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomControls()
        setupTopControls()
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.isPagingEnabled = true
    }
    
}
