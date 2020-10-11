package Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DAO.RoleDAO;
import Model.Role;
import Utilities.MyConnectionProvider;

public class RoleDAOImpl implements RoleDAO {
	
	static Connection con;
	static PreparedStatement ps;

	@Override
	public Role getRole(String roleDesc) {
		Role r = new Role();
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("select * from roles where role_desc = ?");
			ps.setString(1, roleDesc);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				r.setRoleId(Integer.parseInt(rs.getString(1)));
				r.setRoleName(rs.getString(2));
				r.setRoleDesc(rs.getString(3));
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return r;
	}

}
