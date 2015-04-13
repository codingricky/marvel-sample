//
//  MarvelAssembly.swift
//  MarvelSample
//
//  Created by Ricky Yim on 3/04/2015.
//  Copyright (c) 2015 polymorphsolutions. All rights reserved.
//

import Foundation
import Typhoon

public class MarvelAssembly : TyphoonAssembly {
    public dynamic func marvelService() -> AnyObject {
        return TyphoonDefinition.withClass(MarvelService.self) {
                (definition) in
            
                definition.injectProperty("url", with:TyphoonConfig("url"))
                definition.injectProperty("publicKey", with:TyphoonConfig("api.public.key"))
                definition.injectProperty("privateKey", with:TyphoonConfig("api.private.key"))
            }
        }
    
    public dynamic func config() -> AnyObject {
        return TyphoonDefinition.configDefinitionWithName("Configuration.plist")
    }
    
    public dynamic func viewController() -> AnyObject {
        return TyphoonDefinition.withClass(ViewController.self) {
            (definition) in
            definition.injectProperty("marvelService", with:self.marvelService())
            definition.injectProperty("name", with:TyphoonConfig("name"))

            definition.scope = TyphoonScope.Singleton
        }
    }
}