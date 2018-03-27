//
//  Models.swift
//  YHNews
//
//  Created by yh on 2018/3/23.
//  Copyright © 2018年 YH. All rights reserved.
//

import Foundation

struct HomeTitleModel:Codable {
    var category:String?
    var concern_id:String?
    var default_add:Int?
    var flags:Int?
    var icon_url:String?
    var name:String?
    var tip_new:Int?
    var type:Int?
    var web_url:String?
}

struct NewsModel: Decodable {
    var abstract: String?
    var article_url: String?
    var display_url: String?
    
}

struct VideoModel: Decodable {
    var read_count: Int?
    var title: String?
    var video_duration: Int?
    
    var name: String {
        get {
            return self.user_info?.name ?? ""
        }
    }
    
    var avatar_url: String {
        get {
            return self.user_info?.avatar_url ?? ""
        }
    }
    
    var video_imgUrl: String {
        get {
            return self.video_detail_info?.detail_video_large_image?.url ?? ""
        }
    }
    
    var video_watch_count: Int {
        get {
            return self.video_detail_info?.video_watch_count ?? 0
        }
    }
    
    
    
    var user_info:user_info?
    var video_detail_info:video_detail_info?

    struct user_info: Decodable {
        var avatar_url: String?
        var name: String?
        
    }
    
    struct video_detail_info: Decodable {
        
        var video_id: String?
        var video_watch_count: Int?
        var detail_video_large_image: detail_video_large_image?
        
    }
    
    struct detail_video_large_image: Decodable {
        var url: String?
        
    }
}


