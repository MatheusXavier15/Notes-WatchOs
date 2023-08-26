//
//  DetailView.swift
//  Notes Watch App
//
//  Created by Matheus Xavier on 25/08/23.
//

import SwiftUI

struct DetailView: View {
    // MARK: - PROPERTIES
    
    let note: Note
    let count: Int
    let index: Int
    
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            HStack {
                Capsule()
                    .frame(height: 1)
                Image(systemName: "note.text")
                Capsule()
                    .frame(height: 1)
            }
            .foregroundColor(.accentColor)
            Spacer()
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            HStack(alignment:.center) {
                Button {
                    
                } label: {
                    Image(systemName: "gear")
                        .imageScale(.large)
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
                Text("\(index + 1) / \(count)")
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .foregroundColor(.secondary)
        }
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(note: Note(id: UUID(), text: "Teste"), count: 5, index: 1)
    }
}
