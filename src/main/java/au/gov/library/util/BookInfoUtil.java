package au.gov.library.util;

import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class BookInfoUtil {
	public static String isbnUrl = "https://api.douban.com/v2/book/isbn/";
	public static String idUrl = "https://api.douban.com/v2/book/";

	public static String getBookByISBN(String isbn) {

		// DefaultHttpClient client = new DefaultHttpClient();
		CloseableHttpClient httpclient = HttpClients.createDefault();
		HttpGet request = new HttpGet(isbnUrl + isbn);
		HttpResponse response = null;
		try {
			response = httpclient.execute(request);
			HttpEntity entity = response.getEntity();
			return new String(EntityUtils.toString(entity).getBytes(), "utf-8");
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// httpclient.getConnectionManager().shutdown();
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public static String getBookImage(String id) {
		CloseableHttpClient client = HttpClients.createDefault();
		// HttpClient client = new DefaultHttpClient();
		HttpGet request = new HttpGet(idUrl + id + "?fields=images");
		try {
			HttpResponse response = client.execute(request);
			HttpEntity entity = response.getEntity();
			return new String(EntityUtils.toString(entity).getBytes(), "utf-8");
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				client.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public static String getBookInfo(String id) {
		CloseableHttpClient client = HttpClients.createDefault();
		// HttpClient client = new DefaultHttpClient();
		HttpGet request = new HttpGet(idUrl + id);
		try {
			HttpResponse response = client.execute(request);
			HttpEntity entity = response.getEntity();
			String content = new String(EntityUtils.toString(entity).getBytes(), "utf-8");
			return content;
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				client.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
}
