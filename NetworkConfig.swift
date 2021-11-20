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
    private var hostSectionArray = [HostSection]()
    private var apiHostArray = [APIHost]()
    private var appVersion = APPVersion()
    
    //MARK: - HASH MAPs
    private var apiHostHashMap  = [String: String]()
    private var hostToConnectHashMap = [String: String]()
    private var hostHashMap = [String: String]()
    private var apiHostNullHashMap: [String: Any]?
    
    public func queryConfigHost(apiName: String, host: String, apiURLCompletion: @escaping (String) -> ()){
        AF.request("https://topcoaching.in:8081/config/v2/get-config?id=\(Bundle.main.bundleIdentifier ?? "")", method: .get).response { response in
            switch response.result{
            case .success(let data):
                guard let data = data else {return}
                self.hostSectionParsing(data)
                DispatchQueue.main.async {
                    if let apiURL = self.getHostEndPoint(apiName: apiName, host: host){
                        apiURLCompletion(apiURL)
                    }
                }
            case .failure(let error):
                print("POD ERROR: \(error.localizedDescription)")
            }
            
        }
    }
    private func hostSectionParsing(_ data: Data?){
        guard let data = data else {return}
        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        let configureJson = json as? [String: Any]
        if let hostSections = configureJson?["host_section"] as? [[String: Any]]{
            for hostSection in hostSections{
                let title = hostSection["title"] as? String
                let host = hostSection["host"] as? String
                let apiHost = hostSection["api_host"] as? [String: String]
                let hostToConnect = hostSection["connect_to_host"] as? String
                self.hostToConnectHashMap[title ?? ""] = hostToConnect
                self.hostHashMap[title ?? ""] = host
                self.apiHostNullHashMap?[title ?? ""] = apiHost
                
                if let apiHostArray = hostSection["api_host"] as? [[String: Any]]{
                    for apiHost in apiHostArray{
                        let apiName = apiHost["api_name"] as? String
                        let apiHost = apiHost["api_host"] as? String
                        self.apiHostHashMap[apiName ?? ""] = apiHost
                        self.apiHostArray.append(APIHost(api_name: apiName, api_host: apiHost))
                    }
                }
                self.hostSectionArray.append(HostSection(title: title, connect_to_host: hostToConnect, host: host, api_host: apiHostArray))
            }
        }
        let appVersion = configureJson?["app_version"] as? [String: Any]
        let minimumVersion = appVersion?["min_version"] as? String
        let notSupportedVersion = appVersion?["not_supported_version"] as? String
        let currentVersion = appVersion?["current_version"] as? String
        let appUpdateMessage = appVersion?["app_update_message"] as? String
        self.appVersion = APPVersion(min_version: minimumVersion, not_supported_version: notSupportedVersion, current_version: currentVersion, app_update_message: appUpdateMessage)
        print("\(String(describing: appVersion))")
        
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
    
    
    private func getHostEndPoint(apiName: String , host: String) -> String?{
        let apiHost = self.apiHostHashMap[apiName]
        if hostToConnectHashMap[host] == "true"{
                if apiHost != nil{
                    return apiHost
                }else{
                    return self.hostHashMap[host]
                }
            }
        return nil
    }
    
}


