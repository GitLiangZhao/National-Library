package au.gov.libarary;

import org.junit.Test;

import au.gov.library.util.BookInfoUtil;


public class TestBookInfoUtil {

   @Test
   public void testGetBookInfo() {
     String content = BookInfoUtil.getBookInfo("1139336");
     content = content.replaceAll("\\\\n", "<br>");
     System.out.println(content);
   }
}
