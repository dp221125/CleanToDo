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
	func presentReloadData()
}

class MainViewPresenter: MainViewPresenterLogic {
	
	weak var viewController: MainDisplayLogic?
	
	func presentFetchedData(respose: MainModel.FetchData.Response) {
		
		var displayDatas: [MainModel.FetchData.ViewModel.DisplayedData] = []
		
		for displayData in respose.orders {
			if let title = displayData.title {
				let displayData = MainModel.FetchData.ViewModel.DisplayedData(title: title)
				displayDatas.append(displayData)
			}
			
		}
		
		let viewModel = MainModel.FetchData.ViewModel(displayData: displayDatas)
		viewController?.displayFetchedDatas(viewModel: viewModel)
	}
	
	func presentErrorAlert(response: MainModel.ErrorData.Response) {
		
		let viewModel = MainModel.ErrorData.ViewModel(displayData: [MainModel.ErrorData.ViewModel.DisplayedError(error: response.error)])
		viewController?.displayErrorAlert(viewModel: viewModel)
		
	}
	
	func presentReloadData() {
		viewController?.presentReloadData()
	}
	

}
