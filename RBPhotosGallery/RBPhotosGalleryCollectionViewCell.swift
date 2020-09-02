//
//  RBPhotosGalleryCollectionViewCell.swift
//  RBPhotosGallery
//
//  Created by Ricki Bin Yamin on 02/09/20.
//  Copyright © 2020 Ricki Bin Yamin. All rights reserved.
//

import UIKit

class RBPhotosGalleryCollectionViewCell: UICollectionViewCell {
	
	lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		
		return scrollView
	}()
	
	lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.addSubview(scrollView)
		scrollView.addSubview(imageView)
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
			scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			
			imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
			imageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
			imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
