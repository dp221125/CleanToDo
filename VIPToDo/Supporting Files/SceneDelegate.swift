//
//  SceneDelegate.swift
//  VIPToDo
//
//  Created by Seokho on 2020/09/05.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let window = UIWindow(windowScene: windowScene)
		self.window = window
		
		guard let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer else { return }
		
		let provider = PersistentContainerProvider(persistentContainer: container)
		let service: CoreDataService = DefaultCoreDataService(provider: provider)
		
		self.window?.rootViewController = UINavigationController(rootViewController: MainViewController(service: service))
		self.window?.makeKeyAndVisible()
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}


}

