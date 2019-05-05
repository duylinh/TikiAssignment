//
//  UIImageView+Extension.swift
//  Shared
//
//  Created by DUYLINH on 5/4/19.
//  Copyright © 2019 DUYLINH. All rights reserved.
//

import AlamofireImage

extension UIImageView {
    
    func setImage(url:URL){
        self.af_setImage(withURL: url)
    }
}
