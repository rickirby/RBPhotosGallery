//
//  RBPhotosGalleryCollectionViewCell.swift
//  RBPhotosGallery
//
//  Created by Ricki Bin Yamin on 02/09/20.
//  Copyright © 2020 Ricki Bin Yamin. All rights reserved.
//

import UIKit

class RBPhotosGalleryCollectionViewCell: UICollectionViewCell {
	
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		
		return scrollView
	}()
	
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		return imageView
	}()
	
	var image: UIImage? {
		didSet {
			configureImage(image: image)
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.addSubview(scrollView)
		scrollView.addSubview(imageView)
		scrollView.delegate = self
		
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
	
	private func configureImage(image: UIImage?) {
		imageView.image = image
		imageView.sizeToFit()
		setZoomScale()
	}
	
	private func setZoomScale() {
		imageView.layoutIfNeeded()
		scrollView.layoutIfNeeded()
		let imageViewSize = imageView.bounds.size
		let scrollViewSize = scrollView.bounds.size
		let widthScale = scrollViewSize.width / imageViewSize.width
		let heightScale = scrollViewSize.height / imageViewSize.height
		
		scrollView.minimumZoomScale = min(widthScale, heightScale)
		scrollView.setZoomScale(scrollView.minimumZoomScale, animated: false)
	}
}

extension RBPhotosGalleryCollectionViewCell: UIScrollViewDelegate {
	public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {

        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size

        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0

        if verticalPadding >= 0 {
            // Center the image on screen
            scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        } else {
            // Limit the image panning to the screen bounds
            scrollView.contentSize = imageViewSize
        }
    }
}
