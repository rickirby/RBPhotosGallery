//
//  RBPhotosGalleryViewController1.swift
//  RBPhotosGallery
//
//  Created by Ricki Bin Yamin on 02/09/20.
//  Copyright © 2020 Ricki Bin Yamin. All rights reserved.
//

import UIKit

public protocol RBPhotosGalleryViewDelegate {
	func didSingleTap()
	func didDoubleTap()
}

public extension RBPhotosGalleryViewDelegate {
	func didSingleTap() {}
	func didDoubleTap() {}
}

public protocol RBPhotosGalleryViewDataSource {
	func photosGalleryImages() -> [UIImage]
}

open class RBPhotosGalleryViewController: UIViewController {
	
	// MARK: - Private Properties
	
	private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		layout.itemSize = CGSize(width: view.bounds.size.width + 10, height: view.bounds.size.height)
		
		return layout
	}()
	
	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .clear
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isPagingEnabled = true
		collectionView.alwaysBounceHorizontal = true
		
		return collectionView
	}()
	
	private var delegate: RBPhotosGalleryViewDelegate?
	private var datasource: RBPhotosGalleryViewDataSource?
	
	// MARK: - Public Properties
	
	public var currentPageIndex: Int = 0
	
	// MARK: - Lifecycle
	
	open override func loadView() {
		super.loadView()
		
		configureView()
	}
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		
		delegate = self as? RBPhotosGalleryViewDelegate
		datasource = self as? RBPhotosGalleryViewDataSource
		configureCollectionView()
	}
	
	// MARK: - Private Method
	
	private func configureView() {
		view.backgroundColor = .systemBackground
		view.addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -5),
			collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 5),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func configureCollectionView() {
		collectionView.register(RBPhotosGalleryCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosGalleryCell")
		
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	
	// MARK: - Public Method
	
	public func scrollToPhotos(index: Int, animated: Bool = true) {
		let itemWidth = view.bounds.width + 10
		let itemHeight = view.bounds.height
		collectionView.setContentOffset(CGPoint(x: CGFloat(index) * itemWidth, y: itemHeight / 2), animated: animated)
		currentPageIndex = index
	}
	
	public func reloadPhotosData() {
		// Main thread only
		collectionView.reloadData()
	}

}

extension RBPhotosGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return datasource?.photosGalleryImages().count ?? 0
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let photos = datasource?.photosGalleryImages(), let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosGalleryCell", for: indexPath) as? RBPhotosGalleryCollectionViewCell else { return UICollectionViewCell() }
		cell.image = photos[indexPath.row]
		cell.delegate = self
		
		return cell
	}
	
	public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		currentPageIndex = Int(scrollView.contentOffset.x/scrollView.frame.width)
	}
}

extension RBPhotosGalleryViewController: RBPhotosGalleryCollectionViewCellDelegate {
	
	func didZoomToOriginal() {
		collectionView.isScrollEnabled = true
	}
	
	func didZoomToScaled() {
		collectionView.isScrollEnabled = false
	}
	
	func didSingleTap() {
		delegate?.didSingleTap()
	}
	
	func didDoubleTap() {
		delegate?.didDoubleTap()
	}
}
