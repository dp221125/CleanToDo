//
//  MainWorker.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/07.
//  Copyright © 2020 Seokho. All rights reserved.
//

import Foundation

class MainWorker {
	
	let coreDataService: CoreDataService

	init(coreDataService: CoreDataService) {
		self.coreDataService = coreDataService
	}
	
	func fetchData(completion: @escaping (Result<[ToDo], CoreDataError>) -> Void) {
		self.coreDataService.fetchData { result in
			switch result {
			case .success(let todo):
				completion(.success(todo))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func addData(title: String, completion: @escaping (Result<Void, CoreDataError>) -> Void) {
		self.coreDataService.addData(title: title) { result in
			switch result {
			case .success(let void):
				completion(.success(void))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func deleteData(index: Int, completion: @escaping (Result<Void, CoreDataError>) -> Void) {
		self.coreDataService.deleteData(index: index) { result in
			switch result {
			case .success(let void):
				completion(.success(void))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
