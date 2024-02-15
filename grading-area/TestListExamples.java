import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.contains("moon");
  }
}

public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

  @Test
  public void testMergeOutOfOrder() {
    List<String> left = Arrays.asList("b", "a", "c");
    List<String> right = Arrays.asList("d", "a", "d");
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d", "d");
    assertEquals(expected, ListExamples.merge(left, right));
  }

  @Test
  public void testFilter() {
    IsMoon sc = new IsMoon();
    List<String> initial = Arrays.asList("moon", "Moon", " moon", "mo on", "wefushdjo", "full moon tonight", "fullmoontonight", "fullmoon");
    List<String> expected = Arrays.asList("moon", " moon", "full moon tonight", "fullmoontonight", "fullmoon");
    assertEquals(expected, ListExamples.filter(initial, sc));
  }
}
