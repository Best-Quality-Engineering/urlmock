package io.bestquality.protocol.mock;

import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;

import static io.bestquality.protocol.mock.MockConnectionRegistry.clearMockConnections;
import static io.bestquality.protocol.mock.MockConnectionRegistry.installProtocolHandlers;
import static io.bestquality.protocol.mock.MockConnectionRegistry.registerMockConnection;
import static java.net.Proxy.NO_PROXY;
import static java.util.regex.Pattern.compile;
import static org.assertj.core.api.Assertions.assertThat;

@RunWith(MockitoJUnitRunner.class)
public class MockConnectionTest {
    @Mock
    private URLConnection mockAllUrlConnection;
    @Mock
    private URLConnection mockUrlConnection;

    @BeforeClass
    public static void beforeClass() {
        installProtocolHandlers();
    }

    @Before
    public void setUp() {
        registerMockConnection(compile("mock://www.host.domain"), mockUrlConnection);
        registerMockConnection(mockAllUrlConnection);
    }

    @After
    public void tearDown() {
        clearMockConnections();
    }

    @Test
    public void shouldHandleMockSchemeUsingWildcardConnection()
            throws Exception {
        URL url = new URL("mock://www.host.domain");

        assertThat(url.openConnection())
                .isSameAs(mockUrlConnection);
        assertThat(url.openConnection(NO_PROXY))
                .isSameAs(mockUrlConnection);
    }

    @Test
    public void shouldHandleMockSchemeUsingSpecificConnection()
            throws Exception {
        URL url = new URL("mock://apex.domain");

        assertThat(url.openConnection())
                .isSameAs(mockAllUrlConnection);
        assertThat(url.openConnection(NO_PROXY))
                .isSameAs(mockAllUrlConnection);
    }

    @Test(expected = IOException.class)
    public void shouldClearConnections()
            throws Exception {
        clearMockConnections();
        URL url = new URL("mock://apex.domain");
        url.openConnection();
    }
}
