//
//  OKLogViewer.swift
//  OctopusKit
//
//  Created by ShinryakuTako@invadingoctopus.io on 2020-05-21
//  Copyright © 2020 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

import SwiftUI

/// A container for a collection of logs.
public struct OKLogBinder: View {
    
    let logs: [OKLog]
    
    @State var selectedLogIndex: Int = 0
    
    public init(logs: [OKLog]) {
        self.logs = logs
    }
    
    public var body: some View {
        OKLogViewer(logs[selectedLogIndex])
    }
}

/// Displays a single log with filtering controls.
public struct OKLogViewer: View {
    
    let log: OKLog
    
    public init(_ log: OKLog) {
        self.log = log
    }
    
    public var body: some View {
        // TODO: Filtering controls
        OKLogList(log)
    }
}

/// Lists all the entries in a log.
public struct OKLogList: View {
    
    let log: OKLog
    
    public init(_ log: OKLog) {
        self.log = log
    }
    
    public var body: some View {
        List(log.entries) { entry in
            OKLogEntryView(entry)
        }
        .listRowBackground(Rectangle().foregroundColor(.red))
    }
}

/// A persistent flag to changing the color of alternating rows for better readability.
fileprivate var rowColorAlternator: Bool = false

/// Displays a single log entry.
public struct OKLogEntryView: View {
    
    let entry: OKLogEntry
    
    var rowColor: Color {
        rowColorAlternator.toggle()
        return (rowColorAlternator ? Color(OSColor.systemIndigo) : Color.clear)
    }
    
    public init(_ entry: OKLogEntry) {
        self.entry = entry
    }
    
    public var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack(alignment: .firstTextBaseline) { // Header
                
                HStack {
                    title
                        .layoutPriority(0)
                    
                    time
                        .foregroundColor(entry.isNewFrame ? .red : Color(OSColor.systemGray)) // TODO: tertiaryLabel / tertiaryLabelColor :(
                        .layoutPriority(1)
                }
                .layoutPriority(1)
                
                topic
                    .font(.caption)
                
            }
            .lineLimit(1)
            .padding(2)
            .foregroundColor(Color(OSColor.systemGray)) // TODO: tertiaryLabel / tertiaryLabelColor :(
            
            Text(entry.text)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
                .padding(2)
                .layoutPriority(1)
            
        }
        .font(.system(size: 13))
        .padding(2)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(self.rowColor)
                .opacity(0.1)
        )
    }
    
    // MARK: Subviews
    
    /// Log Title
    var title: some View {
        Text(entry.title)
            .opacity(0.75)
    }
    
    /// Time and Frame
    var time: some View {
        HStack {
            Text("\(entry.time, formatter: OKLog.timeFormatter)")
                .font(.caption)
                .layoutPriority(1)
            
            Text("F\(String(entry.frame).paddedWithSpace(toLength: 5))")
                .font(.caption)
                .layoutPriority(2)
        }
        .lineLimit(1)
        .truncationMode(.head)
    }
    
    /// Topic and Function
    var topic: some View {
        HStack {
            Text(entry.topic)
                .fontWeight(.bold)
                .truncationMode(.head)
            
            Spacer()
            
            Text(entry.function)
                .fontWeight(.bold)
                .truncationMode(.middle)
        }
    }
    
}

/*
struct OKLogBinder_Previews: PreviewProvider {
    static var previews: some View {
        
        let log = try! JSONDecoder().decode(OKLog.self, from: previewLog.data(using: .utf8)! )
        
        return LogBinder(logs: [log])
    }
}
*/