# 다양한 자료들이 모이는 곳

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
