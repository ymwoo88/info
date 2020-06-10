# [JAVA]==========[JAVA]==========[JAVA]
# @Deprecated
## java.lang.Deprecated
 - zmffotm, apthem
 - 사용하지 않은 클래스 나 메스드에 설정하는 용도 
 ```
 @Deprecated
 public class HaksaMatchingAfterChgLectTask {
     @Deprecated
     public void test() {
     }
 }
 ```
 
# @PostConstruct
## import javax.annotation.PostConstruct;
 - 사용위치 : 메소드
 
# @SuppressWarnings(“unused”) 
## java.lang.SuppressWarnings
 - zmffotm, apthem
 -  
[SPRING]
@Transactional(propagation = Propagation.REQUIRES_NEW)
import org.springframework.transaction.annotation.Transactional;
 - zmffotm, apthem
@EnableScheduling
import org.springframework.scheduling.annotation.EnableScheduling;
 - zmffotm
@Scheduled(initialDelay = 10000l, fixedDelay = 10000l)
import org.springframework.scheduling.annotation.Scheduled;
- apthem
@Autowired
import org.springframework.beans.factory.annotation.Autowired;
 - qustn
@Value(“${systemProperties.pictureScheduler}”)
import org.springframework.beans.factory.annotation.Value;
 - qustn
 -  
@Configuration
import org.springframework.context.annotation.Configuration;
 - zmffotm
@Bean(name = “systemId”)
import org.springframework.context.annotation.Bean;
 - zmffotm,apthem
@ConfigurationProperties(prefix = “datasource”)
@ConfigurationProperties(prefix = “hce”)
import org.springframework.boot.context.properties.ConfigurationProperties;
 - zmffotm
 -  - application.ymldp dlTsms eogkdahr gkdnldp ahrfhremfdmf qustnghk tlzlsek.
 - Javadptj config.get000() dmfh applicationdml rkqtdmf qnffjdhf tn dlTek.
@ConditionalOnProperty(prefix = “generateKey-service”, name = “type”, havingValue = “H”)
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
 - zmffotm
 -  - application.ymldp eogkdahr, wndgkdahrdp goekdehlsms rkqtdmf dlfrdjdhf tn dlTek.
 
@Component
import org.springframework.stereotype.Component;
 - zmffotm
@Qualifier(“AH-1000”)
import org.springframework.beans.factory.annotation.Qualifier;
 - zmffotm
 -  
@EnableWebMvc
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
 - zmffotm
 -  
@EnableTransactionManagement
import org.springframework.transaction.annotation.EnableTransactionManagement;
 - zmffotm
 -  
@RestController
import org.springframework.web.bind.annotation.RestController;
 - zmffotm
 -  
@RequestMapping(“/block”)
import org.springframework.web.bind.annotation.RequestMapping;
 - apthem
 -  
@RequestBody
import org.springframework.web.bind.annotation.RequestBody;
 - vkfkalxj
 -  
@Controller
import org.springframework.stereotype.Controller;
 - zmffotm
 -  
@ResponseStatus(HttpStatus.NOT_FOUND)
import org.springframework.web.bind.annotation.ResponseStatus;
 - apthem
 -  
@ExceptionHandler({ FileNotFoundException.class, NoSuchFileException.class })
import org.springframework.web.bind.annotation.ExceptionHandler;
 - apthem
 -  
@ResponseBody
import org.springframework.web.bind.annotation.ResponseBody;
 - apthem
 -  
@EnableAsync
import org.springframework.scheduling.annotation.EnableAsync;
 - zmffotm
 -  
@Scope(“prototype”)
import org.springframework.context.annotation.Scope;
 - zmffotm
@SpringBootApplication(scanBasePackages = “com.ubivelox”)
import org.springframework.boot.context.web.SpringBootServletInitializer;
- zmffotm


 
[LOMBOK]
@Data
import lombok.Data;
 - zmffotm
@NoArgsConstructor
import lombok.NoArgsConstructor;
 - zmffotm
 -  
@Setter
import lombok.Setter;
 - qustn
 -  
@Getter
import lombok.Getter;
 - qustn
 - dPtl)
 - @Getter
 - private BasicDataSource  dataSource; // << getDataSource() dlfjgrp tkdydehlsek.
@AllArgsConstructor(staticName = “of”)
import lombok.AllArgsConstructor;
 - zmffotm
 -  
@RequiredArgsConstructor(staticName = “of”)
import lombok.RequiredArgsConstructor;
 - zmffotm
 -  
@NoArgsConstructor(staticName = “of”)
import lombok.NoArgsConstructor;
 - zmffotm
 -  
@NonNull
import lombok.NonNull;
 - apthem
@SneakyThrows
import lombok.SneakyThrows;
- apthem
@RequiredArgsConstructor
import lombok.RequiredArgsConstructor;

@EqualsAndHashCode(callSuper = true)
import lombok.EqualsAndHashCode;
 - zmffotm
@AllArgsConstructor(access = AccessLevel.PRIVATE)
import lombok.AllArgsConstructor;
 - zmffotm 
 -  
[DB]
@MapperScan(basePackages = { “com.ubivelox.solution.uhce.s1.repository”, “com.ubivelox.solution.uhce.repository” })
import org.mybatis.spring.annotation.MapperScan;
 - zmffotm

 
[JSON]
@JsonInclude(Include.NON_NULL)
import com.fasterxml.jackson.annotation.JsonInclude;
 - zmffotm
 -   
@JsonProperty(value = “branchName”, required = true)
import com.fasterxml.jackson.annotation.JsonProperty;
 - qustn
 -  
@JsonView(RepMsgListingIssuedCard.class)
import com.fasterxml.jackson.annotation.JsonView;
 - qustn
@JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnore;
 - qustn
@JsonUnwrapped
import com.fasterxml.jackson.annotation.JsonUnwrapped;
 - qustn
@JsonCreator
import com.fasterxml.jackson.annotation.JsonCreator;
 - apthem
@JsonValue
import com.fasterxml.jackson.annotation.JsonValue;
 - apthem






















———————————————-xptmxm
@RunWith(SpringJUnit4ClassRunner.class)
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@Test
import org.junit.Test;

@SpringApplicationConfiguration(Application.class)
import org.springframework.boot.test.SpringApplicationConfiguration;

@WebAppConfiguration
import org.springframework.test.context.web.WebAppConfiguration;

ReflectionTestUtils
import org.springframework.test.util.ReflectionTestUtils;
