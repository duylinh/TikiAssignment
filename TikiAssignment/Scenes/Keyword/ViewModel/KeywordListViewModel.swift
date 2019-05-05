//
//  KeywordListViewModel.swift
//  TikiAssignment
//
//  Created by DUYLINH on 5/4/19.
//  Copyright © 2019 DUYLINH. All rights reserved.
//

import RxSwift
import RxDataSources
import Action


typealias KeywordSectionModel = AnimatableSectionModel<Int, KeywordTableViewCellType>

protocol KeywordListModeling{
    var cellModel: Observable<[KeywordSectionModel]> { get }
    var isRunning: Observable<Bool>{  get }
    var onShowError:PublishSubject<SingleButtonAlert>{ get}
}

enum KeywordTableViewCellType{
    case normal(cellViewModel: KeywordCellViewModel)
    case error(message: String)
    case empty
}

extension KeywordTableViewCellType:IdentifiableType,Equatable{
    static func == (lhs: KeywordTableViewCellType, rhs: KeywordTableViewCellType) -> Bool {
        return lhs.identity != rhs.identity
    }
    
    var identity: Int {
        switch self {
        case .normal(let model):
            return model.keywordItem.index
        case .error, .empty:
            return 0
        }
    }
    
    typealias Identity = Int
    
}


struct KeywordListViewModel:KeywordListModeling{
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var onShowError =  PublishSubject<SingleButtonAlert>()
    var isRunning: Observable<Bool>{
        return activityIndicator.asObservable()
    }
    let activityIndicator = ActivityIndicator()
    let coordinator: SceneCoordinatorType
    let keywordService:KeywordService
    private let subject = BehaviorSubject<[KeywordSectionModel]>(value:[KeywordSectionModel(model: 0, items: [.empty])])
    
    var cellModel: Observable<[KeywordSectionModel]>{
        return  self.getKeywordList().flatMapLatest{ _  in
            self.subject.asObservable()
        }
    }
    
    // MARK: - Con(De)structor
    init( coordinator: SceneCoordinatorType, keywordService:KeywordService) {
        self.coordinator = coordinator
        self.keywordService = keywordService
    }
    
    // MARK: - Private
    private func getKeywordList() -> Observable<Void>{
        return keywordService.getKeywordList(url:APILink.getKeywords)
            .observeOn(MainScheduler.instance)
            .trackActivity(activityIndicator)
            .share(replay: 1)
            .map{ result in
                switch result{
                case .success(let keywords):
                    if keywords.count > 0{
                        let element = keywords.compactMap{KeywordTableViewCellType.normal(cellViewModel: $0 as KeywordCellViewModel)}
                        let sectionModel = [KeywordSectionModel(model: 0, items: element)]
                        self.subject.onNext(sectionModel)
                        
                    }else {
                        self.subject.onNext([KeywordSectionModel(model: 0, items: [.empty])])
                    }
                    
                case .failure(let error):
                    let errorElement = [KeywordTableViewCellType.error(message: error.description)]
                    self.subject.onNext([KeywordSectionModel(model: 0, items: errorElement)])
                    
                }
        }
        
    }
    
    // MARK: - Internal
    func refreshData() -> CocoaAction{
        return CocoaAction { _ in
            return self.getKeywordList()
        }
    }

}
