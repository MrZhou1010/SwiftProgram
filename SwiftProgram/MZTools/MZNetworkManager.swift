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
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15.0
        configuration.timeoutIntervalForResource = 15.0
        configuration.requestCachePolicy = .useProtocolCachePolicy
        let session = Session.init(configuration: configuration, delegate: SessionDelegate())
        session.request(urlString, method: method, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                success(value as? [String: Any] ?? [String: Any]())
            case .failure(let error):
                failure(error)
            }
        }
    }
}
