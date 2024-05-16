//  WebViewを包含し、閲覧履歴の管理を行うWebViewWrapper構造体を定義
//
//  WebViewWrapper.swift
//  rss_news
//
//  Created by 寺田智哉 on 2024/05/15.
//

import SwiftUI

struct WebViewWrapper: View {
    let url: URL
    let newsItem: NewsItem
    @EnvironmentObject var newsFeedParser: NewsFeedParser

    var body: some View {
        WebView(url: url)
            .onAppear {
                newsFeedParser.addToViewedItems(newsItem)
            }
    }
}
