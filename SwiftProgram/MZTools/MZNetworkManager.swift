//
//  MZNetworkManager.swift
//  SwiftProgram
//
//  Created by Mr.Z on 2020/5/14.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

import UIKit
import Alamofire

public typealias SuccessBlock = (_ dict: [String: Any]) -> ()
public typealias FailureBlock = (_ error: Error) -> ()
public typealias ProgressBlock = (_ progress: Double) -> ()

class MZNetworkManager: NSObject {
    
    /// 单例
    static var shareManager: MZNetworkManager {
        struct Share {
            static let manager = MZNetworkManager()
        }
        return Share.manager
    }
    
    /// get请求
    public func get(urlStr: String, params: [String: Any]?, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        self.request(urlStr, method: .get, params: params, success: success, failure: failure)
    }
    
    /// post请求
    public func post(urlStr: String, params: [String: Any]?, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        self.request(urlStr, method: .post, params: params, success: success, failure: failure)
    }

    /// 网络请求
    private func request(_ urlString: String, method: HTTPMethod, params: Parameters? = nil, success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        let manager = SessionManager.init()
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15.0
        config.timeoutIntervalForResource = 15.0
        config.requestCachePolicy = .useProtocolCachePolicy
//        if WPUserInfoManager.shareManager.token != "" {
//            manager.requestSerializer.setValue(WPUserInfoManager.shareManager.token, forHTTPHeaderField: "Authorization")
//        }
        if method == .get {
            
        } else if method == .post {
           
        }
}
