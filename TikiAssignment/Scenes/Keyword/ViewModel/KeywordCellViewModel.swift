//
//  KeywordCellViewModel.swift
//  TikiAssignment
//
//  Created by DUYLINH on 5/4/19.
//  Copyright © 2019 DUYLINH. All rights reserved.
//

import Foundation
import Foundation

protocol KeywordCellViewModel {
    var keywordItem: Keyword { get }
}

extension Keyword: KeywordCellViewModel {
    var keywordItem: Keyword {
        return self
    }
}
