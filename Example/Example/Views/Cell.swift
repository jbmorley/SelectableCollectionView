// Copyright (c) 2022-2024 Jason Morley
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

struct Cell: View {

    private struct LayoutMetrics {
        static var cornerRadius = 9.0
        static var selectionSpacing = 2.0
        static var selectionLineWidth = 3.0
        static var selectionCornerRadius = 14.0

        static var cellPadding: CGFloat {
            return selectionSpacing + selectionLineWidth
        }
    }

    @Environment(\.isSelected) var isSelected
    @Environment(\.highlightState) var highlightState
    @Environment(\.selectionColor) var selectionColor

    var item: Item
    var isPainted: Bool

    var strokeColor: Color {
        return isSelected || highlightState == .forSelection ? selectionColor : Color.clear
    }

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "circle.fill")
                    .foregroundColor(item.color)
                Text("#\(item.color.hexCode)")
                Spacer()
            }
            Spacer()
        }
        .background(isPainted ? .mint : item.color.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: LayoutMetrics.cornerRadius))
        .padding(LayoutMetrics.cellPadding)
        .overlay(RoundedRectangle(cornerRadius: LayoutMetrics.selectionCornerRadius)
            .strokeBorder(strokeColor, lineWidth: LayoutMetrics.selectionLineWidth))
    }
}
