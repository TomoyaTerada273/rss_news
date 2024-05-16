//  日付のフォーマットやHTMLタグの除去など、ユーティリティ関数を定義
//
//  Utilities.swift
//  rss_news
//
//  Created by 寺田智哉 on 2024/05/15.
//

import Foundation

struct Utilities {
    static func formatDate(_ pubDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = formatter.date(from: pubDate) {
            let jstFormatter = DateFormatter()
            jstFormatter.dateFormat = "yyyy/MM/dd HH:mm"
            jstFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
            return jstFormatter.string(from: date)
        }
        return pubDate
    }

    static func stripHTMLTags(from string: String) -> String {
        let data = string.data(using: .utf8)!
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        return attributedString?.string ?? string
    }

    static func extractImageUrl(from description: String) -> String? {
        let pattern = "<img[^>]+src=\"([^\"]+)\""
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let nsString = description as NSString
        let results = regex?.matches(in: description, options: [], range: NSRange(location: 0, length: nsString.length))
        return results?.first.map { nsString.substring(with: $0.range(at: 1)) }
    }
}
