//
//  Keyword.swift
//  TikiAssignment
//
//  Created by DUYLINH on 5/4/19.
//  Copyright © 2019 DUYLINH. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Keyword {
    
    private struct Keys {
        static let keyword = "keyword"
        static let icon = "icon"
    }
    
    // MARK: Properties
    var keyword: String?
    var icon: String?
    var index: Int
    
}

extension Keyword {
    // MARK: - Con(De)structor
    init?(json: JSON, index:Int) {
        guard  let keyword = json[Keys.keyword].string,
            let icon = json[Keys.icon].string else {
                return nil
        }
        if keyword.components(separatedBy: .whitespacesAndNewlines).joined().count == 0 {
            return nil
        }
        self.keyword = keyword
        self.icon = icon
        self.index = index
    }
}
