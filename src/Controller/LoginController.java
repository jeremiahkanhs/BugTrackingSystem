package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.UserDAO;
import Model.User;
import Service.UserDAOImpl;

@WebServlet("/login")
public class LoginController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserDAO ud = new UserDAOImpl();
		String userName = request.getParameter("username");
		String password = request.getParameter("userpassword");
		System.out.println(userName + " " + password);
		User u = ud.getUser(userName, password);
		
		if (u.getPassword() != null) {
			HttpSession session = request.getSession();
			session.setAttribute("sessionID", userName);
			session.setAttribute("userId", Integer.valueOf(u.getUserId()));
			session.setAttribute("roleId", u.getUserRole().getRoleId());
			if (u.getUserRole().getRoleId() != 191)
				request.getRequestDispatcher("dashboard.jsp").forward(request, response);
			else
				request.getRequestDispatcher("adminpanel.jsp").forward(request, response);
			
		} else {
			request.setAttribute("errorMessage", "Please enter correct login details.");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
		
	}
	
}
