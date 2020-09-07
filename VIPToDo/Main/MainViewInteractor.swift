//
//  MainViewInteractor.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/07.
//  Copyright © 2020 Seokho. All rights reserved.
//

import Foundation

protocol MainViewBusinessLogic: class {
	func fetchData()
	func addData(title: String)
	func deleteData(index: Int)
}

protocol MainViewDataStore: class {
	var todo: ToDo? { get set }
}

class MainViewInteractor: MainViewBusinessLogic, MainViewDataStore {

	var presenter: MainViewPresenterLogic?
	
	let worker: MainWorker

	init(mainWorker: MainWorker) {
		self.worker = mainWorker
	}
	
	var todo: ToDo?
	
	func fetchData() {
		
		worker.fetchData { result in
			switch result {
			case .success(let todo):
				self.presenter?.presentFetchedData(respose: MainModel.FetchData.Response(orders: todo))
			case .failure(let error):
				self.presenter?.presentErrorAlert(response: MainModel.ErrorData.Response(error: error))
			}
		}
		
	}
	
	func addData(title: String) {
		
		worker.addData(title: title) { result in
			switch result {
			case .success:
				self.presenter?.presentReloadData()
			case .failure(let error):
				self.presenter?.presentErrorAlert(response: MainModel.ErrorData.Response(error: error))
			}
		}
		
	}
	
	func deleteData(index: Int) {
		
		worker.deleteData(index: index) { result in
			switch result {
			case .success:
				self.presenter?.presentReloadData()
			case .failure(let error):
				self.presenter?.presentErrorAlert(response: MainModel.ErrorData.Response(error: error))
			}
		}
		
	}
}
