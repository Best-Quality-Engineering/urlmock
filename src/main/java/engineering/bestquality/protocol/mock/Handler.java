package engineering.bestquality.protocol.mock;

import java.io.IOException;
import java.net.Proxy;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLStreamHandler;

import static engineering.bestquality.protocol.mock.MockConnectionRegistry.findMockConnection;

/**
 * This class handles all URLs using the "mock:" scheme
 */
public class Handler
        extends URLStreamHandler {

    @Override
    public URLConnection openConnection(URL url)
            throws IOException {
        return findMockConnection(url);
    }

    @Override
    protected URLConnection openConnection(URL url, Proxy p)
            throws IOException {
        return findMockConnection(url);
    }
}

