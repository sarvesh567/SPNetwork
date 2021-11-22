//
//  NetworkConfig.swift
//  SPNetwork
//
//  Created by Amit Sharma on 18/11/21.
//

import Foundation
//
//  NetworkConfig.swift
//  SPNetwork
//
//  Created by Amit Sharma on 18/11/21.
//

import Foundation
import Alamofire

public class NetworkConfig{
    public init() {}
    private var hostToConnectHashMap = [String: String]()
    private var hostHashMap = [String: String]()
    public var apiHostHashMap  = [String: String]()
    
    // get User token authorised if login else anonymous token
    
    //MARK: - FETCH_NETWORK_CONFIG
    public func fetchNetworkConfig(endpointHandler: @escaping (String) -> ()){
       
        AF.request(kbaseUrl + kEndpoint, method: .get, parameters: addDefaultParams(),  encoding: URLEncoding(destination: .queryString)).response { response in
            switch response.result{
            case .success(let data):
                guard let data = data else {return}
                self.hostSectionParsing(data)
                DispatchQueue.main.async {
                    endpointHandler("Success")
                }
            case .failure(let error):
                print("POD ERROR: \(error.localizedDescription)")
            }
            
        }
      
    }
    
    public func getAccessToken() -> String{
        
        
    }
    /**
        add default parameters
     */
    public func addDefaultParams() ->  [String: Any]{
        let queryParam = [
            "id": kBundleIdentifier ?? "",
            "build": kbuildNumber ?? ""
         
        ]
        return queryParam
        
    }
    private func hostSectionParsing(_ data: Data?){
        guard let data = data else {return}
        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        let configureJson = json as? [String: Any]
        if let hostSections = configureJson?["host_section"] as? [[String: Any]]{
            for hostSection in hostSections{
                let title = hostSection["title"] as? String
                let host = hostSection["host"] as? String
                let hostToConnect = hostSection["connect_to_host"] as? String
                self.hostToConnectHashMap[title ?? ""] = hostToConnect
                self.hostHashMap[title ?? ""] = host
                
                if let apiHostArray = hostSection["api_host"] as? [[String: Any]]{
                    for apiHost in apiHostArray{
                        let apiName = apiHost["api_name"] as? String
                        let apiHost = apiHost["api_host"] as? String
                       
                        // add api host for the current host and api name
                        self.apiHostHashMap[getHostApiKey(apiName: apiName ?? "", host: title ?? "")] = apiHost
                    }
                }
            }
        }
    }


    /*
     * 1 : check if host title exist else return nil
     * 2 : check if host "connect_to_host" is true else return nil
     * 3 : check if api exit in api_host than return api_host else return host endpoint 'host'
     */
    ///  This function return endpoint.
    ///  ```
    ///  let endPoint = getHostEndPoint(apiName: String , host: String)
    ///  ```
    ///  - Parameter apiName :"" , host: ""

    public func getHostEndPoint(apiName: String , host: String) -> String?{
        // check if connectToHost is true
        if hostToConnectHashMap[host] == "true" {
            // check api-host for the current host exist
            if let ndPoint = apiHostHashMap[getHostApiKey(apiName: apiName, host: host)]{
                return ndPoint
            }
            return hostHashMap[host]
        }
        return nil
    }
    
    public func getHostApiKey(apiName: String , host: String)-> String{
        return ( host ) + "_" + ( apiName )
    }
    
}


