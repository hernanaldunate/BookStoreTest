//
//  SceneDelegate.swift
//  BookStoreTest_HernanAldunate
//
//  Created by user on 02/09/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    var appCoordinator: AppCoordinator!

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        self.window = window
        self.appCoordinator = AppCoordinator(window: window)

        appCoordinator.start()
    }
}

