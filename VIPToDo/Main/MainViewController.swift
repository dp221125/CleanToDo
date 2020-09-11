//
//  MainViewController.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/05.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

protocol MainDisplayLogic: class {
	func displayFetchedDatas(viewModel: MainModel.FetchData.ViewModel)
	func displayErrorAlert(viewModel: MainModel.ErrorData.ViewModel)
	func presentReloadData(viewModel: MainModel.EditData.ViewModel)
	func changeTableViewEditState(viewModel: MainModel.EditState.ViewModel)
}

class MainViewController: BaseViewController {
	
	var interactor: MainViewBusinessLogic?
	
	var router: (MainRoutingLogic & MainDataPassing)?
	var displayedDatas: [String] = []
	
	init(service: CoreDataService) {
		super.init()
		self.title = "ToDo"
		self.setUp(service: service)
	}

	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "\(MainTableViewCell.self)")
		tableView.tableFooterView = UIView()
		tableView.dataSource = self
		tableView.delegate = self
		return tableView
	}()
	
	let emptyLabel: UILabel = {
		let label = UILabel()
		label.text = "To do list is empty."
		label.font = .boldSystemFont(ofSize: 25)
		label.textColor = .label
		label.translatesAutoresizingMaskIntoConstraints = false
		label.isHidden = true
		return label
	}()
	
	lazy var addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(moveToEdit))
	
	lazy var editButtonItems = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTableView))
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func configureUI() {
		
		[tableView, emptyLabel].forEach {
			self.view.addSubview($0)
		}
		
	}
	
	override func setupConstraints() {
		
		NSLayoutConstraint.activate([
			tableView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
			tableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
			tableView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
			tableView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
		])
		
		NSLayoutConstraint.activate([
			emptyLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
			emptyLabel.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
		])
		
	}
	
	func setUp(service: CoreDataService) {
		let viewController = self
		
		let mainWorker = MainWorker(coreDataService: service)
		let interactor = MainViewInteractor(mainWorker: mainWorker)
		let presenter = MainViewPresenter()
		let router = MainRouter()
		
		viewController.interactor = interactor
		viewController.router = router
		interactor.presenter = presenter
		interactor.service = service
		presenter.viewController = viewController
		router.viewController = viewController
		router.dataStore = interactor
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.leftBarButtonItem = self.editButtonItems
		self.navigationItem.rightBarButtonItem = self.addButtonItem
		requestFetchData()
	}
	
	private func requestFetchData() {
		let request = MainModel.FetchData.Request()
		self.interactor?.fetchData(request: request)
	}

	@objc
	private func moveToEdit() {
		self.router?.routeToDetail()
	}
	
	@objc
	private func editTableView() {
		let request = MainModel.EditState.Request(currentEditState: self.tableView.isEditing)
		self.interactor?.changeEditState(request: request)
	}
	
}
extension MainViewController: MainDisplayLogic {
	func changeTableViewEditState(viewModel: MainModel.EditState.ViewModel) {
		self.tableView.setEditing(viewModel.displayEdit.isEdit, animated: true)
        self.navigationItem.leftBarButtonItem?.title = viewModel.displayEdit.isEdit ? "Done" : "Edit"
        self.navigationItem.leftBarButtonItem?.style = viewModel.displayEdit.isEdit ? .done : .plain
	}
	
	func presentReloadData(viewModel: MainModel.EditData.ViewModel) {
		let request = MainModel.FetchData.Request(index: viewModel.displayEdit.index)
		self.interactor?.fetchData(request: request)
	}
	
	func displayErrorAlert(viewModel: MainModel.ErrorData.ViewModel) {
		let alert = UIAlertController(title: "Error",
									  message: viewModel.displayData.error.localizedDescription,
									  preferredStyle: .alert)
		
		let okAction = UIAlertAction(title: "OK", style: .default)
		alert.addAction(okAction)
		self.present(alert, animated: true)
	}
	
	func displayFetchedDatas(viewModel: MainModel.FetchData.ViewModel) {
		self.displayedDatas = viewModel.displayData.title
		DispatchQueue.main.async {
			if let index = viewModel.displayData.index {
				self.tableView.performBatchUpdates({
					self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
				})
			} else {
				self.tableView.reloadData()
			}
			
		}
	}
}
extension MainViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if self.displayedDatas.count == 0 {
			self.navigationItem.leftBarButtonItem = nil
			self.tableView.isHidden = true
			self.emptyLabel.isHidden = false
		} else{
			self.navigationItem.leftBarButtonItem = self.editButtonItems
			self.tableView.isHidden = false
			self.emptyLabel.isHidden = true
		}
		
		return self.displayedDatas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MainTableViewCell.self)") as? MainTableViewCell else { return UITableViewCell() }
		cell.configure()
		cell.dataBinding(self.displayedDatas[indexPath.row])
		return cell
	}
	
}
extension MainViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.router?.routeToDetail()
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

		let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { _,_,_  in
			
			let request = MainModel.EditData.Request(index: indexPath.row)
			self.interactor?.deleteData(request: request)
		}
		
		return UISwipeActionsConfiguration(actions:[deleteAction])


	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 54
	}
	

}
extension MainViewController: AddDelegate {
	func refresh() {
		self.requestFetchData()
	}
}

protocol AddDelegate: class {
	func refresh()
}
