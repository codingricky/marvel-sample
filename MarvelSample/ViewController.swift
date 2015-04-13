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
import Typhoon

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var marvelService: MarvelService?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func download(sender: AnyObject) {
        marvelService!.download(name!, completeCallback: {(image: UIImage) in
            dispatch_async(dispatch_get_main_queue()) {
                self.imageView.image = image
            }
        })
    }
    
}
