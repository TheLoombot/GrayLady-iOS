//
//  ManageContentful.swift
//  Gray Lady
//
//  Created by David on 1/6/17.
//  Copyright © 2017 QTScoder. All rights reserved.
//

import UIKit
import Contentful
class ManageContentful {
    let client = Client(spaceIdentifier: Constrant.keyContentful.space, accessToken: Constrant.keyContentful.token)
    static let sharedInstance = ManageContentful()

    func getEntryTypeBriefing (_ completer:@escaping ([Entry]?) -> Void) {

    _ = client.fetchEntries(matching: [Constrant.keyAPI.content_type : "briefing"]) { (resulft) in

            switch resulft {
            case let .success(entry):
                var array = [Entry]()
                for item in entry.items {
                    array.append(item)
                }
                completer(array)

            case .error(_):
                completer(nil)
            }
        }


        
    }

    func getTitleAndAuthor(_ entryBriefing: Entry) ->(title: String, author: String) {

        var titleStr = ""
        var authorStr = ""
        if let titLe = entryBriefing.fields["briefingTitle"] as? String {
            titleStr = titLe
        }
        if let au = entryBriefing.fields["briefingAuthor"] as? String {
            authorStr = au
        }

        return (titleStr, authorStr)
    }

    func getPiecefromBriefing(_ entryBriefing: Entry) -> [Entry] {
        var arr = [Entry]()
        if let arrDate = entryBriefing.fields["piece"] as? [Entry] {
            arr = arrDate

        }
        return arr

    }

    func getInfoPiece_fromBriefing(_ entry: Entry) -> (imgCaption: String, pieceContent: String, urlImg: String) {
        var imageCap = ""
        var pieceText = ""
        var url_Img = ""

        if let imgCapTemp = entry.fields["imageCaption"] as? String {
            imageCap = imgCapTemp
        }

        if let pieceTextTemp = entry.fields["pieceTextContent"] as? String {
            pieceText = pieceTextTemp
        }

        if let assetUrl = entry.fields["image"] as? Asset {
            if let dict = assetUrl.fields["file"] as? NSDictionary {
                if let str = dict["url"] as? String {
                    url_Img = "http:" + str
                }
            }
        }       

        return(imageCap, pieceText, url_Img)
        
        
    }





}