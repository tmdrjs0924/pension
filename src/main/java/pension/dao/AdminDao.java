package pension.dao;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pension.dto.EventDto;
import pension.dto.MantoDto;
import pension.dto.MemberDto;
import pension.dto.ReserveDto;
import pension.dto.RoomDto;
import util.MyJob;

public class AdminDao {

	Connection conn;

	public AdminDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/pension";
		conn = DriverManager.getConnection(db, "root", "1234");
	}

	public void admin_member(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws Exception {
		if (session.getAttribute("userid") == null || !(session.getAttribute("userid").equals("admin"))) {
			response.sendRedirect("../main/main.jsp");
		} else {
			String sql = "select * from member order by name asc";

			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			ArrayList<MemberDto> mlist = new ArrayList<MemberDto>();
			while (rs.next()) {
				MemberDto mdto = new MemberDto();
				mdto.setId(rs.getInt("id"));
				mdto.setUserid(rs.getString("userid"));
				mdto.setName(rs.getString("name"));
				mdto.setPhone(rs.getString("phone"));
				mdto.setWriteday(rs.getString("writeday"));
				mdto.setState(rs.getInt("state"));

				mlist.add(mdto);
			}
			request.setAttribute("mlist", mlist);
		}
	}

	public void member_out_ok(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws Exception {
		if (session.getAttribute("userid") == null || !(session.getAttribute("userid").equals("admin"))) {
			response.sendRedirect("../main/main.jsp");
		} else {
			String id = request.getParameter("id");
			String sql = "update member set state=2 where id=?";

			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);

			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			response.sendRedirect("admin_member.jsp");
		}
	}

	public void admin_manto(HttpServletRequest request) throws Exception {
		String sql = "select * from manto order by id desc";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		ArrayList<MantoDto> mlist = new ArrayList<MantoDto>();
		while (rs.next()) {
			MantoDto mdto = new MantoDto();
			mdto.setId(rs.getInt("id"));
			mdto.setQue(rs.getInt("que"));
			mdto.setContent(rs.getString("content"));
			mdto.setUserid(rs.getString("userid"));
			mdto.setState(rs.getInt("state"));
			mdto.setWriteday(rs.getString("writeday"));

			mlist.add(mdto);
		}
		request.setAttribute("mlist", mlist);
	}

	public void answer(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String content = request.getParameter("content");
		// 폼의 content내용은 answer필드에 저장해야 됨
		String sql = "update manto set answer=? , state=1 where id=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, content);
		pstmt.setString(2, id);

		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		response.sendRedirect("admin_manto.jsp");
	}

	public void answer_view(HttpServletRequest request, JspWriter out) throws Exception {
		String id = request.getParameter("id");
		String sql = "select answer from manto where id=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);

		ResultSet rs = pstmt.executeQuery();
		rs.next();
		out.print(rs.getString("answer").replace("\r\n", "<br>"));
	}

	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String table = request.getParameter("table");
		String id = request.getParameter("id");
		String referer = request.getHeader("referer");
		String sql = "delete from " + table + " where id=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);

		if (table.equals("tour")) {
			TourDao tdao = new TourDao();
			tdao.file_delete(id, request);
		}

		pstmt.executeUpdate();
		pstmt.close();
		conn.close();

		switch (table) {
		case "gongji":
			response.sendRedirect("glist.jsp");
		case "board":
			response.sendRedirect("blist.jsp");
		case "tour":
			response.sendRedirect("tlist.jsp");
		}
	}

	public void admin_reserve(HttpServletRequest request) throws Exception {
		String sql = "select r1.id,r1.inday,r1.outday,r1.userid,r1.chacol,r1.bbq,r1.tprice,r2.name from reserve as r1 inner join room as r2 on r1.room_id=r2.id";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		ArrayList<ReserveDto> rlist = new ArrayList<ReserveDto>();
		while (rs.next()) {
			ReserveDto rdto = new ReserveDto();
			rdto.setId(rs.getInt("id"));
			rdto.setInday(rs.getString("inday"));
			rdto.setOutday(rs.getString("outday"));
			rdto.setUserid(rs.getString("userid"));
			rdto.setChacol(rs.getInt("chacol"));
			rdto.setBbq(rs.getInt("bbq"));
			rdto.setTprice(rs.getInt("tprice"));
			rdto.setName(rs.getString("name"));
			// 입,퇴실일을 이용하여 숙박일수 구하기
			long day = MyJob.getUntil(rs.getString("inday"), rs.getString("outday"));
			rdto.setSuk(day);

			rlist.add(rdto);
		}
		request.setAttribute("rlist", rlist);
	}

	public void getInfo(HttpServletRequest request, JspWriter out) throws Exception {
		String userid = request.getParameter("userid");
		String sql = "select sum(tprice) as hap, count(*) as cnt from reserve where userid=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);

		ResultSet rs = pstmt.executeQuery();
		rs.next();

		out.print(" 예약 횟수: " + rs.getInt("cnt") + "일");
		out.print("<br>");
		out.print(" 총 결제액: " + String.format("%,d", rs.getInt("hap")) + "원");
	}

	public void getRoom(HttpServletRequest request) throws Exception {
		String sql = "select * from room order by min asc";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		ArrayList<RoomDto> rlist = new ArrayList<RoomDto>();
		while (rs.next()) {
			RoomDto rdto = new RoomDto();
			rdto.setName(rs.getString("name"));
			rdto.setId(rs.getInt("id"));
			rdto.setImg(rs.getString("img"));
			rdto.setPrice(rs.getInt("price"));
			rdto.setMin(rs.getInt("min"));
			rdto.setMax(rs.getInt("max"));
			rdto.setContent(rs.getString("content"));
			rdto.setWriteday(rs.getString("writeday"));

			rlist.add(rdto);
		}
		request.setAttribute("rlist", rlist);
	}

	public void room_add_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String path = request.getRealPath("/room/img");
		int size = 1024 * 1024 * 10;
		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

		String name = multi.getParameter("name");
		String img = multi.getFilesystemName("img1");
		img = img + "," + multi.getFilesystemName("img2");
		img = img + "," + multi.getFilesystemName("img3");
		img = img + "," + multi.getFilesystemName("img4");
		img = img + "," + multi.getFilesystemName("img5");
		img = img + "," + multi.getFilesystemName("img6") + ",";

		img = img.replace("null,", "");

		String price = multi.getParameter("price");
		String min = multi.getParameter("min");
		String max = multi.getParameter("max");
		String content = multi.getParameter("content");
		String sql = "insert into room(name,img,price,min,max,content,writeday) values(?,?,?,?,?,?,now())";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, img);
		pstmt.setString(3, price);
		pstmt.setString(4, min);
		pstmt.setString(5, max);
		pstmt.setString(6, content);

		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		response.sendRedirect("admin_room.jsp");
	}

	public void room_update(HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		String sql = "select * from room where id=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		rs.next();

		RoomDto rdto = new RoomDto();
		rdto.setName(rs.getString("name"));
		rdto.setId(rs.getInt("id"));
		rdto.setImg(rs.getString("img"));
		rdto.setPrice(rs.getInt("price"));
		rdto.setMin(rs.getInt("min"));
		rdto.setMax(rs.getInt("max"));
		rdto.setContent(rs.getString("content"));
		rdto.setWriteday(rs.getString("writeday"));

		request.setAttribute("rdto", rdto);
	}

	public void room_update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String path = request.getRealPath("/room/img");
		int size = 1024 * 1024 * 10;
		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

		String[] delimg = multi.getParameter("delimg").split(",");
		for (int i = 0; i < delimg.length; i++) {
			File file = new File(path + "/" + delimg[i]);
			if (file.exists())
				file.delete();
		}

		String eximg = multi.getParameter("eximg");
		String img = multi.getFilesystemName("img1");
		img = img + "," + multi.getFilesystemName("img2");
		img = img + "," + multi.getFilesystemName("img3");
		img = img + "," + multi.getFilesystemName("img4");
		img = img + "," + multi.getFilesystemName("img5");
		img = img + "," + multi.getFilesystemName("img6") + ",";
		img = img.replace("null,", "");
		img = eximg + img;

		String id = multi.getParameter("id");
		String name = multi.getParameter("name");
		String price = multi.getParameter("price");
		String min = multi.getParameter("min");
		String max = multi.getParameter("max");
		String content = multi.getParameter("content");
		String sql = "update room set name=?,img=?,price=?,min=?,max=?,content=? where id=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, img);
		pstmt.setString(3, price);
		pstmt.setString(4, min);
		pstmt.setString(5, max);
		pstmt.setString(6, content);
		pstmt.setString(7, id);

		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		response.sendRedirect("admin_room.jsp");
	}

	public void room_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String referer = request.getHeader("referer");
		String sql = "delete from room where id=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);

		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		response.sendRedirect(referer);
	}

	public void admin_event_add_ok(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String path = request.getRealPath("/event/img");
		int size = 1024 * 1024 * 10;
		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

		String title = multi.getParameter("title");
		String img = multi.getFilesystemName("img");
		String sql = "insert into event(title,img,writeday) values(?,?,now())";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, img);

		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		response.sendRedirect("admin_event_list.jsp");
	}

	public void main_list(HttpServletRequest request) throws Exception {
		String sql = "select * from event order by id desc";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		ArrayList<EventDto> elist = new ArrayList<EventDto>();
		while (rs.next()) {
			EventDto edto = new EventDto();
			edto.setId(rs.getInt("id"));
			edto.setTitle(rs.getString("title"));
			edto.setImg(rs.getString("img"));
			edto.setWriteday(rs.getString("writeday"));

			elist.add(edto);
		}
		request.setAttribute("elist", elist);
	}

	public void event_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String sql = "select img from event where id=?";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		rs.next();

		String[] img = rs.getString("img").split(",");
		String path = request.getRealPath("/event/img");
		for (int i = 0; i < img.length; i++) {
			File file = new File(path + "/" + img[i]);
			if (file.exists())
				file.delete();
		}

		String sql2 = "delete from event where id=?";

		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setString(1, id);

		pstmt2.executeUpdate();
		pstmt2.close();
		conn.close();
		response.sendRedirect("admin_event_list.jsp");
	}
}