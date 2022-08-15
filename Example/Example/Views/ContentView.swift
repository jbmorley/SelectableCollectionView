// Copyright (c) 2022 Jason Morley
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Combine
import SwiftUI

import SelectableCollectionView

struct ContentView: View {

    @StateObject var model = Model()

    var body: some View {
        HStack {
            if let layout = model.layoutMode.layout {
                SelectableCollectionView(model.filteredItems, selection: $model.selection, layout: layout) { item in
                    Cell(item: item, isPainted: model.isPainted)
                } contextMenu: { selection in
                    if !selection.isEmpty {
                        MenuItem("Delete") {
                            model.items.removeAll { selection.contains($0) }
                        }
                    }
                }
            } else {
                Table(model.filteredItems, selection: $model.selection) {
                    TableColumn("Title", value: \.text)
                    TableColumn("Color", value: \.color.description)
                }
            }
        }
        .searchable(text: $model.filter)
        .toolbar {
            LayoutToolbar(mode: $model.layoutMode)
            SelectionToolbar(id: "selection")
            StateToolbar(id: "state")
            ItemsToolbar(id: "items")
        }
        .navigationSubtitle("\(model.items.count) items")
        .onAppear {
            model.run()
        }
        .environmentObject(model)
        .frame(minWidth: 400, minHeight: 400)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}