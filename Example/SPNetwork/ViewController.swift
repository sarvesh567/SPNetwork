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
    let networkConfig = NetworkConfig()
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.networkConfig.queryConfigHost(apiName: "get-unique-title-by-cat-id", host: "gk_main_host") { apiURL in
                print(apiURL)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

