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
		struct Request { }
		
		struct Response {
			var orders: [ToDo]
		}
		
		struct ViewModel {
			struct DisplayedData {
				var title: String
			}
			
			var displayData = [DisplayedData]()
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
			
			struct DisplayedEdit {
				var isEdit: Bool
			}
			
			var displayEdit: DisplayedEdit
			
		}
	}
}
