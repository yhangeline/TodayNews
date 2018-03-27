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
    static func loadApiNewsFeeds(completionHandler: @escaping (_ newsArray: [NewsModel]) -> ())
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
                } catch  {
                    print("解析失败:\(error)")
                }
            }
            completionHandler(dataSource) 
        }
    }
    
    static func loadApiNewsFeeds(completionHandler: @escaping (_ newsArray: [NewsModel]) -> ()) {
        let pullTime = Date().timeIntervalSince1970
        let url = BASE_URL + "/api/news/feed/v75/"
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
        NetWorkManager.request(url: url, parameters: params) { (response) in
            let dic = response as! Dictionary<String,Any>
            let datas = dic["data"] as! Array<Any>
            var dataArray = [NewsModel]()
            for item in datas {
                let jsonString = (item as! Dictionary<String,Any>)["content"] as! String
                
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(NewsModel.self, from: jsonString.data(using: String.Encoding.utf8)!)
                    dataArray.append(model)
                } catch  {
                    print("解析失败:\(error)")
                }
            }
            completionHandler(dataArray)
        }
    }
}

struct NetWorkTool: NetworkToolProtocol {}

