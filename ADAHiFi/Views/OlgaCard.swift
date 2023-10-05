//
//  OlgaCard.swift
//  ADAHiFi
//
//  Created by dmoney on 10/4/23.
//

import SwiftUI




struct OlgaCard: View {
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.blue)
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
                            Text("card.name")
                                .font(.title2)
//                                    .padding(.leading)
                                .padding(.top)
                                .fontWeight(.bold)
                            Spacer()
                            Image("Pic 1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
//                                 .clipShape(RoundedRectangle(cornerRadius: 15))
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .padding(.trailing)
                                .padding(.top)
                        }
                        VStack() {
                            Text("card.cardDesc")
                                .frame(width: .infinity, height: 1)
                                .padding(.top)
                                .padding(.bottom)
                            
                        }
                        VStack {
                            Image("CP1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            //                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                .padding(.top)
                        }
                        Spacer()
                        
                        HStack {
                            
                            Text("card.cardCon")
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
                            Button{
                                
                            }label: {
                                Image(systemName: "note.text")
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.black)
                            }
                            
                            Text("card.cardNote")
                                .padding()
                            Spacer()
                            
                        }.padding(.leading)
                    }
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))    }
}

#Preview {
    OlgaCard()
}
