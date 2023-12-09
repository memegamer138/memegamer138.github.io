<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>GameVault Products</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>

	body {
		background-color: black;
		color: white;
	}

	.button {
		display: inline-block;
		background-color: #0066cc;
		color: #ffffff;
	}

	.button:hover {
		background-color: #0056b3;
	}

</style>
</head>

<body>

<%@ include file="header.jsp" %>

<h2>Browse Products By Category and Search by Product Name:</h2>

<form method="get" action="listprod.jsp">
	<p align="left">
	<select size="1" name="categoryName" style="color: black;">
		<option style="color: black;">All</option>
		<option style="color: black;">PlayStation</option>
		<option style="color: black;">Xbox</option>
		<option style="color: black;">PC</option>
		<option style="color: black;">Nintendo Switch</option>
		<option style="color: black;">Accessories</option>      
	</select>
	<input type="text" name="productName" size="50" class="input" style="color: black;">
	<input type="submit" value="Submit" style="color: black;"><input type="reset" value="Reset" style="color: black;"></p><br>
	</form>
<form method="get" action="showcart.jsp">
	<button type="submit" class="button">View Cart</button>
</form>


<%
// Colors for different item categories
HashMap<String,String> colors = new HashMap<String,String>();        // This may be done dynamically as well, a little tricky...
colors.put("PlayStation", "#0000FF");
colors.put("Xbox", "#FF0000");
colors.put("PC", "#FFFF00");
colors.put("Nintendo Switch", "#6600CC");
colors.put("Accessories", "#55A5B3");

%>

<%
// Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("categoryName");

boolean hasNameParam = name != null && !name.equals("");
boolean hasCategoryParam = category != null && !category.equals("") && !category.equals("All");
String filter = "", sql = "";

if (hasNameParam && hasCategoryParam)
{
	filter = "<h3>Products containing '"+name+"' in category: '"+category+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT productId, productName, productPrice, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE productName LIKE ? AND categoryName = ?";
}
else if (hasNameParam)
{
	filter = "<h3>Products containing '"+name+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT productId, productName, productPrice, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE productName LIKE ?";
}
else if (hasCategoryParam)
{
	filter = "<h3>Products in category: '"+category+"'</h3>";
	sql = "SELECT productId, productName, productPrice, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE categoryName = ?";
}
else
{
	filter = "<h3>All Products</h3>";
	sql = "SELECT productId, productName, productPrice, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId";
}

out.println(filter);

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try {
	getConnection();
	Statement stmt = con.createStatement();             
	stmt.execute("USE orders");
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	if (hasNameParam) {
		pstmt.setString(1, name);    
		if (hasCategoryParam)
		{
			pstmt.setString(2, category);
		}
	}
	else if (hasCategoryParam)
	{
		pstmt.setString(1, category);
	}
	
	ResultSet rst = pstmt.executeQuery();
	
	out.print("<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th class=\"col-md-1\"></th><th>Product Name</th>");
	out.println("<th>Category</th><th>Price</th></tr>");
	while (rst.next()) {
		int id = rst.getInt(1);
		out.print("<td class=\"col-md-1\"><a href=\"addcart.jsp?id=" + id + "&name=" + rst.getString(2)
				+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a></td>");

		String itemCategory = rst.getString(4);
		String color = (String) colors.get(itemCategory);
		if (color == null)
			color = "#FFFFFF";

		out.println("<td><a href=\"product.jsp?id="+id+"\"<font color=\"" + color + "\">" + rst.getString(2) + "</font></td>"
				+ "<td><font color=\"" + color + "\">" + itemCategory + "</font></td>"
				+ "<td><font color=\"" + color + "\">" + currFormat.format(rst.getDouble(3))
				+ "</font></td></tr>");
	}
	out.println("</table></font>");
	closeConnection();
} catch (SQLException ex) {
	out.println(ex);
}
%>

</body>
</html>
