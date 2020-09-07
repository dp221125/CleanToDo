//
//  CoreDataError.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/07.
//  Copyright © 2020 Seokho. All rights reserved.
//

import Foundation

enum CoreDataError: Error {
	case fetchError
	case saveError
	case deleteError
}
