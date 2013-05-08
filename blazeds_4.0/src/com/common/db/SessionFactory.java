package com.common.db;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.logging.LogFactory;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;


/**
 * SqlSessionFactory 인스턴스를 싱글턴으로 반환함
 * @author si
 *
 */
public class SessionFactory {

	private static Logger log = Logger.getLogger(SessionFactory.class);
	private static final SqlSessionFactory sqlMapper;
	
	static{
		LogFactory.useLog4JLogging();
		String resource = "com/query/SqlMapConfig.xml";
		Reader reader = null;
		try {
			reader = Resources.getResourceAsReader(resource);
		} catch (IOException e) {
			log.error(e.toString());
			e.printStackTrace();
		}
		sqlMapper = new SqlSessionFactoryBuilder().build(reader);
	}
	
	public static SqlSessionFactory getSqlSession() {
		return sqlMapper;   
	}

	
}
