//Created by me on 27/09/20

import SwiftUI

struct EmojiView: View {
    var alterEgo: String
    
    var body: some View {
           
               switch alterEgo {
               case "Arrow":
                   return Text("🏹")
               case "Overwatch":
                   return Text("👩🏼‍💻")
               case "Spartan":
                   return Text("♞")
               default:
                   return Text("😑")
               }
           }
           init(for alterEgo:String) {
               self.alterEgo=alterEgo
           }
    
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView(for: "Arrow")
    }
}
