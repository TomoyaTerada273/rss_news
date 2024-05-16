//  NewsItem構造体を定義し、ニュースアイテムのプロパティを管理
//
//  NewsItem.swift
//  rss_news
//
//  Created by 寺田智哉 on 2024/05/15.
//

import Foundation

struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let link: String
    let pubDate: String
    let description: String
    let imageUrl: String
}

