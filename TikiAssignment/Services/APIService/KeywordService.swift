//
//  KeywordService.swift
//  TikiAssignment
//
//  Created by DUYLINH on 5/4/19.
//  Copyright © 2019 DUYLINH. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

protocol KeywordServiceType {
    
    @discardableResult
    func getKeywordList(url:String) -> Observable<Result<[Keyword], APIError>>
    
}

struct KeywordService:KeywordServiceType {
    
    private let queue = DispatchQueue(label: "KeywordService.Queue")
    
    init() {}
    
    func getKeywordList(url: String) -> Observable<Result<[Keyword], APIError>> {
        return Observable.create() { observer in
            let request =  Alamofire.request(url)
                .validate(statusCode: 200 ..< 300)
                .responseJSON(queue: self.queue) { response in
                    switch response.result {
                    case .success(let value):
                        guard let jsonArray = JSON(value)["keywords"].array   else {
                            observer.onError(APIError.IncorrectDataReturned)
                            return
                        }
                        var keywordArray:[Keyword] = []
                        for (index, element) in jsonArray.enumerated() {
                            guard let keyword = Keyword(json: element, index: index) else {
                                break
                            }
                            keywordArray.append(keyword)
                        }
                        observer.onNext(.success(payload: keywordArray))
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onNext(.failure(APIError(error: error)))
                        observer.onCompleted()
                    }
                    
            }
            return Disposables.create(with: {
                request.cancel()
            })
            
        }
    }
    
}

enum Result<T, U> where U: Error {
    case success(payload: T)
    case failure(U)
}
