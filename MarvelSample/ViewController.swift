//
//  ViewController.swift
//  MarvelSample
//
//  Created by Ricky Yim on 26/01/2015.
//  Copyright (c) 2015 polymorphsolutions. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func download(sender: AnyObject) {
        let name = "Ant-Man"
        let url = "http://gateway.marvel.com:80/v1/public/characters"
        var request = HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        let publicKey = "YOUR PUBLIC KEY"
        let privateKey = "YOUR PRIVATE KEY"
        let ts = NSDate().timeIntervalSince1970.description
        let hash = "\(ts)\(privateKey)\(publicKey)".md5()
        
        request.GET(url, parameters: ["nameStartsWith": name, "apikey": publicKey, "ts" : ts, "hash": hash], success: { (response: HTTPResponse) -> Void in
            if (response.responseObject != nil) {
                let character = Character(JSONDecoder(response.responseObject!))
                self.downloadCharacter(character)
            }
        },{(error: NSError, response: HTTPResponse?) -> Void in
            println("got an error: \(error)")
        })
    }
    
    func downloadCharacter(character: Character) {
        var request = HTTPTask()
        let downloadTask = request.download(character.thumbnail!, parameters: nil, progress: {(complete: Double) in
            println("percent complete: \(complete)")
            }, success: {(response: HTTPResponse) in
                println("download finished!")
                if response.responseObject != nil {
                    let data = NSData(contentsOfURL: response.responseObject! as NSURL)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.imageView.image = UIImage(data: data!)
                    }
                }
                
            } ,failure: {(error: NSError, response: HTTPResponse?) in
                println("failure")
        })
    }
    
}
