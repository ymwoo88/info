# 다양한 자료들이 모이는 곳

# 배치성 프로세스 작성
### 배치 성 로직 개발 시 응답이 느린 경우를 해소하기 위해 Executors 사용
```
        ExecutorService executor =  Executors.newSingleThreadExecutor();
        executor.submit(() -> batchService.updateRecommendSchedulerByCity());

        // 더이상 ExecutorService에 Task를 추가할 수 없습니다.
        executor.shutdown();

```

# 람다식
### 람다식에서 final변수를 사용해야하는 이유
왜 final 제약 조건을 걸어 두었을까?

인스턴스 변수는 heap영역에 저장이 되고, 지역 변수는 stack영역에 위치한다.

이런 상황에서 람다가 스레드에서 실행된 후, 변수를 할당한 스레드가 사라져 stack 메모리에서 해제되었으나, 람다를 실행하는 스레드는 살아 있어 해당 변수에 접근을 요청할 케이스가 생긴다.

이와 같은 이유로 ,

실제 변수에 접근을 허용하는 것이 아닌 해당 변수의 복사본을 만들어 그 곳에 접근을 허용하는데

당연히 처음에 복사한 값과 원본의 값이 달라지면 안되기 때문에, 람다에서 접근하는 지역 변수는 final로 선언되어야 한다.

출처: https://feco.tistory.com/64 [wmJun]


# @PostConstruct || afterPropertiesSet 사용법 정리
### 프로젝트를 하다가 @PostConstruct 을 사용하는 소스를 보았고 정확한 내용을 알기위해서 찾아봄..  
   
이해를 쉽게하기위해 아래 샘플소스를 보게되면 기존 생성자에 의해서 주입받은 bar변수를 출력해보면 null이 나오게된다.  
즉 Bean생성이 되기전에 생성자가 더 빨리 호출된다는 의미이다.  

그래서 생성자에서 Bean을 사용하기위해서 아래 샘플과 같이 @PostConstruct를 사용하게되면
의존성 주입이 완료된 이후에 bar를 사용할 수 있다.  

```
class Foo {

    @Autowired
    Bar bar;
    
    Foo() {
    	System.out.println(bar); // null
    	System.out.println("bar does not injected");
    }
    
    @PostConstruct
    public void barInit() {
    	System.out.println(bar); // package.Bar@...
    	System.out.println("bar is injected.");
    }
}
```
### Java9부터는 implements InitializingBean를 추가하는 방식으로 변경 되었다.  
- void afterPropertiesSet() throws Exception;
```
    @Override
    public void afterPropertiesSet() throws Exception
    {
    }
```

### 그러면!! 어떨 때 사용해야하는가?  

 아래 소스는 프로젝트에서 사용한 일부분 입니다.  
 
 SimpleLinkRestHandler는 여러곳에 구현체로 사용할 수 있고 각 구현체에서 사용하는 타입이 다르기 때문에 공통으로 사용하기 위해서 <> 형태로 만들어진 것이다.  
 
 여러 구현체가 하나의 SimpleLinkRestHandler를 사용하기 때문에 구현체별로 맞는 타입으로 인스턴스 생성이 필요하다
 그렇기 떄문에 타입별로 주입이 필요한 것들을 Document, Search, BaseRepository 값을 받게하고
 afterPropertiesSet이곳에서 전역변수에 주입을 하게된다, 그러면 각 구현체별로 자기 타입변환처리가 가능하다.
 
 ? BaseRepository 경우에는 밖에서 ReactiveMongoRepository의 구현체에 Bean을 주입하는 어노테이션이 있어서 그런지
 별도로 처리 안하고 @Autowiered로 선언되어있다. VO는 Bean이 아니라서 그런건지.. 알아서 타입까지 잘 주입이되는거 같다 그래서 null인지 체크만 하는 로직이 있는거 같다.
  
 ```
 @Slf4j
public class SimpleLinkRestHandler<Document extends LinkMongoObject, Search extends LinkSearch, BaseRepository extends ReactiveMongoRepository<Document, ?> & SearchRepository<Document, Search>>
        extends LinkRestHandler implements InitializingBean
{
    protected Class<Document>                                         documentClassType;
    protected Class<Search>                                           searchClassType;
    protected String                                                  collectionName;
    @Autowired
    protected ReactiveMongoOperations                                 mongoOps;
    @Autowired
    protected BaseRepository                                          baseRepository;
    @Autowired
    protected LogAuditHandler                                         logAuditHandler;

    protected SimpleLinkRestHandler<Document, Search, BaseRepository> instance;

    @Override
    public void afterPropertiesSet()
    {
        if ( null == this.baseRepository )
        {
            throw new IllegalStateException("The baseRepository is null.");
        }

        Type[] genericTypes = ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments();
        this.documentClassType = (Class<Document>) genericTypes[0];
        this.searchClassType = (Class<Search>) genericTypes[1];
        this.collectionName = this.mongoOps.getCollectionName(this.documentClassType);

        this.instance = this;
    }
 ```


# WEBFLUX 메소드 개념 정리
```
======================================== 웹플럭스 / Webfux ====================================================
=========================================================================================================================================================================================================================================
| publisher                         | Java Object                       | Void 			                    | Description                                                                                                               |
=========================================================================================================================================================================================================================================
| flatMap()                         | map()                             | 	                                |데이터의 흐름이나 변화가 필요할 때 사용한다.                                                                                              |
|                                   |                                   |                                   | reactor.core.publisher.Mono<T>                                                                                            |
|                                   |                                   |                                   | public final <R> Mono<R> flatMap(@NotNull java.util.function.Function<? super T, ? extends Mono<? extends R>> transformer)|
|                                   |                                   |                                   |                                                               													        |
|                                   |                                   |                                   | reactor.core.publisher.Mono<T>     																					    |
|                                   |                                   |                                   | public final <R> Mono<R> map(@NotNull java.util.function.Function<? super T, ? extends R> mapper)                         |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| defer(() -> someData)             | fromCallable(() -> someData)      | fromRunable(() -> someData)       | 리액트 흐름을 생성하기위해 초기 데이터 셋팅을 한다.        																				    |
|                                   |                                   |                                   | Runable의 경우는 리턴이 VOID로 스케줄러에 많이 쓰인다.  																				    |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| filterWhen(temp -> temp)          | filter(temp -> temp)              |                                   | true면 받았던 데이터를 흘려주고, false면 empty로 흘려준다																				|
|                                   |                                   |                                   | 여기서 defaultIfEmpty를 사용해서 else의 역활을 넣어줄수 있다.																			|
|                                   |                                   |                                   | 가독성을 위해서 filter()가 true면 다음 로직에는 map or flatmap으로 감싸서 안에서 로직을 짠다. 												    |
|                                   |                                   |                                   | 이렇게하는 이유는 단순히 가독성이 높아진다.                     																		    |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                                   | thenReturn(object) r:Mono<V>      | then() r:Mono<Void>               | 정말 중요한 메소드 중에 하나 이것을 잘 활용할 줄 알아야 한다.                                                                                 |
| then(Mono<V>) r:Mono<V>           |                                   |                                   | 우선은 filter기능 이후에 자주사용하는 편이고 true든 false던 마지막에 무조건 then이 실행된다.                                                       |
| thenMany(<V>) r:Flux<V>           |                                   |                                   |                                                                                                                           |
| thenEmpty(<Void>) r:Mono<Void>    |                                   |                                   |                                                                                                                           |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                                   |                                   | doOnNext(object -> logic...)      | 이것도 상당히 많이 쓰인다 받은 데이터는 주소값을 변경하는 것은 불가능하고 해당 주소값에 데이터 set은 가능하다                                                  |
|                                   |                                   |                                   | 주로 중간에 필요한 값이 있으면 set할 때 많이 쓰인다.                                                                                      |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| zip()                             |                                   |                                   |                                                                                                                           |
| zipWith()                         |                                   |                                   |                                                                                                                           |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| flatMapMany(list -> list)         |                                   |                                   | 흐름을 받아서 리턴이 Flux일 때 사용한다. (for문의 역활이 아님)                                                                              |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| collectList()                     |                                   |                                   | Flux로 리턴이되는 경우 .collectList()를 사용하면 Mono<List<>>타입으로 반환 된다.                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
|                                   |                                   |                                   |                                                                                                                           |
=========================================================================================================================================================================================================================================

```
