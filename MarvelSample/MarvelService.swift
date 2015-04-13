//
//  MarvelCharacterService.swift
//  MarvelSample
//
//  Created by Ricky Yim on 3/04/2015.
//  Copyright (c) 2015 polymorphsolutions. All rights reserved.
//

import SwiftHTTP
import JSONJoy

class MarvelService :NSObject {
    // TODO Don't check this in
    var publicKey :String?
    var privateKey :String?
    var url: String?
    
    func download(name: String, completeCallback: UIImage -> () ) {
        var request = HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        let ts = NSDate().timeIntervalSince1970.description
        let hash = "\(ts)\(privateKey!)\(publicKey!)".md5()
        
        request.GET(url!, parameters: ["nameStartsWith": name, "apikey": publicKey!, "ts" : ts, "hash": hash], success: { (response: HTTPResponse) -> Void in
            if (response.responseObject != nil) {
                let character = Character(JSONDecoder(response.responseObject!))
                self.downloadCharacterImage(character, completeCallback: completeCallback)
            }
            },failure: {(error: NSError, response: HTTPResponse?) -> Void in
                println("got an error: \(error)")
        })
    }
    
    private func downloadCharacterImage(character: Character, completeCallback: (UIImage) -> ()) {
            var request = HTTPTask()
            let downloadTask = request.download(character.thumbnail!, parameters: nil, progress: {(complete: Double) in
                println("percent complete: \(complete)")
                }, success: {(response: HTTPResponse) in
                    println("download finished!")
                    if response.responseObject != nil {
                        let data = NSData(contentsOfURL: response.responseObject! as! NSURL)
                        let image = UIImage(data: data!)
                        completeCallback(image!)
                    }
                    
                } ,failure: {(error: NSError, response: HTTPResponse?) in
                    println("failure")
            })
    }
}