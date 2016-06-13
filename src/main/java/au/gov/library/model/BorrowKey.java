package au.gov.library.model;

public class BorrowKey {
    private Long bookNumber;

    private Long patronNumber;

    public Long getBookNumber() {
        return bookNumber;
    }

    public void setBookNumber(Long bookNumber) {
        this.bookNumber = bookNumber;
    }

    public Long getPatronNumber() {
        return patronNumber;
    }

    public void setPatronNumber(Long patronNumber) {
        this.patronNumber = patronNumber;
    }
}