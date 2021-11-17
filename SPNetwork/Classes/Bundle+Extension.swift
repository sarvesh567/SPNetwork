//
//  Bundle+Extension.swift
//  SPNetwork
//
//  Created by Amit Sharma on 17/11/21.
//

import Foundation
public class AppBundle: Bundle{
    var getBundleIdentifier: String?{
        return bundleIdentifier
    }
    var getAppVersion: String?{
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildNumber: String?{
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var appName: String?{
        return infoDictionary?["CFBundleName"] as? String
    }
}
