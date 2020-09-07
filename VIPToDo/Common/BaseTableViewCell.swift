//
//  BaseTableViewCell.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/07.
//  Copyright © 2020 Seokho. All rights reserved.
//
import UIKit

class BaseTableViewCell: UITableViewCell {

	private(set) var didSetupConstaints = false

	// MARK: Initialization
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.configureUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Func
	override func updateConstraints() {
		if !self.didSetupConstaints {
			self.setupConstraints()
			self.didSetupConstaints = true
		}
		super.updateConstraints()
	}

	func configure() {
		self.setNeedsUpdateConstraints()
	}

	func configureUI() {
		self.contentView.backgroundColor = .systemBackground
	}

	func setupConstraints() {}
}

