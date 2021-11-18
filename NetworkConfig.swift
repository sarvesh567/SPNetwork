//
//  NetworkConfig.swift
//  SPNetwork
//
//  Created by Amit Sharma on 18/11/21.
//

import Foundation
import Alamofire
final public class NetworkConfig{
    
    
    // call the network config api here
    public func initConfig(){
        
    }
    
    public func getNetworkConfigApi(){
        
    }
    
    // handle the network config api response here
    public func handleResponse(){
        
    }
    

    public func hostParsing(){
        
    }
    
    public func apiHostParsing(){
        
    }
    
    public static func queryConfigHost(completionHandler: @escaping (Data?, String?) -> ()) throws{
       
        AF.request("https://jsonplaceholder.typicode.com/posts", method: .get).response { response in
            guard let data = response.data else {
                completionHandler(nil, NetworkError.dataNotFound.localizedDescription)
                return
            }
            print(response)
//            completionHandler(data, NetworkError.dataNotFound.localizedDescription)
            
        }
    }
}


struct NetworkConfigResponseModel : Codable {
    let backup_host : String?
    let config_host : String?
    let app_version : App_version?
    let host_section : [Host_section]?

}
struct App_version : Codable {
    let min_version : String?
    let not_supported_version : String?
    let current_version : String?
    let app_update_message : String?

    
}
struct Host_section : Codable {
    let title : String?
    let connect_to_host : String?
    let host : String?
    let api_host : String?

}
