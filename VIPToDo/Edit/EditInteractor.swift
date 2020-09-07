//
//  EditInteractor.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/08.
//  Copyright (c) 2020 Seokho. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EditBusinessLogic {
	func showTitle()
}

protocol EditDataStore {
	var defaultText: String? { get set }
}

class EditInteractor: EditBusinessLogic, EditDataStore {

	var defaultText: String?
	
	var presenter: EditPresentationLogic?
	var worker: EditWorker?
	
	
	func showTitle() {
		let response = Edit.GetTitle.Response(title: defaultText)
		presenter?.presentTitle(response: response)
	}
	
}
