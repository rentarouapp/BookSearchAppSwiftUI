//
//  Constants.swift
//  BookSearchAppSwiftUI
//
//  Created by 上條蓮太朗 on 2023/06/02.
//

import Foundation

class Constants {
    
    enum MockPerson {
        case steve_jobs
        case tim_cook
        case jony_ive
    }
    
    // タイトル
    public static let title: String = "タイトル"
    // 著者
    public static let author: String = "著者"
    // 発刊年月日
    public static let releasedDate: String = "発刊年月日"
    // 本の説明
    public static let bookDescription: String = "本の説明"
    // 画像なし
    public static let noImageIcon: String = "no_image"
    // お気に入り星マーク
    public static let star: String = "star"
    public static let starFill: String = "star.fill"
    // Safariマーク
    public static let safari: String = "safari"
    
    // お気に入りに追加
    public static let addFavorite: String = "お気に入りに追加"
    public static let openBrowser: String = "ブラウザで開く"
    
    // テスト
    public static let title_1: String = "スティーブ・ジョブズ捕物帖"
    public static let title_2: String = "クック・クッキング"
    public static let title_3: String = "かもめのジョナサン"
    
    public static let author_1: String = "Steve Jobs"
    public static let author_2: String = "Tim Cook"
    public static let author_3: String = "Jony Ive"
    
    public static let thumbUrl_1: String = "https://media.loom-app.com/gizmodo/dist/images/2018/07/31/180116_macbook_air_revealed_10years_ago.jpg?w=1280"
    public static let thumbUrl_2: String = "https://www.applemust.com/wp-content/uploads/2018/04/Apple_Chicago_wrapup_Tim_Cook_welcomes_Keynote_audience_to_Lane_Tech_College_Preparatory_High_School_03272018.jpg"
    public static let thumbUrl_3: String = "https://static.theceomagazine.net/wp-content/uploads/2019/07/10103645/jony-ive-apple-1100x733.jpg"
    
    public static let descriptionText: String = "あああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    
    public static var infoLink: String = "https://www.apple.com/apple-vision-pro/?&cid=wwa-jp-kwgo-avalanche-slid--Brand-Avalanche-Announce&mnid=s7F2l6cZ6-dc_mtid_2092567642642_pcrid_661168735388_pgrid_150513434832_pexid__&mtid=2092567642642&aosid=p238"
    
    // Mock
    static func getSampleBookItem(mockPerson: MockPerson) -> BookItem {
        
        var mockId: String = ""
        var mockTitle: String = ""
        var mockAuthros: [String] = []
        var mockImageThumb: String = ""
        
        switch mockPerson {
        case .steve_jobs:
            mockId = "1"
            mockTitle = Constants.title_1
            mockAuthros = [Constants.author_1]
            mockImageThumb = Constants.thumbUrl_1
            
        case .tim_cook:
            mockId = "2"
            mockTitle = Constants.title_2
            mockAuthros = [Constants.author_2]
            mockImageThumb = Constants.thumbUrl_2
            
        case .jony_ive:
            mockId = "3"
            mockTitle = Constants.title_3
            mockAuthros = [Constants.author_3]
            mockImageThumb = Constants.thumbUrl_3
        }
        
        
        let imageLinks: ImageLinks = ImageLinks(thumbnail: mockImageThumb,
                                                smallThumbnail: mockImageThumb)
        let volumeInfo: VolumeInfo = VolumeInfo(title: mockTitle,
                                                authors: mockAuthros,
                                                imageLinks: imageLinks,
                                                infoLink: Constants.infoLink,
                                                publishedDate: "2023-06-07",
                                                description: Constants.descriptionText)
        return BookItem(id: mockId, volumeInfo: volumeInfo)
    }
    
}
