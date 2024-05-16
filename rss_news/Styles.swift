//  カスタムのビュースタイルやモディファイアを定義
//
//  Styles.swift
//  rss_news
//
//  Created by 寺田智哉 on 2024/05/15.
//

import SwiftUI

struct NewsItemTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.primary)
    }
}

struct NewsItemPubDateStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.gray)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct NewsItemDescriptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .lineLimit(0)
            .foregroundColor(.primary)
    }
}

extension View {
    func newsItemTitleStyle() -> some View {
        self.modifier(NewsItemTitleStyle())
    }

    func newsItemPubDateStyle() -> some View {
        self.modifier(NewsItemPubDateStyle())
    }

    func newsItemDescriptionStyle() -> some View {
        self.modifier(NewsItemDescriptionStyle())
    }
}

