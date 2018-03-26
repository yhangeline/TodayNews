//
//  NetWorkTool.swift
//  YHNews
//
//  Created by yh on 2018/3/23.
//  Copyright © 2018年 YH. All rights reserved.
//

import Foundation

protocol NetworkToolProtocol {
    static func loadHomeNewTitleData(completionHandler: @escaping (_ newsTitles: [HomeTitleModel]) -> ())
}

extension NetworkToolProtocol {
    static func loadHomeNewTitleData(completionHandler: @escaping (_ newsTitles: [HomeTitleModel]) -> ()) {
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        NetWorkManager.request(url: url, parameters: params) { (res) in
            let dic = res as! Dictionary<String,Any>
            let datas = dic["data"] as! Dictionary<String,Any>
            let dataArray = datas["data"] as! [Any]
            var dataSource = [HomeTitleModel]()
            for dic in dataArray {
                let data = try! JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(HomeTitleModel.self, from: data)
                    dataSource.append(model)
//                    print("解析成功:\(model)")
                } catch  {
                    print("解析失败:\(error)")
                }
            }
            completionHandler(dataSource) 
        }
    }
}

struct NetWorkTool: NetworkToolProtocol {}

