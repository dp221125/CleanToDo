//
//  MainViewPresenter.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/07.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

protocol MainViewPresenterLogic {
	func presentFetchedData(respose: MainModel.FetchData.Response)
	func presentErrorAlert(response: MainModel.ErrorData.Response)
	func presentReloadData(response: MainModel.EditData.Response)
	func presentEditState(response: MainModel.EditState.Response)
}

class MainViewPresenter: MainViewPresenterLogic {

	weak var viewController: MainDisplayLogic?
	
	func presentFetchedData(respose: MainModel.FetchData.Response) {
		
		
		var todoTItle = [String]()
		
		for displayData in respose.orders {
			if let title = displayData.title {
//				let displayData = MainModel.FetchData.ViewModel.DisplayedData(title: title)
//				displayDatas.append(displayData)
				todoTItle.append(title)
			}
			
		}
		
		
		let displayData = MainModel.FetchData.ViewModel.DisplayedData(title: todoTItle, index: respose.index)
		let viewModel = MainModel.FetchData.ViewModel(displayData: displayData)
		viewController?.displayFetchedDatas(viewModel: viewModel)
	}
	
	func presentErrorAlert(response: MainModel.ErrorData.Response) {
		
		let viewModel = MainModel.ErrorData.ViewModel(displayData: MainModel.ErrorData.ViewModel.DisplayedError(error: response.error))
		viewController?.displayErrorAlert(viewModel: viewModel)
		
	}
	
	func presentReloadData(response: MainModel.EditData.Response) {
		let viewModel = MainModel.EditData.ViewModel(displayEdit: MainModel.EditData.ViewModel.DisplayedEdit(index: response.index))
		viewController?.presentReloadData(viewModel: viewModel)
	}
	
	func presentEditState(response: MainModel.EditState.Response) {
		
		let viewModel = MainModel.EditState.ViewModel(displayEdit: MainModel.EditState.ViewModel.DisplayedEditState(isEdit: response.newEditState))
		viewController?.changeTableViewEditState(viewModel: viewModel)
	}
	

}
