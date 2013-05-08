package com.common.db;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;


public class SessionManager {
	
	private Logger log = Logger.getLogger(SessionManager.class);
	SqlSession session = null;
	boolean bClose = true;
	
	public SessionManager() {	}
	public SessionManager(SqlSession sess) { setSession(sess);	}
	
	
	public int insert(String statement,  Object parameter) {
		
		int rslt = 0;
		
		try { rslt = session.insert(statement , parameter);	}
		catch (Exception e) { log.error(e.toString());	} 
		finally { if (bClose == true) session.close(); }
		
		return rslt;
	}
	
	public int update(String statement,  Object parameter) {
		
		int rslt = 0;
		
		try { rslt = session.update(statement , parameter);	}
		catch (Exception e) { log.error(e.toString());	} 
		finally { if (bClose == true) session.close(); }
		
		return rslt;
	}
	public int delete(String statement,  Object parameter) {
		
		int rslt = 0;
		
		try { rslt = session.delete(statement , parameter);	}
		catch (Exception e) { log.error(e.toString());	} 
		finally { if (bClose == true) session.close(); }
		
		return rslt;
	}
	
	public Object selectOne(String statement,  Object parameter) {
		
		Object rslt = 0;
		
		try { rslt = session.selectOne(statement , parameter);	}
		catch (Exception e) { log.error(e.toString());	} 
		finally { if (bClose == true) session.close(); }
		
		return rslt;
	}
	
	public List<Object> selectList(String statement,  Object parameter) {
		
		List<Object> rslt = null;
		
		try { rslt = session.selectList(statement , parameter);	}
		catch (Exception e) { log.error(e.toString());	} 
		finally { if (bClose == true) session.close(); }
		
		return rslt;
	}
	
	public void close() {
		
		try { 
			if (session != null) 
				session.close();
		}
		catch (Exception e) { log.error(e.toString());	} 
	}
	
	// getter , setter
	public SqlSession getSession() {	return session; }
	public void setSession(SqlSession session) { 	this.session = session; }
	public boolean isbClose() { return bClose; }
	public void setbClose(boolean bClose) {	this.bClose = bClose;	} 
	
	
}
