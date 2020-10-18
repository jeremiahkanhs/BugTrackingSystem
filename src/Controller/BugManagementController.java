package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.BugDAO;
import Model.Bug;
import Service.BugDAOImpl;

/**
 * Servlet implementation class BugManagementController
 */
@WebServlet("/BugManagement")
public class BugManagementController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Object roleId = request.getParameter("roleId");
		String bugId = request.getParameter("bugId");
		
		//Creating new bug if role is bug reporter
		if (bugId == null && roleId.equals("192")) {
			request.getRequestDispatcher("bugmanagement.jsp").forward(request, response);
		}//Managing a bug for triager, developer, reviewer
		else if (bugId != null && roleId != null) {
			BugDAO bd = new BugDAOImpl();
			Bug b = bd.getBug(Integer.parseInt(bugId)); 
			request.setAttribute("bugseverity", Integer.toString(b.getBugSeverity()));
			request.setAttribute("bugstatus", b.getBugStatus());
			request.setAttribute("bugtitle", b.getBugTitle());
			request.setAttribute("bugdesc", b.getBugDesc());
			request.setAttribute("bugassigner", Integer.toString(b.getBugAssigner()));
			request.setAttribute("bugassignee", Integer.toString(b.getBugAssigner()));
			request.setAttribute("bugId", Integer.toString(b.getBugId()));
			System.out.println("I am here");
			request.getRequestDispatcher("bugmanagement.jsp").forward(request, response);
		}
	}
}
