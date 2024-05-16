//  アプリのメインビューであるContentView構造体を定義
//  タブバーとそれぞれのタブに対応するビューを管理
//
//  ContentView.swift
//  rss_news
//
//  Created by 寺田智哉 on 2024/05/15.

import SwiftUI

struct ContentView: View {
    @StateObject private var newsFeedParser = NewsFeedParser()

    var body: some View {
        TabView {
            NewsListView(feedUrl: Constants.worldNewsFeedUrl)
                .tabItem {
                    Label("World", systemImage: "globe")
                }
            NewsListView(feedUrl: Constants.domesticNewsFeedUrl)
                .tabItem {
                    Label("Domestic", systemImage: "house")
                }
            NewsListView(feedUrl: Constants.businessNewsFeedUrl)
                .tabItem {
                    Label("Business", systemImage: "briefcase")
                }
            NewsListView(feedUrl: Constants.technologyNewsFeedUrl)
                .tabItem {
                    Label("Technology", systemImage: "desktopcomputer")
                }
            NewsListView(feedUrl: Constants.entertainmentNewsFeedUrl)
                .tabItem {
                    Label("Entertainment", systemImage: "tv")
                }
            NewsListView(feedUrl: Constants.sportsNewsFeedUrl)
                .tabItem {
                    Label("Sports", systemImage: "sportscourt")
                }
            NewsListView(feedUrl: Constants.scienceNewsFeedUrl)
                .tabItem {
                    Label("Science", systemImage: "flask")
                }
            NewsListView(feedUrl: Constants.lifeNewsFeedUrl)
                .tabItem {
                    Label("Life", systemImage: "heart")
                }
            NewsListView(feedUrl: Constants.localNewsFeedUrl)
                .tabItem {
                    Label("Local", systemImage: "map")
                }
            ViewedItemsView(newsFeedParser: newsFeedParser)
                .tabItem {
                    Label("Viewed", systemImage: "clock")
                }
        }
        .environmentObject(newsFeedParser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
