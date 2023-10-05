//
//  CardCreatorView.swift
//  ADAHiFi
//
//  Created by dmoney on 10/5/23.
//

import SwiftUI
import PhotosUI




struct CardCreatorView: View {
    
    @Binding var cards : [Card]
    @State private var name = ""
    @State private var desc = ""
    @State private var contact = ""
    @State private var note = ""
    @State private var CColor = Color.blue
    
    var body: some View {
        Form{
            TextField("Enter your name and pronouns", text: $name)
            TextField("Enter a short description", text: $desc)
            TextField("Enter your contact information", text: $contact)
            TextField("This isnt real", text: $note)
            ColorPicker("Pick the color of your card!", selection: $CColor)



        }.onDisappear{
            let newCard = Card(cardColor: CColor, name: name, cardDesc: desc, cardCon: contact, cardNote: note, proPic: Image(systemName: "person.fill") , cardPic: Image(systemName: "person.fill"))
            cards.append(newCard)
        }

    }
}

//#Preview {
//    CardCreatorView()
//}
