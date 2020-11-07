package DAO;

import java.util.List;

import Model.Bug;

public interface BugDAO {

	public Bug getBugs();
	public Bug getBug(int bugId);
	public int insertBug(Bug bug);
	public void updateBug(Bug bug);
	public List<Integer> getBugsReportedSixMonths();
	public List<Integer> getBugsClosedSixMonths();
}
