//
//  Card.swift
//  ADAHiFi
//
//  Created by dmoney on 10/2/23.
//

import SwiftUI

///Card Model / Data
struct Card: Identifiable{
    var id : UUID = .init()
    var cardColor : Color
    var name : String
    var cardDesc : String
    var cardCon : String
    var cardNote : String
    var proPic : Image
    var cardPic : Image
}

var cards: [Card] = [
    .init(cardColor: Color("Card 1"), name: "Dezmond Blair (He/Him)", cardDesc: "Hi my name is Dez. I like mtb and mango", cardCon: "dez@blair.com", cardNote: "Write notes about me here", proPic: Image("Pic 1"), cardPic: Image("CP2")),
    .init(cardColor: Color("Card 2"), name: "Leroy Whitt (Him/Him)", cardDesc: "Hi my name is Leroy. I like food and fun in the sun", cardCon: "leroy@whitt.com", cardNote: "Write notes about me here", proPic: Image("Pic 2"),cardPic: Image("CP3") ),
    .init(cardColor: Color("Card 3"), name: "Olga Kapustina (She/Her)", cardDesc: "Hi my name is Olga. I like travel and dogs", cardCon: "olga@kap.com", cardNote: "Write notes about me here", proPic: Image("Pic 4"), cardPic: Image("CP1")),
    .init(cardColor: Color("Card 4"), name: "Mohammad Wasi", cardDesc: "Hi my name is Wasi. I like sports and sleep", cardCon: "mohammad@wasi.com", cardNote: "Write notes about me here", proPic: Image("CP4"), cardPic: Image("Pic 3")),
]
