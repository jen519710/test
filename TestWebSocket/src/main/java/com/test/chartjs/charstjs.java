package com.test.chartjs;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/charstjs")
public class charstjs extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		 Calendar calendar = Calendar.getInstance();
		 int month = calendar.get(Calendar.MONTH)+1;
		 
		 int firstMonth=0;
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection conn = DriverManager.getConnection(
					"jdbc:sqlserver://localhost:1433;encrypt=true;databaseName=Hibernate;user=sa;password=123456;TrustServerCertificate=true");
			ArrayList<Integer> netAl = new ArrayList<Integer>();
			String sql2 = "  select  top 6 Year(costDate) as [year],Month(costDate) as [month]from [cost] "
					+ "  group by Year(costDate) ,Month(costDate)"
					+ "  order by Year(costDate)desc ,Month(costDate) desc";
			PreparedStatement ps=conn.prepareStatement(sql2);
			ResultSet rs = ps.executeQuery();
			
			ArrayList<Integer> monSix = new ArrayList<Integer>();
			ArrayList<Integer> yearSix = new ArrayList<Integer>();
			while(rs.next()) {
				System.out.println(rs.getInt("year")+"/"+rs.getInt("month"));
				monSix.add(rs.getInt("month"));
				yearSix.add(rs.getInt("year"));
			}
		
			
			for (int i = 0; i <6; i++) {
				String sql = "select * from [cost] where Month(costDate)=? and Year(costDate)=?";
				String sql1 = "select * from [income] where Month(incomeDate)=? and Year(incomeDate)=?";
				
				ps = conn.prepareStatement(sql);
				ps.setInt(1, monSix.get(i));
				ps.setInt(2, yearSix.get(i));
				rs = ps.executeQuery();
				int cost = 0;
				while (rs.next()) {
					int costPrice = rs.getInt("costPrice");
					int costNum = rs.getInt("costNum");
					cost = cost + costPrice * costNum;
				}
				ps = conn.prepareStatement(sql1);
				ps.setInt(1, monSix.get(i));
				ps.setInt(2, yearSix.get(i));
				rs = ps.executeQuery();
				
				int income = 0;
				while (rs.next()) {
					int incomePrice = rs.getInt("incomePrice");
					income = income + incomePrice;
				}
				System.out.println(monSix.get(i)+"income"+income+"cost"+cost);
				int net = income - cost;
				System.out.println(net);
				
				netAl.add(net);
				
				rs.close();

				ps.close();
				
			}
			request.setAttribute("yearSix", yearSix);
			request.setAttribute("monSix", monSix);
			request.setAttribute("netAl",netAl);
			 request.getRequestDispatcher("/searchtesrt.jsp").forward(request, response);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
