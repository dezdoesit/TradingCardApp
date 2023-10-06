//
//  CardCreatorView.swift
//  ADAHiFi
//
//  Created by dmoney on 10/5/23.
//

import SwiftUI
import PhotosUI




struct CardCreatorView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    @Binding var cards : [Card]
    @State private var name = ""
    @State private var desc = ""
    @State private var contact = ""
    @State private var note = ""
    @State private var CColor = Color.blue
    
    var body: some View {
        
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            } else {
                Text("No Image Selected")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            
            Button(action: {
                self.showImagePicker = true
            }) {
                Text("Add Image")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        
        
        Form{
            TextField("Enter your name and pronouns", text: $name)
            TextField("Enter a short description", text: $desc)
            TextField("Enter your contact information", text: $contact)
            TextField("This isnt real", text: $note)
            ColorPicker("Pick the color of your card!", selection: $CColor)



        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: self.$selectedImage)
        }
        
        .onDisappear{
            let newCard = Card(cardColor: CColor, name: name, cardDesc: desc, cardCon: contact, cardNote: note, proPic: Image(systemName: "person.fill") , cardPic: Image(systemName: "person.fill"))
            cards.append(newCard)
        }

    }
}

//#Preview {
//    CardCreatorView()
//}
