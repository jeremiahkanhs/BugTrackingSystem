package Controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.BugDAO;
import DAO.CommentDAO;
import Model.Bug;
import Model.Comment;
import Service.BugDAOImpl;
import Service.CommentDAOImpl;

/**
 * Servlet implementation class ReportBugController
 */
@WebServlet("/reportbug")
public class ReportBugController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BugDAO bd = new BugDAOImpl();
		CommentDAO cd = new CommentDAOImpl();
		int bugSeverity = Integer.parseInt(request.getParameter("bugseverity"));
		String bugTitle = request.getParameter("bugtitle");
		int bugAssigner = Integer.parseInt(request.getParameter("bugassigner"));
		int bugAssignee = Integer.parseInt(request.getParameter("bugassignee"));
		String bugDesc = request.getParameter("bugdescription");
		String bugStatus = request.getParameter("bugstatus");
		String commentDesc = request.getParameter("commentdescription");
		String bugId = request.getParameter("bugId");
		
		Bug b = new Bug();
		b.setBugAssignee(bugAssignee);
		b.setBugAssigner(bugAssigner);
		b.setBugDesc(bugDesc);
		b.setBugTitle(bugTitle);
		b.setBugSeverity(bugSeverity);
		b.setBugStatus(bugStatus);
		
		Comment c = new Comment();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
	    LocalDateTime now = LocalDateTime.now();  
		c.setCommentDesc(commentDesc);
		c.setCommentDate(dtf.format(now));
		
		b.setBugComment(c);
		
		
		//Creating bug - Bug Reporter
		if (bugId == null) {
			int currBugId = bd.insertBug(b);
			c.setBugId(currBugId);
			c.setUserId(b.getBugAssigner());
			cd.insertComment(c);
		}
		else if (bugId != null) {
			bd.updateBug(b);
			cd.insertComment(c);
		}
		request.getRequestDispatcher("dashboard.jsp").forward(request, response);
	}

}
