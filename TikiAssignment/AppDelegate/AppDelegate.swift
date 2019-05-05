//
//  AppDelegate.swift
//  TikiAssignment
//
//  Created by DUYLINH on 5/4/19.
//  Copyright © 2019 DUYLINH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let service = KeywordService()
        let sceneCoordinator = SceneCoordinator(window: window!)
        let keywordListViewModel =  KeywordListViewModel(coordinator: sceneCoordinator, keywordService: service)
        let firstScene = Scene.keywordList(keywordListViewModel)
        sceneCoordinator.transition(to: firstScene, type: .root)
        return true
    }
}

