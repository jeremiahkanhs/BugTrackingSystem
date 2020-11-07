package Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import DAO.UserDAO;
import Model.Role;
import Model.User;
import Utilities.MyConnectionProvider;

public class UserDAOImpl implements UserDAO {

	static Connection con;
	static PreparedStatement ps;
	
	@Override
	public int insertUser(User u) {
		int status = 0;
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("insert into users (username, password, role_id, first_name, last_name, email_address) values (?, ?, ?, ?, ?, ?)");
			ps.setString(1, u.getUsername());
			ps.setString(2, u.getPassword());
			ps.setInt(3, u.getUserRole().getRoleId());
			ps.setString(4, u.getFirstName());
			ps.setString(5, u.getLastName());
			ps.setString(6, u.getEmailAddress());
			status = ps.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public User getUser(String username, String password) {
		User u = new User();
		Role r = new Role();
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("select * from users u inner join roles r on u.role_id = r.role_id where u.username = ? and u.password = ?");
			ps.setString(1, username);
			ps.setString(2, password);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				System.out.println (rs.getString(2) + " " + rs.getString(3));
				u.setUserId(Integer.parseInt(rs.getString(1)));
				u.setUsername(rs.getString(2));
				u.setPassword(rs.getString(3));
				r.setRoleId(Integer.parseInt(rs.getString(4)));
				r.setRoleName(rs.getString(9));
				r.setRoleDesc(rs.getString(10));
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		u.setUserRole(r);
		return u;
	}

	@Override
	public User getUser(String username) {
		User u = new User();
		Role r = new Role();
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("select * from users u inner join roles r on u.role_id = r.role_id where u.username = ?");
			ps.setString(1, username);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				u.setUsername(rs.getString(2));
				u.setPassword(rs.getString(3));
				r.setRoleId(Integer.parseInt(rs.getString(4)));
				r.setRoleName(rs.getString(9));
				r.setRoleDesc(rs.getString(10));
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		u.setUserRole(r);
		return u;
	}
	
	@Override
	public User getUser(int userId) {
		User u = new User();
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("select * from users where user_id = ?");
			ps.setInt(1, userId);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				u.setFirstName(rs.getString(5));
				u.setLastName(rs.getString(6));
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return u;
	}

	@Override
	public void updateUser(User u) {
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("update users set first_name = ?, last_name = ?, email_address = ?, role_id = ? where username = ?");
			ps.setString(1, u.getFirstName());
			ps.setString(2, u.getLastName());
			ps.setString(3, u.getEmailAddress());
			ps.setLong(4, u.getUserRole().getRoleId());
			ps.setString(5, u.getUsername());
			System.out.println(u.getFirstName());
			System.out.println(u.getLastName());
			System.out.println(u.getEmailAddress());
			System.out.println(u.getUserRole().getRoleId());
			System.out.println(u.getUsername());
			
			ps.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteUser(String username) {
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("delete from users where username = ?");
			ps.setString(1, username);
			ps.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<User> getAllUsers() {
		User u = new User();
		Role r = new Role();
		List<User> userList = new ArrayList<>();
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("select * from users u inner join roles r on u.role_id = r.role_id");
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				u.setUserId(Integer.parseInt(rs.getString(1)));
				u.setUsername(rs.getString(2));
				u.setPassword(rs.getString(3));
				u.setFirstName(rs.getString(5));
				u.setLastName(rs.getString(6));
				u.setEmailAddress(rs.getString(7));
				r.setRoleId(Integer.parseInt(rs.getString(8)));
				r.setRoleName(rs.getString(9));
				r.setRoleDesc(rs.getString(10));
				u.setUserRole(r);
				userList.add(u);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return userList;
	}
	
	@Override
	public List <String> getTopTenDevelopers() {
		List<String> userList = new ArrayList<>();
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("select count(*), c.user_id from bugs b inner join comments c on b.bug_id = c.bug_id where c.user_id in "
										+ "(select u.user_id from users u where role_id = 194) group by c.user_id order by c.user_id desc limit 10");
			
			ResultSet rs = ps.executeQuery();
			int count;
			String name;
			while(rs.next()) {
				count = Integer.parseInt(rs.getString(1));
				name = getUser(Integer.parseInt(rs.getString(2))).getFirstName() + getUser(Integer.parseInt(rs.getString(2))).getLastName();
				userList.add(name);
				userList.add(Integer.toString(count));
				
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return userList;
	}
	
	@Override
	public User checkDuplicate(String username, String emailAddress) {
		User u = new User();
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("select * from users u where u.username = ? or u.email_address = ?");
			ps.setString(1, username);
			ps.setString(2, emailAddress);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				System.out.println (rs.getString(2) + " " + rs.getString(7));
				u.setUsername(rs.getString(2));
				u.setEmailAddress(rs.getString(7));
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return u;
	}

}
