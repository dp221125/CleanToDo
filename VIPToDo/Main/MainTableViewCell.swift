//
//  MainTableVIewCell.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/07.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

class MainTableViewCell: BaseTableViewCell {
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 18)
		label.textColor = .label
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override func configureUI() {
		[titleLabel].forEach {
			self.contentView.addSubview($0)
		}
	}
	
	override func setupConstraints() {
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
			titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
		])
	}
	
	func dataBinding(_ text: String) {
		self.titleLabel.text = text
	}
	
	
}
