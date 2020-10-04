//Created by me on 27/09/20

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Member.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Member.name, ascending: true)]) var members:FetchedResults<Member>
    
    @State private var showAddMember = false
    
    var body: some View {
        //        VStack {
        //            NavigationView {
        //                List {
        //                    ForEach(members,id:\.alterEgo){ member in
        //                        NavigationLink(destination: Text(member.otherAffiliations)){
        //                            EmojiView(for: member.alterEgo)
        //                            Text(member.name)
        //                        }
        //                    }
        //                    .onDelete(perform: removeMembers)
        //                }
        //                .navigationBarTitle("Team Arrow")
        //                .navigationBarItems(leading:EditButton(),trailing: Button("Add Member"){
        //                    self.showAddMember.toggle()
        //                })
        //
        //
        //            }
        //            Text("").sheet(isPresented: $showAddMember){
        //                AddMemberView().environment(\.managedObjectContext,self.moc)
        //            }
        //        }
        ZStack(alignment:.top) {
            LinearGradient(gradient: Gradient(colors: [Color("Start"),Color("Middle"),Color("End")]), startPoint: .top, endPoint: .bottom)
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(members,id:\.alterEgo){member in
                        MemberView(member: member)
                    }
                }
            }
            
            
            Button("Add Member"){
                self.showAddMember.toggle()
            }
            .padding()
            .background(Color.black.opacity(0.5))
            .clipShape(Capsule())
            .foregroundColor(.white)
            .offset(y:50)
            
            Text("").sheet(isPresented: $showAddMember){
                AddMemberView().environment(\.managedObjectContext,self.moc)
            }
        }.edgesIgnoringSafeArea(.all)
        
    }
    func removeMembers(at offsets:IndexSet){
        for index in offsets {
            let member=members[index]
            moc.delete(member)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
