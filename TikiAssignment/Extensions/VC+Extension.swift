//
//  VC+Extension.swift
//  TikiAssignment
//
//  Created by DUYLINH on 5/4/19.
//  Copyright © 2019 DUYLINH. All rights reserved.
//

import UIKit
import Action

protocol SingleButtonDialogPresenter {
    func presentSingleButtonDialog(alert: SingleButtonAlert)
}

extension SingleButtonDialogPresenter where Self: UIViewController {
    
    func presentSingleButtonDialog(alert: SingleButtonAlert) {
        let alertController = UIAlertController(title: alert.title,
                                                message: alert.message,
                                                preferredStyle: .alert)
        
        var  ok = UIAlertAction.Action(alert.action.buttonTitle, style: .default)
        ok.rx.action = alert.action.handler
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
}

struct AlertAction {
    let buttonTitle: String
    let handler: CocoaAction
}

struct SingleButtonAlert {
    let title: String
    let message: String?
    let action: AlertAction
}
