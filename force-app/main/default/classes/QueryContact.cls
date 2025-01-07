public class QueryContact {
    public static Id getContactID(String lastName, String title) {
      try {
        Contact myContact = Database.query(
          'SELECT ID FROM Contact WHERE lastName = :lastName AND title = :title LIMIT 1'
        );
        return myContact.Id;
      } catch (Exception ex) {
        return null;
      }
    }
    public static Id getContactIDWithBinds(Map<String, Object> bindVars) {
        return Database.queryWithBinds('SELECT ID FROM Contact WHERE lastName = :lastName AND title = :title LIMIT 1', bindVars, AccessLevel.USER_MODE).ID;
      }
  }