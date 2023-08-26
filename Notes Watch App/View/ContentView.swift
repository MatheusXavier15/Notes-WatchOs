//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Matheus Xavier on 25/08/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    private let documentDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    // MARK: - FUNCTIONS
    
    func save(){
        do {
            let data = try JSONEncoder().encode(notes)
            let url = documentDirectory.appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Saving date has failed.")
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                let url = documentDirectory.appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                print("No data loaded.")
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .center, spacing: 6) {
                    TextField("Add new note", text: $text)
                    Button {
                        guard text.isEmpty == false else { return }
                        let note = Note(id: UUID(), text: text)
                        notes.append(note)
                        text = ""
                        save()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(BorderedButtonStyle(tint: .accentColor))
                    .fixedSize()
                }
                .onAppear {
                    load()
                }
                Spacer()
                
                if notes.count > 0 {
                    List {
                        ForEach(0..<notes.count, id: \.self) { i in
                            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i), label: {
                                HStack {
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundColor(.accentColor)
                                    Text(notes[i].text)
                                        .lineLimit(1)
                                        .padding(.leading, 5)
                                }
                            })
                        }
                        .onDelete(perform: delete)
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(15)
                    Spacer()
                }
            }
            .navigationTitle(Text("Notes"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
