//
//  HostSectionResponseModel.swift
//  SPNetwork
//
//  Created by Amit Sharma on 18/11/21.
//

import Foundation
struct APPVersion{
    var min_version: String?
    var not_supported_version: String?
    var current_version: String?
    var app_update_message: String?
}
public struct HostSection {
    public let title : String?
    let connect_to_host : String?
    let host : String?
    let api_host : [APIHost]?
   
}
struct APIHost{
    var api_name: String?
    var api_host: String?
}
