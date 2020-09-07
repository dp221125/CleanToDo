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
	func presentReloadData()
}

class MainViewController: BaseViewController {
	
	var interactor: MainViewBusinessLogic?
	
	var displayedDatas: [MainModel.FetchData.ViewModel.DisplayedData] = []
	
	init(service: CoreDataService) {
		super.init()
		self.setUp(service: service)
	}

	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "\(MainTableViewCell.self)")
		tableView.dataSource = self
		return tableView
	}()
	
	let emptyLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 25)
		label.textColor = .label
		label.textColor = .systemGray
		label.translatesAutoresizingMaskIntoConstraints = false
		label.isHidden = true
		return label
	}()
	
	let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
	
	override init() {
		super.init()
		self.title = "ToDo"
		self.navigationItem.leftBarButtonItem = self.editButtonItem
		self.navigationItem.rightBarButtonItem = self.addButtonItem
	}
	
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
		
		viewController.interactor = interactor
		
		interactor.presenter = presenter
		presenter.viewController = viewController
	}
	
}
extension MainViewController: MainDisplayLogic {
	func presentReloadData() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
		
	}
	
	func displayErrorAlert(viewModel: MainModel.ErrorData.ViewModel) {
		let alert = UIAlertController(title: "Error",
									  message: viewModel.displayData.first?.error.localizedDescription ?? "",
									  preferredStyle: .alert)
		
		let okAction = UIAlertAction(title: "OK", style: .default)
		alert.addAction(okAction)
		self.present(alert, animated: true)
	}
	
	func displayFetchedDatas(viewModel: MainModel.FetchData.ViewModel) {
		self.displayedDatas = viewModel.displayData
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}
extension MainViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.displayedDatas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MainTableViewCell.self)") as? MainTableViewCell else { return UITableViewCell() }
		cell.configure()
		cell.dataBinding(self.displayedDatas[indexPath.row].title)
		return cell
	}
	
	
}
