//
//  ViewController.swift
//  SPNetwork
//
//  Created by sarvesh567 on 11/17/2021.
//  Copyright (c) 2021 sarvesh567. All rights reserved.
//

import UIKit
import SPNetwork
import Alamofire
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
       
         
        do{
            try NetworkConfig.queryConfigHost(completionHandler: { data, networkError in
                let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                guard let j = json else {return }
                print(j)
            })
        }catch{
            print(error.localizedDescription)
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

