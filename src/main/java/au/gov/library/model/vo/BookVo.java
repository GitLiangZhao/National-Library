package au.gov.library.model.vo;

import au.gov.library.model.Book;

public class BookVo extends Book {
  private String priceVo;
  
  private String pubdate;
  
  public String getPubdate() {
    return pubdate;
  }
  public void setPubdate(String pubdate) {
    this.pubdate = pubdate;
  }
  public void setPriceVo(String priceVo) {
    this.priceVo = priceVo;
  }
  public String getPriceVo() {
    return this.priceVo;
  }
}
