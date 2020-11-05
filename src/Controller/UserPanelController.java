package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.RoleDAO;
import DAO.UserDAO;
import Model.Role;
import Model.User;
import Service.RoleDAOImpl;
import Service.UserDAOImpl;

@WebServlet("/userAccount")
public class UserPanelController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserDAO ud = new UserDAOImpl();
		RoleDAO rd = new RoleDAOImpl();
		
		String submitType = request.getParameter("submit");
		String userName = request.getParameter("userName");
		
		if (submitType.equals("Edit")) {
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String emailAddress = request.getParameter("emailAddress");
			String userRole = request.getParameter("userRole");
			
			User u = ud.getUser(userName);
			if (u != null) {
				u.setFirstName(firstName);
				u.setLastName(lastName);
				u.setEmailAddress(emailAddress);
				u.setUserRole(rd.getRole(userRole));
			}
			ud.updateUser(u);
		} else if (submitType.equals("Delete")) {
			ud.deleteUser(userName);
		} else if (submitType.equals("Create")) {
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String emailAddress = request.getParameter("emailAddress");
			String userRole = request.getParameter("userRole");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			User check = ud.checkDuplicate(username, emailAddress);
			
			if (check.getEmailAddress() == null && check.getUsername() == null) {
				User u = new User();
				u.setEmailAddress(emailAddress);
				u.setFirstName(firstName);
				u.setLastName(lastName);
				u.setUsername(username);
				u.setPassword(password);
				
				Role r = rd.getRole(userRole);
				u.setUserRole(r);
				ud.insertUser(u);
			}
			else {
				request.setAttribute("errorMessage", "Duplicate Username Or Email Address.");
				request.getRequestDispatcher("register.jsp").forward(request, response);
			}
		}
		
		request.getRequestDispatcher("adminpanel.jsp").forward(request, response);
	}
	
}

