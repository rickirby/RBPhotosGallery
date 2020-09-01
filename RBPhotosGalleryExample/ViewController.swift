//
//  ViewController.swift
//  RBPhotosGalleryExample
//
//  Created by Ricki Bin Yamin on 01/09/20.
//  Copyright © 2020 Ricki Bin Yamin. All rights reserved.
//

import UIKit
import RBPhotosGallery

class ViewController: RBPhotosGalleryViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func photosGalleryImages() -> [UIImage] {
		return [#imageLiteral(resourceName: "IndonesiaPhoto2"), #imageLiteral(resourceName: "IndonesiaPhoto3"), #imageLiteral(resourceName: "IndonesiaPhoto4"), #imageLiteral(resourceName: "IndonesiaPhoto1")]
	}


}

