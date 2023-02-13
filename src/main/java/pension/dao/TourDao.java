package pension.dao;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pension.dto.BoardDto;
import pension.dto.TourDto;

public class TourDao {
	Connection conn;
	public TourDao() throws Exception
	{
		// DB연결
	    Class.forName("com.mysql.jdbc.Driver"); 
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void write_ok(HttpServletRequest request, HttpServletResponse response,
    		HttpSession session) throws Exception
    {
    	// 파일 업로드 객체 생성
    	String path=request.getRealPath("/tour/img");
    	int size=1024*1024*10;
    	MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
    	
    	// 업로드파일의 갯수를 안다면
    	/*
    	    String f1=multi.getFilesystemName("fname1"); // input type="file" name="fname1"
    	    String f2=multi.getFilesystemName("fname2");
    	    String f3=multi.getFilesystemName("fname3");
    	    String f4=multi.getFilesystemName("fname4");  
    	*/
    	Enumeration file=multi.getFileNames();     // input type="file"의 name 전부 다 가져온다
    	// ( "fname1" , "fname2" , "fname3" , "fname4" , "fname5" )
    	
    	String fname="";
    	while(file.hasMoreElements())
    	{
    		// multi.getFilesystemName("fname1") ~~~  fname2 , fname3
    		fname=fname+multi.getFilesystemName(file.nextElement().toString())+","; // input태그의 name
    	}
        //System.out.println(fname);  // 41.jpg,31.jpg,21.jpg,11.jpg,
    	fname=fname.replace("null," , "");
    	
    	// 테이블에 저장할 값
    	String title=multi.getParameter("title");
    	String content=multi.getParameter("content");
    	String userid=session.getAttribute("userid").toString();
    	
    	// 쿼리 생성
    	String sql="insert into tour(title,content,fname,userid,writeday) values(?,?,?,?,now())";
    	
    	// 심부름꾼 생성
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, title);
    	pstmt.setString(2, content);
    	pstmt.setString(3, fname);
    	pstmt.setString(4, userid);
    	
    	// 쿼리 실행
    	pstmt.executeUpdate();
    	
    	// close
    	pstmt.close();
    	conn.close();
    	
    	// 이동
    	response.sendRedirect("list.jsp");
    }
	
	public void list(HttpServletRequest request) throws Exception
	{
		// request값
		// 쿼리문
		String sql="select t.id,t.title,m.name,t.readnum,t.writeday from member as m, tour as t ";
		sql=sql+" where m.userid=t.userid order by id desc";
		
		// 심부름꾼 생성
		PreparedStatement pstmt=conn.prepareStatement(sql);
		
		// 쿼리 실행
		ResultSet rs=pstmt.executeQuery();
		
		// rs => dto (ArrayList를 이용)
		ArrayList<TourDto> tlist=new ArrayList<TourDto>();
		
		while(rs.next()) 
		{
		    TourDto tdto=new TourDto();
		    tdto.setId(rs.getInt("id"));
		    tdto.setTitle(rs.getString("title"));
		    tdto.setName(rs.getString("name"));
		    tdto.setReadnum(rs.getInt("readnum"));
		    tdto.setWriteday(rs.getString("writeday"));
		    
		    tlist.add(tdto);
		}
		
		request.setAttribute("tlist", tlist);
		
	}
	
	public void readnum(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="update tour set readnum=readnum+1 where id=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("content.jsp?id="+id);
	}
	
	public void content(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="select * from tour where id=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		// rs => dto
		TourDto tdto=new TourDto();
	    tdto.setId(rs.getInt("id"));
	    tdto.setTitle(rs.getString("title"));
	    
	    // userid의 4자출력후 뒤에 내용은 *
	    String userid=rs.getString("userid");  // "abcdefgh"
	    int len=userid.length()-2;             // 4
	    userid=userid.substring(0,2);          // "abcd"
	    for(int i=0;i<len;i++)
	    {
	         userid=userid+"*";	               // "abcd****"
	    }
	    tdto.setUserid(userid);
	    
	    tdto.setReadnum(rs.getInt("readnum"));
	    tdto.setWriteday(rs.getString("writeday"));
	    tdto.setContent(rs.getString("content"));
	    //tdto.setFname(rs.getString("fname"));
	    
	    // 그림파일이름 나누기
	    String[] fname=rs.getString("fname").split(","); // aa.jfif,bb.jfif,21.jpg,
	    request.setAttribute("fname", fname);
	   
	    request.setAttribute("tdto", tdto);
	    
	    // 사용자 아이디를 request영역에 올리기
	    request.setAttribute("userid", rs.getString("userid"));
	}
	
	public void delete(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		
		// 삭제할 레코드의 fname필드의 값을 읽어와서 해당 파일을 삭제
		file_delete(id,request); // 메소드를 따로 생성하여 처리		
		
		String sql="delete from tour where id=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("list.jsp");
	}
	
	// 삭제할 레코드의 fname에 있는 파일 삭제
	public void file_delete(String id,HttpServletRequest request) throws Exception 
	{
		String sql="select fname from tour where id=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		String[] fname=rs.getString("fname").split(",");
		
		String path=request.getRealPath("/tour/img");
		
		for(int i=0;i<fname.length;i++)
		{
			File file=new File(path+"/"+fname[i]); // 생성자 : 경로/파일명
			if(file.exists())
				file.delete();
		}
	}
	
	public void update(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="select * from tour where id=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		TourDto tdto=new TourDto();
		tdto.setId(rs.getInt("id"));
		tdto.setTitle(rs.getString("title"));
		tdto.setContent(rs.getString("content"));
	    
		request.setAttribute("tdto", tdto);
		
		// file명은 ,로 구분된것을 split처리하여 배열로 전달
		String[] fname=rs.getString("fname").split(",");
		request.setAttribute("fname", fname);
	}
	
	public void update_ok(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		// 파일 업로드 객체 생성
    	String path=request.getRealPath("/tour/img");
    	int size=1024*1024*10;
    	MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
    	
    	// 삭제할 그림
    	String[] delimg=multi.getParameter("delimg").split(","); //"1.jpg , 2.jpg , "
    	for(int i=0;i<delimg.length;i++)
    	{
    		File file=new File(path+"/"+delimg[i]);
    		if(file.exists())
    			file.delete();
    	}
    	    	
    	// 남겨질 그림 + 추가 그림 => " 파일명,파일명, "
    	Enumeration enu=multi.getFileNames(); // "fname1 fname2 fname3 " input type="file"의 name을 읽어온다..    	
    	
    	// 저장된 파일의 이름을 구하기 => multi.getFilessystemName("fname1")
    	String chuga="";
    	while(enu.hasMoreElements())
    	{
    		chuga=chuga+multi.getFilesystemName(enu.nextElement().toString())+",";
    	}
    	
    	chuga=chuga.replace("null," , ""); // 그림을 선택X => null값이 오므로 null값을 없애기
    	
    	System.out.println(chuga);
    	
    	String eximg=multi.getParameter("eximg");
    	
    	String fname=eximg+chuga; // 남겨질그림+추가된 그림 이름들
    	String id=multi.getParameter("id");
        String title=multi.getParameter("title");
        String content=multi.getParameter("content");
        
        String sql="update tour set title=?, content=?, fname=? where id=?";
        
        PreparedStatement pstmt=conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, content);
        pstmt.setString(3, fname);
        pstmt.setString(4, id);
        
        pstmt.executeUpdate();
        
        pstmt.close();
        conn.close();
        
        response.sendRedirect("content.jsp?id="+id);
        		
	}
	
	// main.jsp에 나타낼 4개의 레코드를 읽어오는 메소드
    public void getFour(HttpServletRequest request) throws Exception
    {
    	String sql="select * from tour  order by id desc limit 4";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	ResultSet rs=pstmt.executeQuery();
    	
    	ArrayList<TourDto> tlist=new ArrayList<TourDto>();
    	
    	while(rs.next())
    	{
    		TourDto tdto=new TourDto();
    		tdto.setId(rs.getInt("id"));
    		
    		String title;
    		if(rs.getString("title").length()>16)
       			title=rs.getString("title").substring(0,16)+"...";
      		else
    			title=rs.getString("title");
    		
    		tdto.setTitle(title);
    		tdto.setWriteday(rs.getString("writeday"));
    		
    		tlist.add(tdto);
    	}
    	
    	request.setAttribute("tlist",tlist);
    	
    }
}








