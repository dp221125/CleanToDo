//
//  MainViewInteractor.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/07.
//  Copyright © 2020 Seokho. All rights reserved.
//

import Foundation

protocol MainViewBusinessLogic: class {
	func fetchData(request: MainModel.FetchData.Request)
	func deleteData(index: Int)
	func changeEditState(request: MainModel.EditState.Request)
}

protocol MainDataStore: class {
	var todo: [ToDo]? { get set }
	var service: CoreDataService? { get set }
}

class MainViewInteractor: MainViewBusinessLogic, MainDataStore {
		
	var service: CoreDataService?
	var presenter: MainViewPresenterLogic?
	
	let worker: MainWorker

	init(mainWorker: MainWorker) {
		self.worker = mainWorker
	}
	
	var todo: [ToDo]?
	
	func fetchData(request: MainModel.FetchData.Request) {
		
		worker.fetchData { result in
			switch result {
			case .success(let todo):
				self.todo = todo
				self.presenter?.presentFetchedData(respose: MainModel.FetchData.Response(orders: todo))
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
	
	func changeEditState(request: MainModel.EditState.Request) {
		self.presenter?.presentEditState(response: MainModel.EditState.Response(newEditState: !request.currentEditState))
	}
}
