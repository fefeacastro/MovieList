//
//  SceneDelegate.swift
//  MovieList
//
//  Created by Fernanda Castro on 20/03/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: MovieListFactory.make())

        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

