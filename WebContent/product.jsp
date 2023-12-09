<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>GameVault - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
	body {
		background-color: black;
		color: white;
	}
</style>
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
String productId = request.getParameter("id");

String sql = "SELECT productId, productName, productPrice, productImageURL, productImage, productDesc FROM Product P  WHERE productId = ?";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{
	getConnection();
	Statement stmt = con.createStatement(); 			
	stmt.execute("USE orders");
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(productId));			
	
	ResultSet rst = pstmt.executeQuery();
			
	if (!rst.next())
	{
		out.println("Invalid product");
	}
	else
	{		
		out.println("<u><b><h2>"+rst.getString(2)+"</u></b></h2>");
		
		int prodId = rst.getInt(1);
		
		//  Retrieve any image with a URL
		String imageLoc = rst.getString(4);
		if (imageLoc != null)
			out.println("<img src=\""+ imageLoc +"\" width=600px>");
		
		// Retrieve any image stored directly in database
		String imageBinary = rst.getString(5);
		if (imageBinary != null){
			out.println("<img src=\"displayImage.jsp?id="+prodId+"\">");	
		}

		out.println("<b><br><br>Id:</b> " + prodId + "<br>"				
		+ "<b>Price: </b>" + currFormat.format(rst.getDouble(3)) + "<br>"
		+ "<b>Description: </b>" + rst.getString(6) + "<br>");
		
		out.println("</table>");
		

		out.println("<h3><a href=\"addcart.jsp?id="+prodId+ "&name=" + rst.getString(2)
								+ "&price=" + rst.getDouble(3)+"\">Add to Cart</a></h3>");		
		
		out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a>");
	}
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}
%>

</body>
</html>
