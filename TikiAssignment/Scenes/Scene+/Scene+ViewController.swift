//
//  Scene+ViewController.swift
//  TikiAssignment
//
//  Created by DUYLINH on 5/4/19.
//  Copyright © 2019 DUYLINH. All rights reserved.
//

import UIKit

extension Scene {
    func viewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch self {
        case .keywordList(let viewModel):
            let nc = storyboard.instantiateViewController(withIdentifier: "KeywordListVC") as! UINavigationController
            var vc = nc.viewControllers.first as! KeywordListController
            vc.bindViewModel(to: viewModel)
            return nc
        }
    }
}
