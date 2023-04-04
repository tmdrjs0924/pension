package pension.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pension.dto.ReserveDto;
import pension.dto.RoomDto;

public class ReserveDao {
	
	Connection conn;
	public ReserveDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver"); 
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void getRoomName(HttpServletRequest request) throws Exception {
		String sql="select id,name from room order by price asc";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<RoomDto> rlist=new ArrayList<RoomDto>();
		while(rs.next()) {
			RoomDto rdto=new RoomDto();
			rdto.setId(rs.getInt("id"));
			rdto.setName(rs.getString("name"));
			rlist.add(rdto);
		}
		request.setAttribute("rlist", rlist);
	}
	
	public void getRoom(HttpServletRequest request) throws Exception {
		String id=request.getParameter("id");
		String sql="select * from room where id=?";
		   	 
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		RoomDto rdto=new RoomDto();
		rdto.setId(rs.getInt("id"));
		rdto.setName(rs.getString("name"));
		rdto.setPrice(rs.getInt("price"));
		rdto.setMax(rs.getInt("max"));
		rdto.setMin(rs.getInt("min"));
		rdto.setImg(rs.getString("img"));
		rdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		
		request.setAttribute("rdto", rdto);
		
		String y=request.getParameter("y");
		String m=request.getParameter("m");
		String d=request.getParameter("d");
		String xday=y+"-"+m+"-"+d;
		request.setAttribute("xday", xday);
	}
	
	public int getSuk(HttpServletRequest request) throws Exception {
		int y=Integer.parseInt(request.getParameter("y"));
		int m=Integer.parseInt(request.getParameter("m"));
		int d=Integer.parseInt(request.getParameter("d"));
		String id=request.getParameter("id");
		
		LocalDate xday=LocalDate.of(y, m, d); // 입실일의 날짜객체가 생성  : 2022-12-3
		int suk=1;
		for(int i=1;i<=6;i++) {
			xday=xday.plusDays(1);
			
			String sql="select * from reserve where inday <= ? and outday > ? and room_id=?";
			
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, xday.toString());
			pstmt.setString(2, xday.toString());
			pstmt.setString(3, id);
			
			ResultSet rs=pstmt.executeQuery();
    		if(rs.next()) {
    			break;
			}
    		suk++;
		}
		return suk;
	}
	
	public void reserve_ok(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws Exception {
		String inday=request.getParameter("inday");
		String room_id=request.getParameter("room_id");
		String tprice=request.getParameter("tprice");
		String userid=session.getAttribute("userid").toString();
		String chacol=request.getParameter("chacol");
		String bbq=request.getParameter("bbq");
		String inwon=request.getParameter("inwon");
		   
		int suk=Integer.parseInt(request.getParameter("suk"));
		String[] imsi=inday.split("-");
		int y=Integer.parseInt(imsi[0]);
		int m=Integer.parseInt(imsi[1]);
		int d=Integer.parseInt(imsi[2]);
		
		LocalDate xday=LocalDate.of(y, m, d);
		LocalDate outday=xday.plusDays(suk);
		
		String jcode="j"+y+m+"0"+room_id;
		String sql="select max( right(jcode,2) ) as num from reserve where jcode like ?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, jcode+"%");
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		int num=rs.getInt("num");
		num++;
		String num2=num+"";
		if(num2.length()==1)
			num2="0"+num2;
		jcode=jcode+num2;
		
		sql="insert into reserve(inday,outday,room_id,userid,jcode,chacol,bbq,inwon,writeday,tprice) values(?,?,?,?,?,?,?,?,now(),?)";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, inday);
		pstmt.setString(2, outday.toString());
		pstmt.setString(3, room_id);
		pstmt.setString(4, userid);
		pstmt.setString(5, jcode);
		pstmt.setString(6, chacol);
		pstmt.setString(7, bbq);
		pstmt.setString(8, inwon);
		pstmt.setString(9, tprice);
		pstmt.executeUpdate();
		
		rs.close();
		pstmt.close();
		conn.close();
		response.sendRedirect("reserve_view.jsp?jcode="+jcode);
	}
	
	public void reserve_view(HttpServletRequest request) throws Exception {
		String jcode=request.getParameter("jcode");
		String sql=" select r2.jcode, r1.name, r2.inday, r2.outday, r2.inwon, r2.chacol, r2.bbq, r2.tprice from room as r1 inner join reserve as r2 on r1.id=r2.room_id and jcode=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, jcode);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		ReserveDto rdto=new ReserveDto();
		rdto.setJcode(rs.getString("jcode"));
		rdto.setName(rs.getString("name"));
		rdto.setInday(rs.getString("inday"));
		rdto.setOutday(rs.getString("outday"));
		rdto.setInwon(rs.getInt("inwon"));
		rdto.setChacol(rs.getInt("chacol"));
		rdto.setBbq(rs.getInt("bbq"));
		rdto.setTprice(rs.getInt("tprice"));
		
		request.setAttribute("rdto", rdto);
	}
	
	public void reserve_all(HttpSession session, HttpServletRequest request) throws Exception {
		String userid=session.getAttribute("userid").toString();
		String sql=" select r2.jcode, r1.name, r2.inday, r2.outday, r2.inwon, r2.chacol, r2.bbq, r2.tprice from room as r1 inner join reserve as r2 on r1.id=r2.room_id and userid=? order by inday desc";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<ReserveDto> rlist=new ArrayList<ReserveDto>();
		while(rs.next()) {
			ReserveDto rdto=new ReserveDto();
			rdto.setJcode(rs.getString("jcode"));
			rdto.setName(rs.getString("name"));
			rdto.setInday(rs.getString("inday"));
			rdto.setOutday(rs.getString("outday"));
			rdto.setInwon(rs.getInt("inwon"));
			rdto.setChacol(rs.getInt("chacol"));
			rdto.setBbq(rs.getInt("bbq"));
			rdto.setTprice(rs.getInt("tprice")); 
			
			rlist.add(rdto);
		}
		request.setAttribute("rlist", rlist);
	}
	
	public boolean isEmpty(int y,int m,int d,int id) throws Exception {
		String ymd=y+"-"+m+"-"+d; 
		String sql="select * from reserve where inday <= ? and outday > ? and room_id=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, ymd);
		pstmt.setString(2, ymd);
		pstmt.setInt(3, id);
		
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()) 
			return false;
		else
			return true;
	}
}