//Created by me on 03/10/20

import CoreData
import SwiftUI

struct MemberView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showAffiliation = false
    @State private var randomNumber = Int.random(in:1...4)
    @State private var dragAmount = CGSize.zero
    
    var member: Member
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack{
                    Image("Arrow\(self.randomNumber)").resizable().frame(width:300,height:100)
                    
                    Text(self.member.name)
                        .font(.largeTitle)
                        .lineLimit(10)
                        .padding([.horizontal])
                    
                    Text(self.member.alterEgo)
                        .font(.title)
                        .lineLimit(10)
                        .padding([.horizontal,.bottom])
                    
                    Text(self.member.otherAffiliations)
                        .font(.title)
                        .lineLimit(10)
                        .padding([.horizontal,.bottom])
                        .blur(radius: self.showAffiliation ? 0 : 6)
                        .opacity(self.showAffiliation ? 1 : 0.25)
                }
                .multilineTextAlignment(.center)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .background(RoundedRectangle(cornerRadius: 25).fill(Color.white).shadow(color:.black,radius: 5,x:0,y:0))
                .onTapGesture {
                    withAnimation{
                        self.showAffiliation.toggle()
                    }
                    
                }
                .rotation3DEffect(.degrees(-Double(geo.frame(in:.global).minX/10)), axis: (x:0,y:1,z:0))
            }
            EmojiView(for:member.alterEgo)
                .font(.system(size:72))
        }
        .frame(minHeight:0,maxHeight: .infinity)
        .frame(minWidth:300)
        .offset(y:dragAmount.height)
        .gesture(
            DragGesture().onChanged{
                self.dragAmount=$0.translation
            }
            .onEnded{ value in
                if self.dragAmount.height < -200 {
                    withAnimation{
                        self.dragAmount = CGSize(width:0,height:-1000)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
                            self.moc.delete(self.member)
                            try? self.moc.save()
                        }
                    }
                } else {
                    self.dragAmount = .zero
                }
            }
        )
            .animation(.spring())
    }
}

struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        let member=Member(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
        member.name="Oliver Queen"
        member.alterEgo="Arrow"
        member.otherAffiliations="BRATVA"
        return MemberView(member: member)
    }
}
