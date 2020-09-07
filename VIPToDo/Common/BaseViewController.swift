//
//  BaseViewController.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/07.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    private(set) var didSetupConstraints = false
    private(set) var didSetupSubViews = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        self.view.setNeedsUpdateConstraints()
        self.configureUI()
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = false
        }
        
        super.updateViewConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        if !didSetupSubViews{
            self.setupSubViews()
            self.didSetupSubViews = false
        }
    }
    
    func setupConstraints() { }
    func setupSubViews() { }
    func configureUI() { }
}
