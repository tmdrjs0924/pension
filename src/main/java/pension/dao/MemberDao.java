package pension.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import pension.dto.MemberDto;

public class MemberDao {

	Connection conn;
	public MemberDao() throws Exception {
	    Class.forName("com.mysql.jdbc.Driver"); 
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}

	public void member_input_ok(HttpServletRequest request,	HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String userid=request.getParameter("userid");
		String pwd=request.getParameter("pwd");
		String phone=request.getParameter("phone");
		String email=request.getParameter("email");
		String name=request.getParameter("name");
		String sql="insert into member(userid,pwd,phone,email,writeday,name)";
		sql=sql+" values(?,?,?,?,now(),?)";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, pwd);
		pstmt.setString(3, phone);
		pstmt.setString(4, email);
		pstmt.setString(5, name);
		pstmt.executeUpdate();
		
		pstmt.close();
		response.sendRedirect("login.jsp");
	}
	
	public void userid_check(HttpServletRequest request, JspWriter out) throws Exception {
		String userid=request.getParameter("userid");
		String sql="select * from member where userid=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		ResultSet rs=pstmt.executeQuery();
		if(rs.next())
			out.print("0");
		else
			out.print("1");
	}
	
	public void login_ok(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws Exception {
		String userid=request.getParameter("userid");
		String pwd=request.getParameter("pwd");
		String y=request.getParameter("y");
		String m=request.getParameter("m");
		String d=request.getParameter("d");
		String id=request.getParameter("id");
		String sql="select * from member where userid=? and pwd=? and state=0";

		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, pwd);

		ResultSet rs=pstmt.executeQuery();
		if(rs.next()) {
			session.setAttribute("userid", rs.getString("userid"));
			session.setAttribute("name", rs.getString("name"));
			
			conn.close();
			if(y.equals("null"))
			   response.sendRedirect("../main/main.jsp");
			else
			   response.sendRedirect("../reserve/reserve_next.jsp?y="+y+"&m="+m+"&d="+d+"&id="+id);
		}
		else {
			conn.close();
			response.sendRedirect("../member/login.jsp?chk=1");
		}
	}
	
	public void logout(HttpSession session, HttpServletResponse response) throws Exception {
		session.invalidate();
		response.sendRedirect("../main/main.jsp");
	}
	
	public void member_view(HttpSession session, HttpServletRequest request) throws Exception {
		String userid=session.getAttribute("userid").toString();
		String sql="select * from member where userid=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();

		MemberDto mdto=new MemberDto();
		mdto.setUserid(rs.getString("userid"));
		mdto.setName(rs.getString("name"));
		mdto.setPhone(rs.getString("phone"));
		mdto.setEmail(rs.getString("email"));
		mdto.setWriteday(rs.getString("writeday"));
		request.setAttribute("mdto", mdto);
	}
	
	public void member_update_ok(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws Exception {
		String phone=request.getParameter("phone");
		String email=request.getParameter("email");
		String userid=session.getAttribute("userid").toString();
		String sql="update member set phone=?, email=? where userid=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, phone);
		pstmt.setString(2, email);
		pstmt.setString(3, userid);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		response.sendRedirect("member_view.jsp");
	}
	
	public void userid_search(HttpServletRequest request, JspWriter out) throws Exception {
		request.setCharacterEncoding("utf-8");
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String sql="select userid from member where name=? and email=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, email);
		
		ResultSet rs=pstmt.executeQuery();
		if(rs.next())
		    out.print(rs.getString("userid"));
		else
			out.print("1");
	}
	
	public void pwd_search(HttpServletRequest request, JspWriter out) throws Exception {
		request.setCharacterEncoding("utf-8");
		String userid=request.getParameter("userid");
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String sql="select pwd from member where userid=? and name=? and email=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, name);
		pstmt.setString(3, email);
		
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()) 
			out.print(rs.getString("pwd"));
		else
			out.print("1");
	}
	
	
	public void member_out(HttpSession session, HttpServletResponse response) throws Exception {
		String sql="update member set state=1 where userid=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, session.getAttribute("userid").toString());
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();

		session.invalidate();
		response.sendRedirect("../main/main.jsp");
	}
}