package Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DAO.CommentDAO;
import Model.Comment;
import Utilities.MyConnectionProvider;

public class CommentDAOImpl implements CommentDAO{

	static Connection con;
	static PreparedStatement ps;
	
	@Override
	public Comment getComment(int bugId) {
		Comment c = new Comment();
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("select * from comments where bug_id = ?");
			ps.setInt(1, bugId);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				c.setCommentDesc(rs.getString(3));
				c.setCommentDate(rs.getString(4));
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return c;
	}
	
	@Override
	public int insertComment(Comment comment) {
		int status = 0;
		try {
			con = MyConnectionProvider.getCon();
			ps = con.prepareStatement("insert into comments (bug_id, comment_desc, comment_date, user_id) values (?, ?, ?, ?)");
			ps.setInt(1, comment.getBugId());
			ps.setString(2, comment.getCommentDesc());
			ps.setString(3, comment.getCommentDate());
			ps.setInt(4, comment.getUserId());
			
			status = ps.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
}
