//
//  RBPhotosGalleryViewController1.swift
//  RBPhotosGallery
//
//  Created by Ricki Bin Yamin on 02/09/20.
//  Copyright © 2020 Ricki Bin Yamin. All rights reserved.
//

import UIKit

public protocol RBPhotosGalleryViewDelegate {}

extension RBPhotosGalleryViewDelegate {
	func didZoomToOriginal() {}
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
		layout.itemSize = view.bounds.size
		
		return layout
	}()
	
	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .systemBackground
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isPagingEnabled = true
		
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
			collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
			collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func configureCollectionView() {
		collectionView.register(RBPhotosGalleryCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosGalleryCell")
		
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	
	// MARK: - Public Method

}

extension RBPhotosGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return datasource?.photosGalleryImages().count ?? 0
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let photos = datasource?.photosGalleryImages(), let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosGalleryCell", for: indexPath) as? RBPhotosGalleryCollectionViewCell else { return UICollectionViewCell() }
		cell.image = photos[indexPath.row]
		cell.delegate = self
		
		return cell
	}
}

extension RBPhotosGalleryViewController: RBPhotosGalleryCollectionViewCellDelegate {
	
	func didZoomToOriginal() {
		delegate?.didZoomToOriginal()
	}
}
