//
//  RBPhotosGalleryViewController.swift
//  RBPhotosGallery
//
//  Created by Ricki Bin Yamin on 24/08/20.
//  Copyright © 2020 Ricki Bin Yamin. All rights reserved.
//

import UIKit

open class RBPhotosGalleryViewController: UIViewController {
    
    // MARK: - Private Properties
    
    var currentPageIndex: Int = 0
    var hasLayout = false
    var justMoved = false
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.contentMode = .scaleAspectFill
        scrollView.isDirectionalLockEnabled = true
        scrollView.backgroundColor = .systemBackground
        
        return scrollView
    }()
    
    // MARK: - Public Properties
    
    public lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.color = .systemGray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Life Cycles
    
    open override func loadView() {
        super.loadView()
        
        configureView()
    }
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		
		configureScrollView()
	}
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !justMoved {
            activityIndicator.startAnimating()
            justMoved = false
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        justMoved = true
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        reloadData()
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        // Default view's background color is system color, it support both dark and light mode to be adaptively changed
        view.backgroundColor = .systemBackground
        
        // Adding all subviews
		view.addSubview(scrollView)
		view.addSubview(activityIndicator)
        
        // Configuring autolayout
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
	
	private func configureScrollView() {
		scrollView.delegate = self
	}
    
    private func reloadData() {
            let scrollViewWidth = self.scrollView.frame.width
            let scrollViewHeight = self.scrollView.frame.height
                    
            DispatchQueue.main.async {
                for view in self.scrollView.subviews {
                    view.removeFromSuperview()
                }
                
                let processedImages = self.photosGalleryImages()
                        
                for i in 0..<processedImages.count {
                    let imageView = UIImageView(frame: CGRect(x: scrollViewWidth * CGFloat(i), y: 0, width: scrollViewWidth, height: scrollViewHeight))
                            
                    imageView.image = processedImages[i]
                    imageView.contentMode = .scaleAspectFit
                            
                    self.scrollView.addSubview(imageView)
                }
                        
                self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width * CGFloat(processedImages.count), height: self.scrollView.frame.height)
                
                self.hasLayout = true
                self.activityIndicator.stopAnimating()
            }
        }
    
    // MARK: - Public Method
    
    public func scrollToPage(page: Int, animated: Bool) {
        let pageWidth: CGFloat = scrollView.frame.width
        scrollView.scrollRectToVisible(CGRect(x: pageWidth * CGFloat(page), y: 0, width: pageWidth, height: scrollView.frame.height), animated: animated)
    }
    
    // Should be overrided
    
    open func photosGalleryImages() -> [UIImage] {
        // Run on main thread
        return []
    }
}

extension RBPhotosGalleryViewController: UIScrollViewDelegate {
	public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		if hasLayout {
			currentPageIndex = Int(scrollView.contentOffset.x/scrollView.frame.width)
		}
	}
}
