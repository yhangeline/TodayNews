//
//  MoyaNet.swift
//  YHNews
//
//  Created by yh on 2018/5/17.
//  Copyright © 2018年 YH. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

// 网络请求结构体
struct YHNetwork {
    
    // 请求成功的回调
    typealias successCallback = (_ result: Any) -> Void
    // 请求失败的回调
    typealias failureCallback = (_ error: MoyaError) -> Void
    
    // 单例
    static let provider = MoyaProvider<YHService>()
    static let ApiProvider = MoyaProvider<YHService>()

    // 发送网络请求
    static func request(
        target: YHService,
        success: @escaping successCallback,
        failure: @escaping failureCallback
        ) {
        
        
        provider.request(target) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    try success(moyaResponse.mapJSON()) // 测试用JSON数据
                } catch {
                    failure(MoyaError.jsonMapping(moyaResponse))
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}


enum YHService {
    case videoList
}

extension YHService: TargetType {
    
    // 请求服务器的根路径
    var baseURL: URL { return URL(string: "https://is.snssdk.com")! }
    
    // 每个API对应的具体路径
    var path: String {
        switch self {
        case .videoList:
            return "/api/news/feed/v75/"
        }
    }
    
    // 各个接口的请求方式，get或post
    var method: Moya.Method {
        switch self {
        case .videoList:
            return .get
        }
    }
    
    // 请求是否携带参数，如果需要参数，就做如demo2和demo3的设置
    var task: Task {
        switch self {
        case .videoList:
            let pullTime = Date().timeIntervalSince1970
            let params = ["device_id": device_id,
                          "count": "20",
                          "list_count": "1",
                          "category": "",
                          "min_behot_time": String(pullTime),
                          "strict": "0",
                          "detail": "1",
                          "refresh_reason": "1",
                          "tt_from": "auto",
                          "iid": iid]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    // 单元测试使用
    var sampleData: Data {
        switch self {
        case .videoList:
            return "just for test".data(using: String.Encoding.utf8)!
        }
    }
    
    // 请求头
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
    
}



