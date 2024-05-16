//  RSSフィードのパースとニュースアイテムの管理を担当するNewsFeedParserクラスを定義
//  XMLParserDelegateプロトコルを採用し、RSSフィードのパースを処理
//
//  NewsFeedParser.swift
//  rss_news
//
//  Created by 寺田智哉 on 2024/05/15.
//

import Foundation
import Combine

class NewsFeedParser: NSObject, XMLParserDelegate, ObservableObject {
    @Published var newsItems = [NewsItem]()
    @Published var viewedItems: [NewsItem] = []

    private var currentElement = ""
    private var currentTitle = ""
    private var currentLink = ""
    private var currentPubDate = ""
    private var currentDescription = ""
    private var currentImageUrl = ""

    func parseFeed(url: String, completion: @escaping ([NewsItem]) -> Void) {
        guard let feedURL = URL(string: url) else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: feedURL) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                completion([])
                return
            }

            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()

            DispatchQueue.main.async {
                completion(self?.newsItems ?? [])
            }
        }.resume()
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentLink = ""
            currentPubDate = ""
            currentDescription = ""
            currentImageUrl = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title":
            currentTitle += string
        case "link":
            currentLink += string
        case "pubDate":
            currentPubDate += string
        case "description":
            currentDescription += string
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if let imageUrl = Utilities.extractImageUrl(from: currentDescription) {
                currentImageUrl = imageUrl
            }
            let newsItem = NewsItem(
                title: currentTitle.trimmingCharacters(in: .whitespacesAndNewlines),
                link: currentLink.trimmingCharacters(in: .whitespacesAndNewlines),
                pubDate: Utilities.formatDate(currentPubDate.trimmingCharacters(in: .whitespacesAndNewlines)),
                description: Utilities.stripHTMLTags(from: currentDescription.trimmingCharacters(in: .whitespacesAndNewlines)),
                imageUrl: currentImageUrl
            )
            DispatchQueue.main.async {
                if !self.newsItems.contains(where: { $0.link == newsItem.link }) {
                    self.newsItems.append(newsItem)
                }
            }
        }
    }

    func addToViewedItems(_ newsItem: NewsItem) {
        if !viewedItems.contains(where: { $0.link == newsItem.link }) {
            viewedItems.append(newsItem)
        }
    }
}
