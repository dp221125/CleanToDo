//
//  MainViewModel.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/07.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

enum MainModel {
	
	enum FetchData  {
		struct Request {
			var index: Int?
		}
		
		struct Response {
			var index: Int?
			var orders: [ToDo]
		}
		
		struct ViewModel {
			struct DisplayedData {
				var title: [String]
				var index: Int?
			}
			
			var displayData: DisplayedData
//			var displayData = [DisplayedData]()
		}
	}
	
	enum ErrorData {
		struct Request { }
			
		struct Response {
			var error: CoreDataError
		}
		
		struct ViewModel {
			struct DisplayedError {
				var error: CoreDataError
			}
			
			var displayData: DisplayedError
		}
	}
	
	enum EditState {
		struct Request {
			var currentEditState: Bool
		}
		
		struct Response {
			var newEditState: Bool
		}
		
		struct ViewModel {
			
			struct DisplayedEditState {
				var isEdit: Bool
			}
			
			var displayEdit: DisplayedEditState
			
		}
	}
	
	enum EditData {
		struct Request {
			var index: Int
		}
		
		struct Response {
			var index: Int
		}
		
		struct ViewModel {
			
			struct DisplayedEdit {
				var index: Int
			}
			
			var displayEdit: DisplayedEdit
			
		}
	}
}
