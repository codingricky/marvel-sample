//
//  Character.swift
//  MarvelSample
//
//  Created by Ricky Yim on 26/01/2015.
//  Copyright (c) 2015 polymorphsolutions. All rights reserved.
//

import Foundation
import JSONJoy

struct Character : JSONJoy {
    var status: String?
    var code: Int?
    var thumbnail: String?
    
    init() {
    }
    
    init(_ decoder: JSONDecoder) {
        status = decoder["status"].string
        code = decoder["code"].integer
        if let arr = decoder["data"]["results"].array {
            let path = arr[0]["thumbnail"]["path"].string
            let fileExtension = arr[0]["thumbnail"]["extension"].string
            thumbnail = "\(path!).\(fileExtension!)"
        }
    }
}

