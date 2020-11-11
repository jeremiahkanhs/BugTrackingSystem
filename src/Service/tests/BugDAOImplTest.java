package Service.tests;

import Model.Bug;
import Service.BugDAOImpl;
import Utilities.MyConnectionProvider;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.*;
import org.powermock.core.classloader.annotations.PowerMockIgnore;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.powermock.api.mockito.PowerMockito;

import java.sql.*;

import static org.mockito.Mockito.when;
import static org.powermock.api.mockito.PowerMockito.mockStatic;


@RunWith(PowerMockRunner.class)
@PrepareForTest({MyConnectionProvider.class})
@PowerMockIgnore("jdk.internal.reflect.*")
public class BugDAOImplTest {


    @Mock
    private Connection connection;

    @Mock
    private PreparedStatement preparedStatement;

    @Mock
    ResultSet resultSet;


    @InjectMocks
    private BugDAOImpl bugDAO;


    @Before
    public void setup() throws SQLException
    {

        mockStatic(MyConnectionProvider.class);
        PowerMockito.when(MyConnectionProvider.getCon()).thenReturn(connection);
        when(connection.prepareStatement(Mockito.any())).thenReturn(preparedStatement);
        Mockito.when(resultSet.getString(Mockito.any())).thenReturn("test");
        when(preparedStatement.executeQuery()).thenReturn(resultSet);

    }

    @Test
    public void getBugs()
    {
        Assert.assertNotNull(bugDAO.getBugs());
    }


    @Test
    public void getBug()
    {
        Assert.assertNotNull(bugDAO.getBug(12));
    }

    @Test
    public void getBugReportedLastSixMonth()
    {
        Assert.assertNotNull(bugDAO.getBugsReportedSixMonths());
    }

    @Test
    public void getBugClosedLastSixMonth()
    {
        Assert.assertNotNull(bugDAO.getBugsClosedSixMonths());
    }

    @Test
    public void insertBug()
    {
        Assert.assertEquals(0,bugDAO.insertBug(new Bug()));
    }

    @Test
    public void updateBug()
    {
        bugDAO.updateBug(new Bug());
    }

}
