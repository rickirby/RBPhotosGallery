//
//  RBPhotosGalleryViewController1.swift
//  RBPhotosGallery
//
//  Created by Ricki Bin Yamin on 02/09/20.
//  Copyright © 2020 Ricki Bin Yamin. All rights reserved.
//

import UIKit

open class RBPhotosGalleryViewController: UIViewController {
	
	// MARK: - Private Properties
	
	private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		
		return layout
	}()
	
	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .systemBackground
		collectionView.showsHorizontalScrollIndicator = false
		
		return collectionView
	}()
	
	// MARK: - Public Properties
	
	// MARK: - Lifecycle
	
	open override func loadView() {
		super.loadView()
		
		configureView()
	}
	
	// MARK: - Private Method
	
	private func configureView() {
		view.addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
			collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	// MARK: - Public Method
}
