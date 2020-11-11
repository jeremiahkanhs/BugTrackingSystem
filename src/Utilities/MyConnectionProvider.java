package Utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyConnectionProvider implements MyProvider {
	
	static Connection con = null;
	
	public static Connection getCon() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(connUrl, username, pwd);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	
	 public int executeQuery(String query) throws ClassNotFoundException, SQLException {
		    return con.createStatement().executeUpdate(query);
	 }
}
