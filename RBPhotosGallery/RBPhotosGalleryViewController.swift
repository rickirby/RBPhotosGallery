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
	
	private var hasLayout = false
	private var justMoved = false
	private var isScaled = false
	
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.isPagingEnabled = true
		scrollView.contentMode = .scaleAspectFill
		scrollView.isDirectionalLockEnabled = true
		scrollView.backgroundColor = .systemBackground
		
		return scrollView
	}()
	
	private lazy var pinchGestureRecognizer: UIPinchGestureRecognizer = {
		let panGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(gestureRecognizer:)))
		
		return panGestureRecognizer
	}()
	
	// MARK: - Public Properties
	
	public var currentPageIndex: Int = 0
	
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
//		configureGestureRecognizer()
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
		scrollView.minimumZoomScale = 1.0
		scrollView.maximumZoomScale = 6.0
	}
	
	private func configureGestureRecognizer() {
		pinchGestureRecognizer.delegate = self
		scrollView.addGestureRecognizer(pinchGestureRecognizer)
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
	
	@objc private func handlePinch(gestureRecognizer: UIPinchGestureRecognizer) {
		if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
			scrollView.transform = scrollView.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale)
			gestureRecognizer.scale = 1.0
		}
		
		if gestureRecognizer.state == .ended {
			if scrollView.frame.width <= view.frame.width {
				UIView.animate(withDuration: 0.2) {
					self.scrollView.transform = CGAffineTransform(scaleX: 1, y: 1)
				}
				isScaled = false
				scrollView.isScrollEnabled = true
			}
			else {
				isScaled = true
				scrollView.isScrollEnabled = false
			}
		}
	}
	
	// MARK: - Public Method
	
	public func scrollToPage(page: Int, animated: Bool) {
		let pageWidth: CGFloat = scrollView.frame.width
		scrollView.scrollRectToVisible(CGRect(x: pageWidth * CGFloat(page), y: 0, width: pageWidth, height: scrollView.frame.height), animated: animated)
		currentPageIndex = page
	}
	
	// MARK: - Open Method
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
	
	public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return scrollView.subviews[currentPageIndex]
	}
}

extension RBPhotosGalleryViewController: UIGestureRecognizerDelegate {
	
}
