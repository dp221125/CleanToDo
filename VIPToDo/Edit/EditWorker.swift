//
//  EditWorker.swift
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

class EditWorker {
	
	let service: CoreDataService

	init(service: CoreDataService) {
		self.service = service
	}
	
	func addData(title: String, completion: @escaping (Result<Void, CoreDataError>) -> Void) {
		self.service.addData(title: title) { result in
			switch result {
			case .success(let void):
				completion(.success(void))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	
	func updateData(index: Int, title: String, completion: @escaping (Result<Void, CoreDataError>) -> Void) {
		self.service.updateData(index: index, title: title) { result in
			switch result {
			case .success(let void):
				completion(.success(void))
			case .failure(let error):
				completion(.failure(error))
			}
		}
		
	}
}
