//
//  PersistentContainerProvider.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/07.
//  Copyright © 2020 Seokho. All rights reserved.
//

import CoreData

class PersistentContainerProvider {
	
	private let persistentContainer: NSPersistentContainer
	
	var container: NSPersistentContainer {
		return self.persistentContainer
    }
    
	init(persistentContainer: NSPersistentContainer) {
		self.persistentContainer = persistentContainer
	}
    
}

