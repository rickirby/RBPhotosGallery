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
		collectionView.isPagingEnabled = true
		
		return collectionView
	}()
	
	// MARK: - Public Properties
	
	public var currentPageIndex: Int = 0
	
	// MARK: - Lifecycle
	
	open override func loadView() {
		super.loadView()
		
		configureView()
	}
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		
		configureCollectionView()
	}
	
	open override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		configureCollectionViewCellSize()
	}
	
	// MARK: - Private Method
	
	private func configureView() {
		view.backgroundColor = .systemBackground
		view.addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	private func configureCollectionView() {
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	
	private func configureCollectionViewCellSize() {
		collectionView.layoutIfNeeded()
		collectionViewFlowLayout.itemSize = collectionView.bounds.size
	}
	
	// MARK: - Public Method
}

extension RBPhotosGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 0
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return UICollectionViewCell()
	}

}
