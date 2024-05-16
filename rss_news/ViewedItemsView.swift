//  閲覧済みアイテムの一覧を表示するためのViewedItemsView構造体を定義
//
//  ViewedItemsView.swift
//  rss_news
//
//  Created by 寺田智哉 on 2024/05/15.
//

import SwiftUI

struct ViewedItemsView: View {
    @ObservedObject var newsFeedParser: NewsFeedParser

    var body: some View {
        NavigationView {
            List(newsFeedParser.viewedItems) { newsItem in
                NavigationLink(destination: WebViewWrapper(url: URL(string: newsItem.link)!, newsItem: newsItem)) {
                    VStack(alignment: .leading) {
                        Text(newsItem.title)
                            .newsItemTitleStyle()
                        Text(newsItem.pubDate)
                            .newsItemPubDateStyle()
                    }
                }
            }
            .navigationTitle("Viewed Items")
        }
    }
}


