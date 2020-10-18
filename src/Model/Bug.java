package Model;

public class Bug {

	private int bugId;
	
	private int bugSeverity;
	
	private int bugAssigner;
	
	private int bugAssignee;

	private String bugTitle;
	
	private String bugDesc;
	
	private String bugStatus;
	
	private Comment bugComment;
	
	public Comment getBugComment() {
		return bugComment;
	}

	public void setBugComment(Comment bugComment) {
		this.bugComment = bugComment;
	}

	public int getBugAssigner() {
		return bugAssigner;
	}

	public void setBugAssigner(int bugAssigner) {
		this.bugAssigner = bugAssigner;
	}

	public int getBugAssignee() {
		return bugAssignee;
	}

	public void setBugAssignee(int bugAssignee) {
		this.bugAssignee = bugAssignee;
	}

	public int getBugId() {
		return bugId;
	}

	public void setBugId(int bugId) {
		this.bugId = bugId;
	}

	public int getBugSeverity() {
		return bugSeverity;
	}

	public void setBugSeverity(int bugSeverity) {
		this.bugSeverity = bugSeverity;
	}

	public String getBugTitle() {
		return bugTitle;
	}

	public void setBugTitle(String bugTitle) {
		this.bugTitle = bugTitle;
	}

	public String getBugDesc() {
		return bugDesc;
	}

	public void setBugDesc(String bugDesc) {
		this.bugDesc = bugDesc;
	}

	public String getBugStatus() {
		return bugStatus;
	}

	public void setBugStatus(String bugStatus) {
		this.bugStatus = bugStatus;
	}
}
