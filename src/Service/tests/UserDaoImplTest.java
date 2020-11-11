package Service.tests;

import Model.Role;
import Model.User;
import Service.UserDAOImpl;
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
public class UserDaoImplTest {

    @Mock
    private Connection connection;

    @Mock
    private PreparedStatement preparedStatement;

    @Mock
    ResultSet resultSet;


    @InjectMocks
    private UserDAOImpl userDAO;

    private User u;


    @Before
    public void setup() throws SQLException
    {

        mockStatic(MyConnectionProvider.class);
        PowerMockito.when(MyConnectionProvider.getCon()).thenReturn(connection);
        when(connection.prepareStatement(Mockito.any())).thenReturn(preparedStatement);
        Mockito.when(resultSet.getString(Mockito.any())).thenReturn("test");
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        u = new User();
        u.setFirstName("joe");
        u.setLastName("foo");
        u.setUsername("admin");
        u.setPassword("admin");
        u.setEmailAddress("joe@test.com");
        u.setUserId(234);
        u.setUserRole(new Role());

    }

    @Test
    public void insertUser()
    {
        Assert.assertEquals(0, userDAO.insertUser(u));
    }

    @Test
    public void getUserById()
    {
        Assert.assertNotNull(userDAO.getUser(12));
    }

    @Test
    public void getUserByUsername()
    {
        Assert.assertNotNull(userDAO.getUser("admin"));
    }

    @Test
    public void getUserByUsernameandPassword()
    {
        Assert.assertNotNull(userDAO.getUser("admin","admin"));
    }

    @Test
    public void getAllUsers()
    {
        Assert.assertNotNull(userDAO.getAllUsers());
    }

    @Test
    public void getAllTopTenDevelopers()
    {
        Assert.assertNotNull(userDAO.getTopTenDevelopers());
    }

    @Test
    public void updateUser()
    {

        userDAO.updateUser(u);
    }

    @Test
    public void deleteUser()
    {
        userDAO.deleteUser("admin");
    }


}
