package Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DAO.BugDAO;
import Model.Bug;
import Utilities.MyConnectionProvider;

public class BugDAOImpl implements BugDAO{
	
	static Connection con;
	static PreparedStatement ps;

	@Override
	public Bug getBugs() {
		Bug b = new Bug();
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("select * from bugs");
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				b.setBugId(Integer.parseInt(rs.getString(1)));
				b.setBugAssigner(Integer.parseInt(rs.getString(2)));
				b.setBugAssignee(Integer.parseInt(rs.getString(3)));
				b.setBugTitle(rs.getString(4));
				b.setBugDesc(rs.getString(5));
				b.setBugSeverity(Integer.parseInt(rs.getString(5)));
				b.setBugStatus(rs.getString(6));
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return b;
	}
	
	@Override
	public Bug getBug(int bugId) {
		Bug b = new Bug();
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("select * from bugs where bug_id = ?");
			ps.setInt(1, bugId);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				b.setBugId(Integer.parseInt(rs.getString(1)));
				b.setBugAssigner(Integer.parseInt(rs.getString(2)));
				b.setBugAssignee(Integer.parseInt(rs.getString(3)));
				b.setBugTitle(rs.getString(4));
				b.setBugDesc(rs.getString(5));
				b.setBugSeverity(Integer.parseInt(rs.getString(6)));
				b.setBugStatus(rs.getString(7));
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return b;
	}

	@Override
	public int insertBug(Bug bug) {
		int bug_id = 0;
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("select max(bug_id) as max_id from bugs");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				if ((rs.getString(1)) == null)
					bug_id = 1;
				else
					bug_id = Integer.parseInt(rs.getString(1)) + 1;
			}
			
			ps = con.prepareStatement("insert into bugs (user_assigner_id, user_assignee_id, bug_title, bug_desc, bug_severity, bug_status, bug_id) value (?, ?, ?, ?, ?, ?, ?)");
			ps.setInt(1, bug.getBugAssigner());
			ps.setInt(2, bug.getBugAssignee());
			ps.setString(3, bug.getBugTitle());
			ps.setString(4, bug.getBugDesc());
			ps.setInt(5, bug.getBugSeverity());
			ps.setString(6, bug.getBugStatus());
			ps.setInt(7, bug_id);
			ps.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bug_id;
	}
	
	@Override
	public void updateBug(Bug bug) {
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("update bugs set user_assigner_id = ?,  user_assignee_id = ?, bug_title = ?, bug_desc = ?, bug_severity = ?, bug_status = ? where bug_id = ?");
			ps.setInt(1, bug.getBugAssigner());
			ps.setInt(2, bug.getBugAssignee());
			ps.setString(3, bug.getBugTitle());
			ps.setString(4, bug.getBugDesc());
			ps.setInt(5, bug.getBugSeverity());
			ps.setString(6, bug.getBugStatus());
			ps.setInt(7, bug.getBugId());
			ps.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
