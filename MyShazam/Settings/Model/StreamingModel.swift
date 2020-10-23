//
//  StreamingModel.swift
//  MyShazam
//
//  Created by Shimon Azulay on 23/10/2020.
//

struct StreamingModel
{
    var streamingName: String
    var streamingInfo: String
    var actionName: String
}

extension StreamingModel: CollectionSectionItemModelProtocol
{
    var identifier: String {
        "StreamingCell"
    }
}

extension StreamingModel
{
    static func createData() -> [StreamingModel]
    {
        [StreamingModel(streamingName: "APPLE MUSIC", streamingInfo: "", actionName: "TRY NOW"),
         StreamingModel(streamingName: "SPOTIFY", streamingInfo: "", actionName: "CONNECT")]
    }
}
