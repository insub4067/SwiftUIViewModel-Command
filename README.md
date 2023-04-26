# SwiftUIViewModel-Command

## 🤔 해결하고자 하는 문제
소셜 서비스 등에서 List 와 Detail 페이지를 다루는 화면에서 Detail Page 에서 변경된 내용을 List Page 에서도 동일하게 변경된 화면을 보여줘야하는 페이지들이 있습니다.  
예를 들면 좋아요, 댓글등이 있습니다. 이러한 페이지들에서 Detail Page 에서 변경된 내용을 Delegate 를 통해 List Page ViewModel 에게 전달하는 시도를 해보았습니다.  

## 💡 이전에 했던 시도와 Commad Pattern 을 사용하게된 이유
이전에 EnvironmentObject 를 통해 ModelData 에 직접 접근해 값을 참조하고 수정하는 방법을 시도했습니다.  
이러한 시도에서 발견된 문제는 Detail Page 와 List Page 의 관계가 일대다인 경우에 발견 되었습니다.  
예를 들면 Detail Page 를 컴포넌트화해 사용하는 ListView 가 여러 페이지인 경우, Detail Page 에서 여러개의 EnvironmentObject 를 선언해놓고 
잘못 참조하는 경우 앱이 Crash 나는 등 예외 처리해줘야하는 경우의 수가 늘어나고 실수를 할수 있는 위험성이 높았습니다.  
때문에 Protocol 로 추상화를 하여 Parent List View 의 ViewModel 을 호출하는 방법으로 문제를 해결하고자 했습니다.

## 📱 화면과 예시
<img src="https://user-images.githubusercontent.com/85481204/234418319-6111c021-b488-4b69-8462-4e70987d020c.gif" width="250">

✓ ListView
```
struct ListView: View {

    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        ForEach(Array(viewModel.items.enumerated()), id: \.offset) { offset, item in
            DetailItemView(item: item, offset: offset, delegate: viewModel)
        }
    }
}
```

✓ DetailView
```
struct DetailItemView: View {
    
    @State var item: Item
    let offset: Int
    
    weak var command: ItemCommand?

    var body: some View {
            // 좋아요 
            Image()
                .onTapGesture { didTapItem() }
    }
    
    func didTapItem() {
        item.isLiked.toggle()
        command?.didTapIsLike(offset: offset)
    }
}
```

##  📚 참고
서적 : [헤드퍼스트 디자인 패턴](https://www.hanbit.co.kr/store/books/look.php?p_code=B6113501223)
