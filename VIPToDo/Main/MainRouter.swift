//
//  MainRouter.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/07.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

protocol MainRoutingLogic {
	func routeToDetail()
}

protocol MainDataPassing {
	var dataStore: MainDataStore? { get }
}

class MainRouter: MainRoutingLogic, MainDataPassing {

	weak var viewController: MainViewController?
	var dataStore: MainDataStore?
	
	func routeToDetail() {
		
		let nextViewController: EditViewController = EditViewController()
		nextViewController.delegate = viewController
		var nextDataSource = nextViewController.router!.dataStore!
		
		passDataToEdit(source: dataStore!, destination: &nextDataSource)
		navigateToEdit(source: viewController!, destination: nextViewController)
	}
	
	func passDataToEdit(source: MainDataStore, destination: inout EditDataStore) {
		
		destination.service = source.service
		
		if let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row {
			destination.defaultText = source.todo?[selectedRow].title
			destination.selectedIndex = selectedRow
			
		}
		
	}
	
	func navigateToEdit(source: MainViewController, destination: EditViewController) {

		source.present(UINavigationController(rootViewController: destination), animated: true)
	}
	
	
}
