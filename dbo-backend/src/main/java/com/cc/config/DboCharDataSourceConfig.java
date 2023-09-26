package com.cc.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;

@Configuration
@MapperScan(basePackages = "com.cc.mapper.dbochar",sqlSessionFactoryRef = "dboCharSqlSessionFactory")
public class DboCharDataSourceConfig {
    @Primary
    @Bean(name = "dboCharDataSource")
    @ConfigurationProperties("spring.datasource.dbochar")
    public DataSource masterDataSource(){
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "dboCharSqlSessionFactory")
    public SqlSessionFactory sqlSessionFactory(@Qualifier("dboCharDataSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
        sessionFactoryBean.setDataSource(dataSource);
        sessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver()
                .getResources("classpath:mapper/dbochar/*.xml"));
        return sessionFactoryBean.getObject();
    }

    @Bean(name = "dboCharTransactionManager")
    public PlatformTransactionManager transactionManager(@Qualifier("dboCharDataSource") DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }
}
