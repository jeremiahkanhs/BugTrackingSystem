package Service.tests;

import Model.Comment;
import Service.CommentDAOImpl;
import Utilities.MyConnectionProvider;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PowerMockIgnore;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static org.mockito.Mockito.when;
import static org.powermock.api.mockito.PowerMockito.mockStatic;


@RunWith(PowerMockRunner.class)
@PrepareForTest({MyConnectionProvider.class})
@PowerMockIgnore("jdk.internal.reflect.*")
public class CommentDaoImplTest {



    @Mock
    private Connection connection;

    @Mock
    private PreparedStatement preparedStatement;

    @Mock
    ResultSet resultSet;


    @InjectMocks
    private CommentDAOImpl commentDAO;


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
    public void getComment()
    {
        Assert.assertNotNull(commentDAO.getComment(12));
    }

    @Test
    public void insertComment()
    {
        Assert.assertEquals(0,commentDAO.insertComment(new Comment()));
    }
}
