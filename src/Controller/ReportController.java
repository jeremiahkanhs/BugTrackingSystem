package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import DAO.BugDAO;
import DAO.UserDAO;
import Service.BugDAOImpl;
import Service.UserDAOImpl;

/**
 * Servlet implementation class ReportBugController
 */
@WebServlet("/reports")
public class ReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if (request.getParameter("reportType").equals("bugreportedsixmonths")) {
			BugDAO bd = new BugDAOImpl();
			Integer [] bugsCount = bd.getBugsReportedSixMonths().stream().toArray(Integer[] ::new);
			response.getWriter().write(new Gson().toJson(bugsCount, Integer[].class));
		} else if (request.getParameter("reportType").equals("bugclosedsixmonths")) {
			BugDAO bd = new BugDAOImpl();
			Integer [] bugsCount = bd.getBugsClosedSixMonths().stream().toArray(Integer[] ::new);
			response.getWriter().write(new Gson().toJson(bugsCount, Integer[].class));
		} else if (request.getParameter("reportType").equals("toptendevelopers")) {
			UserDAO ud = new UserDAOImpl();
			String [] topDevelopers = ud.getTopTenDevelopers().stream().toArray(String[] :: new);
			response.getWriter().write(new Gson().toJson(topDevelopers, String[].class));
		}
	}


}
