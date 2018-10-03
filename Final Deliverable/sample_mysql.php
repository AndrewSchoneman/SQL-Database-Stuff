<?php
echo("<html><head><title>Sample PHP Script</title></head>\n");

//  hostname, username, password
$dbcnx = mysql_connect("dbdev.cs.uiowa.edu:3306","jyang23","Ax_-Z6zQJd2D");
echo((!$dbcnx));
if (!$dbcnx) {
  echo( "<P>Unable to connect to the " .
        "database server at this time.</P>\n" );
  exit();
}
mysql_select_db("db_jyang23",$dbcnx);
if (! @mysql_select_db("db_jyang23") ) {
  echo( "<P>Unable to locate the sample " .
        "database at this time.</P>" );
  exit();
}

echo("<h3> First query finds the total number of purchases for customers who have an average of over 4 stars </h3>\n");
echo("<h3> Second query finds the total amount purchased by buyers who have viewed ata least three items </h3>\n");
echo("<h3> Third query finds out which category of item has sold the most products since the start of year 2010</h3>\n");
# do a simple query and print it out
$sql_query="SELECT p.b_ID, count(p.b_ID) from purchase p inner join (select feedback.b_ID from feedback group by feedback.b_ID having avg(rating) > 3) x where x.b_ID = p.b_ID group by x.b_ID;";

$result_set = mysql_query($sql_query);
if (!$result_set) {
  echo("<P>Error performing query: " .
       mysql_error() . "</P>");
  exit();
}



echo("<h2>" . $sql_query . "</h2>");
echo("<table><tr><th>p.b_ID</th><th>count(p.b_ID)</th></tr>\n");
while ( $row = mysql_fetch_array($result_set) ) {
  echo("<tr><td>" . $row["b_ID"] . "</td>\n" .
       "     <td>" . $row["count(p.b_ID)"] . "</td>\n" .
       
       "</tr>\n");
}
echo ("</table>\n");

$sql_query="select p.b_ID, sum(p.totalCost) from purchase p inner join (select b_ID, count(b_ID) from views group by views.b_ID having count(views.b_ID) > 3) x on p.b_ID = x.b_ID group by p.b_ID;";

echo("<h2>" . $sql_query . "</h2>");
$result_set = mysql_query($sql_query);
if (!$result_set) {
  echo("<P>Error performing query: " .
       mysql_error() . "</P>");
  exit();
}

echo("<table><tr><th>p.b_ID</th><th>sum(p.totalCost)</th></tr>\n");
while ( $row = mysql_fetch_array($result_set) ) {
  echo("<tr><td>" . $row["b_ID"] . "</td>\n" .
       "     <td>" . $row["sum(p.totalCost)"] . "</td>\n" .
       
       "</tr>\n");
}
echo ("</table>\n");


$sql_query="select category, count(qn) as quantitySold from item natural join (select item_ID, qn from purchase natural join contain where purchase.p_ID = contain.p_ID and purchase.purchaseDate > '2010-01-01') x group by item.category order by quantitySold desc;";

echo("<h2>" . $sql_query . "</h2>");
$result_set = mysql_query($sql_query);
if (!$result_set) {
  echo("<P>Error performing query: " .
       mysql_error() . "</P>");
  exit();
}

echo("<table><tr><th>category</th><th>quantitySold</th></tr>\n");
while ( $row = mysql_fetch_array($result_set) ) {
  echo("<tr><td>" . $row["category"] . "</td>\n" .
       "     <td>" . $row["quantitySold"] . "</td>\n" .     
       "</tr>\n");
}
echo ("</table>\n");


echo ("</body></html>");
?>
