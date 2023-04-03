package pension.dao;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pension.dto.BoardDto;
import pension.dto.GongjiDto;

public class BoardDao {

	Connection conn;

	public BoardDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/pension";
		conn = DriverManager.getConnection(db, "root", "1234");
	}

	public void write_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		String title = request.getParameter("title");
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String content = request.getParameter("content");
		String[] imsi = request.getParameterValues("dest");
		String dest = "";
		for (int i = 0; i < imsi.length; i++) {
			dest = dest + imsi[i] + ",";
		}

		String userid;
		if (session.getAttribute("userid") == null) {
			userid = "guest";
		} else {
			userid = session.getAttribute("userid").toString();
		}

		String sql = "insert into board(title,name,pwd,content,dest,writeday,userid)";
		sql = sql + " values(?,?,?,?,?,now(),?)";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, name);
		pstmt.setString(3, pwd);
		pstmt.setString(4, content);
		pstmt.setString(5, dest);
		pstmt.setString(6, userid);

		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		response.sendRedirect("list.jsp");
	}

	public void list(HttpServletRequest request) throws Exception {
		String sql = "select * from board order by id desc";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		ArrayList<BoardDto> list = new ArrayList<BoardDto>();
		while (rs.next()) {
			BoardDto bdto = new BoardDto();
			bdto.setId(rs.getInt("id"));
			bdto.setReadnum(rs.getInt("readnum"));
			bdto.setTitle(rs.getString("title"));
			bdto.setName(rs.getString("name"));
			bdto.setWriteday(rs.getString("writeday"));

			list.add(bdto);
		}
		request.setAttribute("list", list);
	}

	public void readnum(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String sql = "update board set readnum=readnum+1 where id=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);

		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		response.sendRedirect("content.jsp?id=" + id);
	}

	public void content(HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		String sql = "select * from board where id=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		rs.next();

		BoardDto bdto = new BoardDto();
		bdto.setId(rs.getInt("id"));
		bdto.setReadnum(rs.getInt("readnum"));
		bdto.setTitle(rs.getString("title"));
		bdto.setName(rs.getString("name"));
		bdto.setWriteday(rs.getString("writeday"));
		bdto.setContent(rs.getString("content"));
		bdto.setUserid(rs.getString("userid"));

		String[] imsi = rs.getString("dest").split(",");
		String dest = "";
		for (int i = 0; i < imsi.length; i++) {
			switch (imsi[i]) {
			case "0":
				dest = dest + " 속초";
				break;
			case "1":
				dest = dest + " 제주도";
				break;
			case "2":
				dest = dest + " 태안";
				break;
			case "3":
				dest = dest + " 영덕";
				break;
			case "4":
				dest = dest + " 장흥";
				break;
			case "5":
				dest = dest + " 독도";
				break;
			case "6":
				dest = dest + " 해운대";
				break;
			case "7":
				dest = dest + " 강화도";
				break;
			}
		}
		bdto.setDest(dest);

		request.setAttribute("bdto", bdto);

		rs.close();
		pstmt.close();
		conn.close();
	}

	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");

		if (pwd == null || isPwdCheck(id, pwd)) {
			String sql = "delete from board where id=?";

			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);

			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			response.sendRedirect("list.jsp");
		} else {
			conn.close();
			response.sendRedirect("content.jsp?id=" + id);
		}
	}

	public void update(HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		String sql = "select * from board where id=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		rs.next();

		BoardDto bdto = new BoardDto();
		bdto.setId(rs.getInt("id"));
		bdto.setReadnum(rs.getInt("readnum"));
		bdto.setTitle(rs.getString("title"));
		bdto.setName(rs.getString("name"));
		bdto.setWriteday(rs.getString("writeday"));
		bdto.setContent(rs.getString("content"));
		bdto.setDest(rs.getString("dest"));
		bdto.setUserid(rs.getString("userid"));

		request.setAttribute("bdto", bdto);

		rs.close();
		pstmt.close();
		conn.close();
	}

	public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String title = request.getParameter("title");
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String content = request.getParameter("content");
		String id = request.getParameter("id");
		String[] imsi = request.getParameterValues("dest");
		String dest = "";
		for (int i = 0; i < imsi.length; i++) {
			dest = dest + imsi[i] + ",";
		}

		if (pwd == null || isPwdCheck(id, pwd)) {
			String sql = "update board set title=?, name=?, content=?,dest=? where id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, name);
			pstmt.setString(3, content);
			pstmt.setString(4, dest);
			pstmt.setString(5, id);

			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			response.sendRedirect("content.jsp?id=" + id);
		} else {
			conn.close();
			response.sendRedirect("update.jsp?id=" + id);
		}
	}

	public boolean isPwdCheck(String id, String pwd) throws Exception {
		String sql = "select pwd from board where id=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		rs.next();

		String xpwd = rs.getString("pwd");
		if (pwd.equals(xpwd))
			return true;
		else
			return false;
	}

	public void getFour(HttpServletRequest request) throws Exception {
		String sql = "select * from board  order by id desc limit 4";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		ArrayList<BoardDto> blist = new ArrayList<BoardDto>();
		while (rs.next()) {
			BoardDto bdto = new BoardDto();
			bdto.setId(rs.getInt("id"));

			String title;
			if (rs.getString("title").length() > 16)
				title = rs.getString("title").substring(0, 16) + "...";
			else
				title = rs.getString("title");

			bdto.setTitle(title);
			bdto.setWriteday(rs.getString("writeday"));

			blist.add(bdto);
		}
		request.setAttribute("blist", blist);
	}
}