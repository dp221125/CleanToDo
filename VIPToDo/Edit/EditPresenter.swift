//
//  EditPresenter.swift
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

protocol EditPresentationLogic {
	func presentTitle(response: Edit.GetTitle.Response)
	func presentErrorAlert(response: Edit.ErrorData.Response)
	func presentDismiss(response: Edit.Update.Response)
	func presentBarButton(response: Edit.VaildCheck.Response)
}

class EditPresenter: EditPresentationLogic {

	weak var viewController: EditDisplayLogic?
  
	func presentTitle(response: Edit.GetTitle.Response) {
		
		let viewModel = Edit.GetTitle.ViewModel(disPlayTitle: Edit.GetTitle.ViewModel.DisPlayTitle(title: response.title))
		viewController?.displayTitle(viewModel: viewModel)
		
	}
	
	func presentErrorAlert(response: Edit.ErrorData.Response) {
		
		let viewModel = Edit.ErrorData.ViewModel(displayData: Edit.ErrorData.ViewModel.DisplayedError(error: response.error))
		viewController?.displayErrorAlert(viewModel: viewModel)
	}
	
	func presentDismiss(response: Edit.Update.Response) {
		
		let viewModel = Edit.Update.ViewModel()
		viewController?.displayDismiss(viewModel: viewModel)
	}
	
	func presentBarButton(response: Edit.VaildCheck.Response) {
		
		let viewModel = Edit.VaildCheck.ViewModel(displayButton: Edit.VaildCheck.ViewModel.DisplayedBarButton(isVaild: response.isVaild))
		viewController?.displayBarButton(viewModel: viewModel)
	}
}
