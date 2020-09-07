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

class MainRounter: MainRoutingLogic, MainDataPassing {

	weak var viewController: MainViewController?
	var dataStore: MainDataStore?
	
	func routeToDetail() { }
	
	
}
