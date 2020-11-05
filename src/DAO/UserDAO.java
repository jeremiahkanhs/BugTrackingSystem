package DAO;

import java.util.List;

import Model.User;

public interface UserDAO {

	public int insertUser(User u);
	public List <User> getAllUsers();
	public User getUser(String username, String password);
	public User getUser(String username);
	public User getUser(int userId);
	public void updateUser (User u);
	public void deleteUser (String username);
	public User checkDuplicate(String username, String emailAddress);
}
