//
//  CoreDataService.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/07.
//  Copyright © 2020 Seokho. All rights reserved.
//
import CoreData

protocol CoreDataService: class {
	func fetchData(completion: @escaping (Result<[ToDo], CoreDataError>) -> Void)
	func addData(title: String, completion: @escaping (Result<Void, CoreDataError>) -> Void)
	func deleteData(index: Int, completion: @escaping (Result<Void, CoreDataError>) -> Void)
}

class DefaultCoreDataService: CoreDataService {
	
	private let provider: PersistentContainerProvider
	
	init(provider: PersistentContainerProvider) {
		self.provider = provider
		
		NotificationCenter.default.addObserver(forName: .NSManagedObjectContextDidSave, object: nil, queue: nil) { (notification) in
			provider.container.viewContext.mergeChanges(fromContextDidSave: notification)
		 }
	}
	
	func fetchData(completion: @escaping (Result<[ToDo], CoreDataError>) -> Void) {
		let context = provider.container.viewContext
		
		context.perform {
			let fetchRequest: NSFetchRequest = ToDo.fetchRequest()
			
			let data = try? fetchRequest.execute()
			
			if let todo = data {
				completion(.success(todo))
			} else {
				completion(.failure(.fetchError))
			}
		}
		
	}
	
	func addData(title: String, completion: @escaping (Result<Void, CoreDataError>) -> Void) {
		let container = provider.container
		
		container.performBackgroundTask { context in
			let newData = ToDo(context: context)
			newData.id = UUID().uuidString
			newData.title = title
			
			do {
				try context.save()
				completion(.success(()))
			} catch {
				completion(.failure(.saveError))
			}
			
		}
	}
	
	func deleteData(index: Int, completion: @escaping (Result<Void, CoreDataError>) -> Void) {

		let container = provider.container
		
		container.performBackgroundTask { context in
			
			let fetchRequest: NSFetchRequest = ToDo.fetchRequest()
			
			do {
				let data = try fetchRequest.execute()
				context.delete(data[index])
				try context.save()
				completion(.success(()))
			} catch {
				completion(.failure(.saveError))
			}
			
		}
	}
}
