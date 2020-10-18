package DAO;

import Model.Comment;

public interface CommentDAO {

	public Comment getComment(int bugID);
	public int insertComment(Comment comment);
}
