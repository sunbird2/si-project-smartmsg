package com.m.address;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.common.Gv;

public class Address implements IAddress {

	public static final int GROUP = 0;
	public static final int NAME = 1;
	public static final int SEARCH = 2;
	
	public static final int GROUP_INSERT = 10;
	public static final int GROUP_UPDATE = 11;
	public static final int GROUP_DELETE = 12;
	public static final int NAME_INSERT = 20;
	public static final int NAME_UPDATE = 21;
	public static final int NAME_DELETE = 22;
	public static final int GROUPNAME_INSERT = 23;
	
	public static final int NAMES_INSERT = 30;
	public static final int NAMES_INSERT_GROUP = 31;
	public static final int NAMES_UPDATE_GROUP = 32;
	public static final int NAMES_DELETE = 33;
	
	static Address em = new Address();
	
	public static Address getInstance() {
		return em;
	}
	@Override
	public ArrayList<AddressVO> getAddrGroupList(Connection conn, String user_id) {
		
		ArrayList<HashMap<String, String>> al = null;
		
		String SQL = VbyP.getSQL( "address_group_list" );
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, user_id);
		pq.setInt(2, Address.GROUP);
		al = pq.ExecuteQueryArrayList();
		
		return parseVO(al);
	}

	@Override
	public ArrayList<AddressVO> getAddrNameList(Connection conn, String user_id) {
		
		ArrayList<HashMap<String, String>> al = null;
		
		String SQL = VbyP.getSQL( "address_name_list" );
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, user_id);
		pq.setInt(2, Address.NAME);
		al = pq.ExecuteQueryArrayList();
		
		return parseVO(al);
	}
	
	@Override
	public ArrayList<AddressVO> getAddrNameList(Connection conn, String user_id, String groupName) {
		
		ArrayList<HashMap<String, String>> al = null;
		
		String SQL = VbyP.getSQL( "address_name_list_group" );
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, user_id);
		pq.setString(2, groupName);
		pq.setInt(3, Address.NAME);
		al = pq.ExecuteQueryArrayList();
		
		return parseVO(al);
	}
	
	@Override
	public StringBuffer getTreeData(Connection conn, String user_id) {
		
		StringBuffer buf = null;
		
		ArrayList<HashMap<String, String>> al = null;
		
		String SQL = VbyP.getSQL( "address_tree_xml" );
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, user_id);
		al = pq.ExecuteQueryArrayList();
		
		buf = makeXML(al);
		
		
		return buf;
	}
	
	@Override
	public StringBuffer getTreeData(Connection conn, String user_id, String search) {
		
		StringBuffer buf = null;
		
		ArrayList<HashMap<String, String>> al = null;
		
		String SQL = VbyP.getSQL( "address_tree_xml_search" );
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, user_id);
		pq.setString(2, "%"+SLibrary.IfNull( search )+"%");
		pq.setString(3, "%"+SLibrary.IfNull( search )+"%");
		al = pq.ExecuteQueryArrayList();
		
		buf = makeXML(al);
		
		
		return buf;
	}

	@Override
	public int insertGroup(Connection conn, AddressVO vo) {
		
		//INSERT INTO address	(user_id, grp, grpName, name, phone, memo, writedate, etcInfo) VALUES (?, ?, ?, ?, ?, ?, ?, ?);
		int rsltCount = 0;
		String SQL = VbyP.getSQL("address_insert_group");
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		
		pq.setPrepared(conn, SQL);
		pq.setString(1, vo.getUser_id());
		pq.setInt(2, Address.GROUP);
		pq.setString(3, vo.getGrpName());
		pq.setString(4, vo.getGrpName());
		pq.setString(5, "");
		pq.setString(6, "");
		pq.setString(7, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
		pq.setString(8, "");
		
		rsltCount = pq.executeUpdate();
		
		if (rsltCount > 0)
			rsltCount = getLastKey(conn);
		
		return rsltCount;
	}

	@Override
	public int updateGroup(Connection conn, AddressVO vo) {
		
		//UPDATE address SET user_id = ? , grp = ?, grpName = ?, name = ?, phone = ?, memo = ?, writedate = ?, etcInfo = ? WHERE idx = ? 
		int rsltCount = 0;
		String SQL = VbyP.getSQL("address_update_group");
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		
		pq.setPrepared(conn, SQL);
		
		pq.setString(1, vo.getGrpName());
		pq.setString(2, vo.getUser_id());
		pq.setString(3, vo.getGrpName());
		
		rsltCount = pq.executeUpdate();			
		
		return rsltCount;
	}

	@Override
	public int deleteGroup(Connection conn, AddressVO vo) {
		
		//delete from address WHERE idx = ? 
		int rsltCount = 0;
		String SQL = VbyP.getSQL("address_delete_group");
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		
		pq.setPrepared(conn, SQL);
		pq.setString(1, vo.getGrpName());
		
		rsltCount = pq.executeUpdate();			
		
		return rsltCount;
	}

	@Override
	public int insertName(Connection conn, AddressVO vo) {

		//INSERT INTO address	(user_id, grp, grpName, name, phone, memo, writedate, etcInfo) VALUES (?, ?, ?, ?, ?, ?, ?, ?);
		int rsltCount = 0;
		String SQL = VbyP.getSQL("address_insert_name");
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		
		pq.setPrepared(conn, SQL);
		pq.setString(1, vo.getUser_id());
		pq.setInt(2, Address.NAME);
		pq.setString(3, vo.getGrpName());
		pq.setString(4, vo.getName());
		pq.setString(5, vo.getPhone());
		pq.setString(6, vo.getMemo());
		pq.setString(7, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
		pq.setString(8, vo.getEtcInfo());
		
		rsltCount = pq.executeUpdate();
		if (rsltCount > 0)
			rsltCount = getLastKey(conn);
		
		return rsltCount;
	}

	@Override
	public int updateName(Connection conn, AddressVO vo) {
		
		//UPDATE address SET user_id = ? , grp = ?, grpName = ?, name = ?, phone = ?, memo = ?, writedate = ?, etcInfo = ? WHERE idx = ? 
		int rsltCount = 0;
		String SQL = VbyP.getSQL("address_update_name");
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		
		pq.setPrepared(conn, SQL);
		pq.setString(1, vo.getUser_id());
		pq.setInt(2, Address.NAME);
		pq.setString(3, vo.getGrpName());
		pq.setString(4, vo.getName());
		pq.setString(5, vo.getPhone());
		pq.setString(6, vo.getMemo());
		pq.setString(7, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
		pq.setString(8, vo.getEtcInfo());
		pq.setInt(9, vo.getIdx());
		
		rsltCount = pq.executeUpdate();			
		
		return rsltCount;
	}

	@Override
	public int deleteName(Connection conn, AddressVO vo) {
		
		//delete from address WHERE idx = ? 
		int rsltCount = 0;
		String SQL = VbyP.getSQL("address_delete_name");
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		
		pq.setPrepared(conn, SQL);
		pq.setInt(1, vo.getIdx());
		
		rsltCount = pq.executeUpdate();			
		
		return rsltCount;
	}
	
	@Override
	public ArrayList<AddressVO> getAddrSearchNameList(Connection conn, String user_id, String search) {
		
		ArrayList<HashMap<String, String>> al = null;
		
		String SQL = VbyP.getSQL( "address_search_list" );
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, user_id);
		pq.setString(2, "%"+search+"%");
		pq.setString(3, "%"+search+"%");
		al = pq.ExecuteQueryArrayList();
		
		return parseVO(al);
	}
	
	@Override
	public int insertNames(Connection conn, String user_id, ArrayList<AddressVO> al) {
		
		int count = al.size();
		int rsltCount = 0;
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		String SQL = "";
		int maxBatch = SLibrary.parseInt( VbyP.getValue("executeBatchCount") );
		
		if (count > 0) {
			
			AddressVO vo = null;
			
			SQL = VbyP.getSQL("address_insert_name");
			
			pq.setPrepared(conn, SQL);
			
			for (int i = 0; i < count; i++) {
				
				vo = al.get(i);
				pq.setString(1, user_id);
				pq.setInt(2, Address.NAME);
				pq.setString(3, vo.getGrpName());
				pq.setString(4, vo.getName());
				pq.setString(5, vo.getPhone());
				pq.setString(6, vo.getMemo());
				pq.setString(7, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
				pq.setString(8, vo.getEtcInfo());
				
				pq.addBatch();
				
				Gv.setStatus(user_id, Integer.toString(i+1));
				
				if (i >= maxBatch && (i%maxBatch) == 0 ) {
					
					rsltCount += pq.executeBatch();
					try { if ( conn != null ) conn.close(); } catch(Exception e) {System.out.println( "reconn close Error!!!!" + e.toString());}
					conn = VbyP.getDB();					
					if (conn == null) System.out.println("reconn connection is NULL Error!!!!");
					
					pq.setPrepared( conn, SQL );
				}
			}
			rsltCount += pq.executeBatch();
		}

		return rsltCount;
	}
	
	@Override
	public int insertNames(Connection conn, String user_id, String group, ArrayList<AddressVO> al) {
		
		int count = al.size();
		int rsltCount = 0;
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		String SQL = "";
		int maxBatch = SLibrary.parseInt( VbyP.getValue("executeBatchCount") );
		
		if (count > 0) {
			
			AddressVO vo = null;
			
			SQL = VbyP.getSQL("address_insert_name");
			
			pq.setPrepared(conn, SQL);
			
			for (int i = 0; i < count; i++) {
				
				vo = al.get(i);
				pq.setString(1, user_id);
				pq.setInt(2, Address.NAME);
				pq.setString(3, group);
				pq.setString(4, vo.getName());
				pq.setString(5, vo.getPhone());
				pq.setString(6, vo.getMemo());
				pq.setString(7, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
				pq.setString(8, vo.getEtcInfo());
				
				pq.addBatch();
				
				Gv.setStatus(user_id, Integer.toString(i+1));
				
				if (i >= maxBatch && (i%maxBatch) == 0 ) {
					
					rsltCount += pq.executeBatch();
					try { if ( conn != null ) conn.close(); } catch(Exception e) {System.out.println( "reconn close Error!!!!" + e.toString());}
					conn = VbyP.getDB();					
					if (conn == null) System.out.println("reconn connection is NULL Error!!!!");
					
					pq.setPrepared( conn, SQL );
				}
			}
			rsltCount += pq.executeBatch();
		}

		return rsltCount;
	}
	
	@Override
	public int updateNames(Connection conn, String user_id, String group, ArrayList<AddressVO> al) {
		
		int count = al.size();
		int rsltCount = 0;
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		String SQL = "";
		int maxBatch = SLibrary.parseInt( VbyP.getValue("executeBatchCount") );
		
		if (count > 0) {
			
			AddressVO vo = null;
			
			SQL = VbyP.getSQL("address_update_name");
			
			pq.setPrepared(conn, SQL);
			
			for (int i = 0; i < count; i++) {
				
				vo = al.get(i);
				
				pq.setString(1, user_id);
				pq.setInt(2, Address.NAME);
				pq.setString(3, group);
				pq.setString(4, vo.getName());
				pq.setString(5, vo.getPhone());
				pq.setString(6, vo.getMemo());
				pq.setString(7, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
				pq.setString(8, vo.getEtcInfo());
				pq.setInt(9, vo.getIdx());
				
				pq.addBatch();
				
				Gv.setStatus(user_id, Integer.toString(i+1));
				
				if (i >= maxBatch && (i%maxBatch) == 0 ) {
					
					rsltCount += pq.executeBatch();
					try { if ( conn != null ) conn.close(); } catch(Exception e) {System.out.println( "reconn close Error!!!!" + e.toString());}
					conn = VbyP.getDB();					
					if (conn == null) System.out.println("reconn connection is NULL Error!!!!");
					
					pq.setPrepared( conn, SQL );
				}
			}
			rsltCount += pq.executeBatch();
		}

		return rsltCount;
	}
	
	@Override
	public int deleteNames(Connection conn, String user_id, ArrayList<AddressVO> al) {
		
		int count = al.size();
		int rsltCount = 0;
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		String SQL = "";
		int maxBatch = SLibrary.parseInt( VbyP.getValue("executeBatchCount") );
		
		if (count > 0) {
			
			AddressVO vo = null;
			
			SQL = VbyP.getSQL("address_delete_name");
			
			pq.setPrepared(conn, SQL);
			
			for (int i = 0; i < count; i++) {
				
				vo = al.get(i);
				
				pq.setInt(1, vo.getIdx());
				
				pq.addBatch();
				
				Gv.setStatus(user_id, Integer.toString(i+1));
				
				if (i >= maxBatch && (i%maxBatch) == 0 ) {
					
					rsltCount += pq.executeBatch();
					try { if ( conn != null ) conn.close(); } catch(Exception e) {System.out.println( "reconn close Error!!!!" + e.toString());}
					conn = VbyP.getDB();					
					if (conn == null) System.out.println("reconn connection is NULL Error!!!!");
					
					pq.setPrepared( conn, SQL );
				}
			}
			rsltCount += pq.executeBatch();
		}

		return rsltCount;
	}
	
	private StringBuffer makeXML(ArrayList<HashMap<String, String>> al) {
		
		StringBuffer buf = new StringBuffer();
		int cnt = al.size();
		HashMap<String, String> hm = null;
		boolean bAddrsOpen = false;
		//buf.append("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		buf.append("<root>");
		buf.append("<msg>ok</msg>");
		//buf.append("<all idx='0' type='all' label='모두' name='' phone=''>");
		for (int i = 0; i < cnt; i++) {
			
			hm = al.get(i);
			
			if (SLibrary.IfNull(hm, "grp").equals("0") && bAddrsOpen == true) {
				buf.append("</addrs>");
				bAddrsOpen = false;
			}
			if (SLibrary.IfNull(hm, "grp").equals("0")) {
				buf.append("<addrs idx='0' type='group' label='"+SLibrary.IfNull(hm, "grpName")+"'>");
				bAddrsOpen = true;
			}
			
			if (SLibrary.IfNull(hm, "grp").equals("1")) {
				buf.append("<addr idx='"+SLibrary.IfNull(hm, "idx")+"' group='"+SLibrary.IfNull(hm, "grpName")+"' label='"+SLibrary.IfNull(hm, "name")+"' phone='"+SLibrary.IfNull(hm, "phone")+"' />");
			}
			
		}
		if (bAddrsOpen == true) {
			buf.append("</addrs>");
			bAddrsOpen = false;
		}
		//buf.append("</all>");
		buf.append("</root>");
		
		return buf;
		
	}
	
	private ArrayList<AddressVO> parseVO(ArrayList<HashMap<String, String>> al) {
		
		ArrayList<AddressVO> result = new ArrayList<AddressVO>();
		
		if (al != null) {
			int cnt = al.size();
			for (int i = 0; i < cnt; i++) {
				result.add( new AddressVO(al.get(i)) );
			}
		}
		
		return result;
	}
	
	private int getLastKey(Connection conn) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("address_last_insert_id") );
		return pq.ExecuteQueryNum();
				
	}

}
