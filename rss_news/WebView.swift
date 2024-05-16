//  WKWebViewを使用してWebページを表示するためのWebView構造体を定義
//
//  WebView.swift
//  rss_news
//
//  Created by 寺田智哉 on 2024/05/15.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}


