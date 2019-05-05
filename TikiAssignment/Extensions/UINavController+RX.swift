//
//  UINavController+RX.swift
//  TikiAssignment
//
//  Created by DUYLINH on 5/4/19.
//  Copyright © 2019 DUYLINH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


/// For more information take a look at `DelegateProxyType`.
open class RxNavigationControllerDelegateProxy
    : DelegateProxy<UINavigationController, UINavigationControllerDelegate>
    , DelegateProxyType
, UINavigationControllerDelegate {
    
    /// Typed parent object.
    public weak private(set) var navigationController: UINavigationController?
    
    /// - parameter navigationController: Parent object for delegate proxy.
    public init(navigationController: ParentObject) {
        self.navigationController = navigationController
        super.init(parentObject: navigationController, delegateProxy: RxNavigationControllerDelegateProxy.self)
    }
    
    // Register known implementations
    public static func registerKnownImplementations() {
        self.register { RxNavigationControllerDelegateProxy(navigationController: $0) }
    }
}
