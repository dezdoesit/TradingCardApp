//
//  Home.swift
//  ADAHiFi
//
//  Created by dmoney on 10/2/23.
//

import SwiftUI

struct Home: View {
   @State var cards: [Card] = [
        .init(cardColor: Color("Card 1"), name: "Dezmond Blair (He/Him)", cardDesc: "Hi my name is Dez. I like mtb and mango", cardCon: "dez@blair.com", cardNote: "Write notes about me here", proPic: Image("Pic 1"), cardPic: Image("CP2")),
        .init(cardColor: Color("Card 2"), name: "Leroy Whitt (Him/Him)", cardDesc: "Hi my name is Leroy. I like food and fun in the sun", cardCon: "leroy@whitt.com", cardNote: "Write notes about me here", proPic: Image("Pic 2"),cardPic: Image("CP3") ),
        .init(cardColor: Color("Card 3"), name: "Olga Kapustina (She/Her)", cardDesc: "Hi my name is Olga. I like travel and dogs", cardCon: "olga@kap.com", cardNote: "Write notes about me here", proPic: Image("Pic 4"), cardPic: Image("CP1")),
        .init(cardColor: Color("Card 4"), name: "Mohammad Wasi", cardDesc: "Hi my name is Wasi. I like sports and sleep", cardCon: "mohammad@wasi.com", cardNote: "Write notes about me here", proPic: Image("CP4"), cardPic: Image("Pic 3")),
    ]
    var size: CGSize
    @State private var expandCards = false
    @State var activeSheet = false
    @State private var showDetailView = false
    @State private var selectedCard: Card?
    @Namespace private var animation
    @State private var showDetailContent = false
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                //                Text("ADA")
                //                    .font(.largeTitle)
                Spacer()
                Button{
                }label: {
                    Image(systemName:"magnifyingglass")
                        .font(.title)
                        .foregroundColor(.purple)
                }
                Button{
//                    let card = Card(cardColor: .pink, name: "Test", cardDesc: "Test", cardCon: "Test", cardNote: "test", proPic: Image("Pic 1"), cardPic: Image("CP1"))
//                    cards.append(card)
                    activeSheet.toggle()
                    
                }label: {
                    Image(systemName: "plus")
                }
            }
            
            .padding()
            CardsView()
                .padding(.horizontal, 5)
            
        }
        .sheet(isPresented: $activeSheet, content: {
            CardCreatorView(cards: $cards)
        })
        .overlay(content: {
            if let selectedCard, showDetailView {
                DetailView(selectedCard)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
            }
        })
        .overlayPreferenceValue(CardRectKey.self) { preferences in
            if let cardPreference = preferences["CardRect"]{
                GeometryReader { proxy in
                    let cardRect = proxy[cardPreference]
                    
                    CardContent()
                        .frame(width: cardRect.width, height: expandCards ? nil : cardRect.height)
                        .offset(x: cardRect.minX, y: cardRect.minY)
                        .overlay(alignment: .top, content: {
                            Rectangle()
                                .fill(.ultraThinMaterial)
                            //                                .foregroundColor(.gray)
                                .ignoresSafeArea()
                                .frame(width: .infinity, height: 70)
                            //                                .opacity(expandCards ? 1 : 0)
                                .overlay(alignment: .top, content: {
                                    HStack{
                                        Image(systemName: "chevron.left")
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                withAnimation(.easeInOut(duration: 0.2)) {
                                                    expandCards = false
                                                }
                                            }
                                        Spacer()
                                        
                                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                            Image(systemName: "note.text.badge.plus")
                                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                                .contentShape(Rectangle())
                                            
                                        })
                                    }
                                    .padding(15)
                                })
                                .opacity(expandCards ? 1 : 0)
                            
                        })
                }
            }
        }
        
        
        
        
    }
    @ViewBuilder func DetailView(_ card: Card) -> some View {
        VStack(spacing: 0){
            HStack{
                Button{
                    withAnimation(.easeInOut(duration: 0.3)){
                        showDetailContent = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                        withAnimation(.easeInOut(duration: 0.35)){
                            showDetailView = false
                        }
                    }
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.title.bold())
                    
                }
                Spacer()
                
            }
            .foregroundColor(.black)
            .padding(15)
            .opacity(showDetailContent ? 1 : 0)
            CardView(card)
                .rotation3DEffect(.init(degrees: showDetailContent ? 0 : -15), axis: (x: 1, y: 0, z: 0), anchor: .top)
                .matchedGeometryEffect(id: card.id, in: animation)
                .frame(height: 500)
                .padding([.top], 15)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background{
            Rectangle()
                .fill(.clear)
                .ignoresSafeArea()
                .opacity(showDetailContent ? 1 : 0)
            
        }
    }
    
    
    @ViewBuilder
    func CardContent() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            //        List{
            VStack(spacing: 0) {
                ForEach(cards.reversed()) { card in
                    let index = CGFloat(indexOf(card))
                    let reversedIndex = CGFloat(cards.count - 1) - index
                    let displayingStackIndex = min(index,2)
                    let displayScale = (displayingStackIndex / CGFloat(cards.count)) * 0.05
                    
                    ZStack{
                        if selectedCard?.id == card.id && showDetailView{
                            Rectangle()
                                .foregroundColor(.clear)
                        } else {
                            CardView(card)
                            //3D Roto
                                .rotation3DEffect(.init(degrees: expandCards ? (showDetailView ? 0 : -15) : 0), axis: (x: 0, y: 0, z: 0), anchor: .top)
                                .matchedGeometryEffect(id: card.id, in: animation)
                                .offset(y: showDetailView ? (size.height * 3) : 0)
                                .onTapGesture {
                                    if expandCards {
                                        //Expand Selected Card
                                        selectedCard = card
                                        withAnimation(.easeInOut(duration: 0.35)){
                                            showDetailView = true
                                            
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                                            withAnimation(.easeInOut(duration: 0.35)){
                                                showDetailContent = true
                                                
                                            }
                                        }
                                    } else {
                                        withAnimation(.easeInOut(duration: 0.35)){
                                            expandCards = true
                                        }
                                    }
                                }
                            
                        }
                    }
                    .frame(height: 500)
                    .scaleEffect(1 - (expandCards ? 0 : displayScale))
                    .offset(y: expandCards ? 0 : (displayingStackIndex * -15))
                    .offset(y: reversedIndex * -425)
                    .padding(.top, expandCards ? (reversedIndex == 0 ? 0 : 435) : 0)
                }
            }
            .padding(.top, 45)
            .padding(.bottom, CGFloat(cards.count - 1) * -400)
            
        }
        //              .scrollDisabled(!expandCards)
    }
    
    func indexOf(_ card: Card) -> Int {
        return cards.firstIndex{
            card.id == $0.id
        } ?? 0
    }
    
    @ViewBuilder
    func CardView(_ card: Card) -> some View {
        GeometryReader{
            let size = $0.size
            
            VStack(spacing: 0) {
                Rectangle()
                    .fill(card.cardColor.gradient)
                    .overlay(alignment: .top){
                        VStack{
                            HStack{
                                Button(){
                                    
                                }label: {
                                    Image(systemName: "star")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.yellow)
                                        .shadow(color: .black ,radius: 3)
                                    //                                        .padding(.leading)
                                        .padding(.top)
                                    //                                        .padding(.leading)
                                }
                                Text(card.name)
                                    .font(.title2)
                                //                                    .padding(.leading)
                                    .padding(.top)
                                    .fontWeight(.bold)
                                Spacer()
                                card.proPic
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                //                                 .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .padding(.trailing)
                                    .padding(.top)
                            }
                            VStack() {
                                Text(card.cardDesc)
                                    .frame(width: .infinity, height: 1)
                                    .padding(.top)
                                    .padding(.bottom)
                                
                            }
                            VStack {
                                card.cardPic
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                //                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                    .padding(.top)
                            }
                            Spacer()
                            
                            HStack {
                                
                                Text(card.cardCon)
                                    .font(.subheadline)
                                    .padding()
                                    .offset(x: 0, y:40)
                                Spacer()
                            }
                            Spacer()
                            Divider()
                                .frame(width: .infinity, height: 2)
                                .overlay(.black)
                            HStack {
                                TextField("Write Notes about me here!", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                                    .padding()
                                //                                Button{
                                //
                                //                                }label: {
                                //                                    Image(systemName: "note.text")
                                //                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                //                                        .foregroundColor(.black)
                                //                                }
                                
                                //                                Text(card.cardNote)
                                //                                    .padding()
                                Spacer()
                                
                            }.padding(.leading)
                        }
                    }
            }
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            
        }
    }
    
    @ViewBuilder
    func CardsView() -> some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(height: 700)
        //hello
            .anchorPreference(key: CardRectKey.self, value: .bounds) { anchor in
                return ["CardRect": anchor]
                
            }
    }
}


#Preview {
    ContentView()
}
