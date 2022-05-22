//
//  UpcomingView.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 20.5.22..
//

import SwiftUI

struct UpcomingView<Data>: View
where Data: RandomAccessCollection,
      Data.Element: EventEntity {
    
    var events: Data
    
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            ForEach(events) { event in

                NavigationLink {
                    DetailsView(model: DetailsModel(event: event))
                } label: {
                    EventView(event: EventViewModel(event: event))
                        .frame(height: 220)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                }

                
            }
        }

    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        if let events = CoreDataHelper.getTestEventEntities() {
            VStack {
                UpcomingView(events: events)
                    
            }
            .background(Color.blue)
            
        }
    }
}
