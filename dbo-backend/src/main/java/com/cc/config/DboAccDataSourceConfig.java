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
@MapperScan(basePackages = "com.cc.mapper.dboacc",sqlSessionFactoryRef = "dboAccSqlSessionFactory")
public class DboAccDataSourceConfig {
    @Primary
    @Bean(name = "dboAccDataSource")
    @ConfigurationProperties("spring.datasource.dboacc")
    public DataSource masterDataSource(){
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "dboAccSqlSessionFactory")
    public SqlSessionFactory sqlSessionFactory(@Qualifier("dboAccDataSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
        sessionFactoryBean.setDataSource(dataSource);
        sessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver()
                .getResources("classpath:mapper/dboacc/*.xml"));
        return sessionFactoryBean.getObject();
    }

    @Bean(name = "dboAccTransactionManager")
    public PlatformTransactionManager transactionManager(@Qualifier("dboAccDataSource") DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }
}