//  ニュース一覧を表示するためのNewsListView構造体を定義
//  NewsFeedParserを使用してニュースアイテムを取得し、表示
//
//  NewsListView.swift
//  rss_news
//
//  Created by 寺田智哉 on 2024/05/15.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var newsFeedParser = NewsFeedParser()
    let feedUrl: String

    var body: some View {
        NavigationView {
            List(newsFeedParser.newsItems) { newsItem in
                NavigationLink(destination: WebViewWrapper(url: URL(string: newsItem.link)!, newsItem: newsItem)) {
                    VStack(alignment: .leading) {
                        Text(newsItem.title)
                            .newsItemTitleStyle()
                        Text(newsItem.pubDate)
                            .newsItemPubDateStyle()
                        if !newsItem.imageUrl.isEmpty {
                            AsyncImage(url: URL(string: newsItem.imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                         .aspectRatio(contentMode: .fit)
                                case .failure:
                                    Image(systemName: "photo")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(maxHeight: 200)
                        }
                        Text(newsItem.description)
                            .newsItemDescriptionStyle()
                    }
                }
            }
            .navigationTitle("News")
        }
        .onAppear {
            newsFeedParser.parseFeed(url: feedUrl) { _ in }
        }
    }
}
