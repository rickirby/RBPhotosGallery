//
//  ViewController.swift
//  RBPhotosGalleryExample
//
//  Created by Ricki Bin Yamin on 02/09/20.
//  Copyright © 2020 Ricki Bin Yamin. All rights reserved.
//

import UIKit
import RBPhotosGallery

class ViewController: RBPhotosGalleryViewController, RBPhotosGalleryViewDelegate, RBPhotosGalleryViewDataSource {
	
	func photosGalleryImages() -> [UIImage] {
		return [#imageLiteral(resourceName: "IndonesiaPhoto2"), #imageLiteral(resourceName: "IndonesiaPhoto3"), #imageLiteral(resourceName: "IndonesiaPhoto4"), #imageLiteral(resourceName: "IndonesiaPhoto1"), #imageLiteral(resourceName: "IndonesiaPhoto5")]
	}
	
	func didSingleTap() {
		print("Single Tap")
		print(currentPageIndex)
	}
	
	func didDoubleTap() {
		print("Double Tap")
	}
}
