//
//  ViewController.swift
//  RBPhotosGalleryExample
//
//  Created by Ricki Bin Yamin on 01/09/20.
//  Copyright © 2020 Ricki Bin Yamin. All rights reserved.
//

import UIKit
import RBPhotosGallery

class ViewController: RBPhotosGalleryViewController1 {
	
	lazy var barButtonItem0: UIBarButtonItem = {
		let button = UIBarButtonItem(title: "Scroll0A", style: .plain, target: self, action: #selector(barButtonItem0Tapped))
		
		return button
	}()
	
	lazy var barButtonItem1: UIBarButtonItem = {
		let button = UIBarButtonItem(title: "Scroll1N", style: .plain, target: self, action: #selector(barButtonItem1Tapped))
		
		return button
	}()
	
	lazy var barButtonItem2: UIBarButtonItem = {
		let button = UIBarButtonItem(title: "Scroll2A", style: .plain, target: self, action: #selector(barButtonItem2Tapped))
		
		return button
	}()
	
	lazy var barButtonItem3: UIBarButtonItem = {
		let button = UIBarButtonItem(title: "Scroll3N", style: .plain, target: self, action: #selector(barButtonItem3Tapped))
		
		return button
	}()
	
	lazy var toolBarItem0: UIBarButtonItem = {
		let button = UIBarButtonItem(title: "Print", style: .plain, target: self, action: #selector(toolBarItemTapped))
		
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.leftBarButtonItems = [barButtonItem0, barButtonItem1]
		navigationItem.rightBarButtonItems = [barButtonItem3, barButtonItem2]
		
		navigationController?.setToolbarHidden(false, animated: true)
		toolbarItems = [toolBarItem0]
	}
	
	override func photosGalleryImages() -> [UIImage] {
		return [#imageLiteral(resourceName: "IndonesiaPhoto2"), #imageLiteral(resourceName: "IndonesiaPhoto3"), #imageLiteral(resourceName: "IndonesiaPhoto4"), #imageLiteral(resourceName: "IndonesiaPhoto1")]
	}
	
	@objc func barButtonItem0Tapped() {
		scrollToPage(page: 0, animated: true)
	}
	
	@objc func barButtonItem1Tapped() {
		scrollToPage(page: 1, animated: false)
	}
	
	@objc func barButtonItem2Tapped() {
		scrollToPage(page: 2, animated: true)
	}
	
	@objc func barButtonItem3Tapped() {
		scrollToPage(page: 3, animated: false)
	}
	
	@objc func toolBarItemTapped() {
		print(self.currentPageIndex)
	}
	
}

