//
//  KeywordController.swift
//  TikiAssignment
//
//  Created by DUYLINH on 5/4/19.
//  Copyright © 2019 DUYLINH. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import Action
import NSObject_Rx
import PKHUD

class KeywordListController: UIViewController,BindableType {
    
    // MARK: - Constants
    fileprivate let CellHeight:CGFloat = 190
    fileprivate let CellPadding:CGFloat = 16
    
    // MARK: - Outlets
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel: KeywordListViewModel!
    var dataSource:RxCollectionViewSectionedAnimatedDataSource<KeywordSectionModel>?
    
    // MARK: - Overridden: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        setEditing(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Binding
    func bindViewModel(){
        
        refreshButton.rx.action = viewModel.refreshData()
        
        guard let dataSource = dataSource else {
            return
        }
        
        viewModel.cellModel.debug()
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        
        viewModel.isRunning.subscribe(onNext: { [weak self] status in
            PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
            status ? PKHUD.sharedHUD.show(onView: self?.view) : PKHUD.sharedHUD.hide()
            self?.refreshButton.isEnabled = !status
        }).disposed(by: rx.disposeBag)
        
        viewModel.onShowError.subscribe { [weak self]  alert in
            self?.presentSingleButtonDialog(alert: alert.element!)
            }.disposed(by: rx.disposeBag)
    }
    
    // MARK: - Private
    fileprivate func configureCell(){
        
        dataSource = RxCollectionViewSectionedAnimatedDataSource<KeywordSectionModel>(configureCell: {
            dataSource, collectionView, indexPath, item in
            
            switch item {
            case .normal(let viewModel):
                guard let keywordCell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCell.ID, for: indexPath) as? KeywordCell else {
                    return UICollectionViewCell()
                }
                keywordCell.configure(with: viewModel.keywordItem, indexPath: indexPath)
                return keywordCell
            case .error(_), .empty:
                let cell = UICollectionViewCell()
                cell.isUserInteractionEnabled = false
                return cell
            }
        })
        
    }

}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDelegate
extension KeywordListController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = dataSource?[indexPath] else {
            return CGSize.zero
        }
        switch item {
        case .normal(let viewModel):
            guard let keyword = viewModel.keywordItem.keyword else  {
                return CGSize.zero
            }
            let widthOfKeyword = KeywordHelper.calculateMinLengthOfKeyword(with: keyword)
            return CGSize(width:  widthOfKeyword + 10, height: CellHeight)
            //+10 là do leftInset= 5.0. và rightInset = 5.0
        case .error(_), .empty:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CellPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 0, left: 5, bottom: 0, right: 5)
    }
}


extension KeywordListController: SingleButtonDialogPresenter { }
